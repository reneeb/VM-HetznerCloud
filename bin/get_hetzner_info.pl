#!/usr/bin/env perl

=encoding utf-8

=cut

# PODNAME: get_hetzner_info.pl
# ABSTRACT: get API definitions from docs.hetzner.cloud

use v5.24;

use Mojo::Base -strict, -signatures;

use Encode;
use Mojo::File qw(path curfile);
use Mojo::JSON qw(decode_json encode_json);
use Mojo::UserAgent;
use Mojo::Util qw(dumper decamelize camelize);
use Mojo::URL;
use Data::Printer;
use Data::Dumper::Perltidy;
use JSON::XS ();

$Data::Dumper::Sortkeys = 1;
$Data::Dumper::Trailingcomma = 1;
#$Data::Dumper::Purity = 1;
$Data::Dumper::Deepcopy = 1;

my $ua   = Mojo::UserAgent->new;
my $url  = 'https://docs.hetzner.cloud';

my $tx        = $ua->get( $url );
my $dom       = $tx->res->dom;
my $scripts = $dom->find('script#__NEXT_DATA__')->first;

my $api_json = decode_json( encode_utf8 $scripts->content )->{props}->{pageProps}->{api}->{paths};

# create schema class
my $path = curfile->dirname->child(
    qw/.. lib VM HetznerCloud/,
    "Schema.pm"
);

my $schema_package = _get_schema_package( $path, $api_json );
my $fh = $path->open('>');
$fh->print($schema_package);
$fh->close;

my @paths = sort keys $api_json->%*;

my %classes;
APIPATH:
for my $api_path ( @paths ) {
    my $parts = path( $api_path )->to_array;
    shift $parts->@*;

    my $name  = shift $parts->@*;
    my $class = camelize $name;

    my $subtree = $api_json->{$api_path};
    $subtree->{path} = $api_path;
    $subtree->{parts} = $parts;

    $classes{$class} //= {
        endpoint => $name,
    };

    push $classes{$class}->{defs}->@*, $subtree;
}

for my $class ( keys %classes ) {
    say "Build class $class.pm";
    my $def = $classes{$class};

    my $code = _get_code( $class, $def );

    my $path = curfile->dirname->child(
        qw/.. lib VM HetznerCloud API/,
        "$class.pm"
    );

    my $fh = $path->open('>');
    $fh->print( $code );
    $fh->close;
}

sub _get_code ($class, $definitions) {
    my $endpoint    = $definitions->{endpoint};
    my $subs        = '';
    my $methods_pod = '';

    for my $subdef ( $definitions->{defs}->@* ) {
        my $uri  = join '/', '', $subdef->{parts}->@*;
        $uri =~ s/\{(.*?)\}/:$1/g;

        METHOD:
        for my $method ( sort keys $subdef->%* ) {
            my ($method_def) = $subdef->{$method};

            next METHOD if 'HASH' ne ref $method_def;

            my $operation_id = delete $method_def->{operationId};
            delete @{ $method_def }{qw/responses x-code-samples summary tags/};
        
            my $description = delete $method_def->{description};
            my ($sub, $method_name) = _get_sub( $operation_id, $method, $endpoint, $uri );
            my $pod                 = _get_pod( $method_name, $description, $class, $endpoint );

            $subs        .= $sub;
            $methods_pod .= $pod;
        }
    }

    my $pod = sprintf q~
=head1 SYNOPSIS

    use VM::HetznerCloud;

    my $api_key = '1234abc';
    my $cloud   = VM::HetznerCloud->new(
        token => $api_key,
    );

    $cloud->records->create(
    );

=head1 ATTRIBUTES

=over 4

=item * endpoint

=back

=head1 METHODS

%s
~, $methods_pod;

    my $code = sprintf q~package VM::HetznerCloud::API::%s;

# ABSTRACT: %s

# ---
# This class is auto-generated by bin/get_hetzner_info.pl
# ---

use v5.24;

use Moo;
use Types::Standard qw(:all);

use Mojo::Base -strict, -signatures;

extends 'VM::HetznerCloud::APIBase';

with 'MooX::Singleton';

use VM::HetznerCloud::Schema;

# VERSION

has endpoint  => ( is => 'ro', isa => Str, default => sub { '%s' } );
%s

1;

__END__

=pod

%s
    ~,
    $class, $class, $endpoint, $subs, $pod;

    return $code;
}

sub _get_sub ( $operation_id, $method, $class, $uri ) {
    my $method_name = decamelize $operation_id;

    $method_name = 'list' if $method_name eq 'get_' . $class;
    
    $class =~ s{s\z}{};
    $method_name =~ s{_${class}s?}{};

    my $sub = sprintf q~
sub %s ($self, %%params) {
    return $self->_do( '%s', \%%params, '%s', { type => '%s' } );
}
~, $method_name, $operation_id, $uri, $method;

    return ($sub, $method_name);
}

sub _get_pod ( $method, $description, $object, $endpoint, $params = '') {
    my $pod = sprintf q~

=head2 %s

%s

    $cloud->%s->%s(%s);
~,
        $method, $description, $endpoint, $method, $params;

    return $pod;
}

sub _get_schema_package ( $path, $data ) {
    my ($code) = split /__DATA__/, $path->slurp;
    $code .= sprintf q!
__DATA__
@@ paths.json
%s
!, JSON::XS->new->canonical(1)->utf8(1)->pretty(1)->encode( $data );

    return $code;
}
