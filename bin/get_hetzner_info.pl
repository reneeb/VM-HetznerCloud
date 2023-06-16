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
my $scripts   = $dom->find('script#__NEXT_DATA__')->first;

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

for my $class ( sort keys %classes ) {
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
    #last;
}

sub _get_subnmame ( $parts, $method ) {
    my $all          = ( $parts->@* && $parts->[-1] =~ m{\{} ) ? 0 : 1;
    my @static_parts = grep { $_ !~ m/\{/ } $parts->@*;

    my $suffix = @static_parts ? ( join '_', '', @static_parts ) : '';

    if ( $all ) {
        return 'list' . $suffix   if $method eq 'get';
        return 'create' . $suffix if $method eq 'post';
    }

    return $method . $suffix;
}

sub _get_subparams ( $def ) {
    my $params = $def->{parameters} || [];

    my %subparams;
    for my $param ( $params->@* ) {
        my $name = $param->{name};

        my $validate = 'string';
        if ( $param->{schema} ) {
            $validate = $param->{schema}->{format} || $param->{schema}->{type};
        }

        $subparams{$name} = {
            in       => $param->{in},
            validate => $validate,
            required => $param->{required} + 0,
        };
    }

    return \%subparams;
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

            my $subname   = _get_subnmame( $subdef->{parts}, $method );
            my $subparams = _get_subparams( $method_def );

            delete @{ $method_def }{qw/responses x-code-samples summary tags/};
        
            my $description = delete $method_def->{description};
            my $sub = _get_sub( $subname, $method, $endpoint, $uri, $subparams );
            my $pod = _get_pod( $subname, $description, $class, $endpoint, $subparams );

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

sub _get_sub ( $method_name, $method, $class, $uri, $params ) {
    $class =~ s{s\z}{};

    my $dump = '{}';
    if ( $params->%* ) {
        $dump = Data::Dumper::Perltidy::Dumper( $params );
        $dump =~ s{^}{    }xmsg;
        #$dump =~ s{\};\s*\z}{    \}};
        $dump =~ s{\A        }{}xms;
        $dump =~ s{\s*\$VAR1\s*=\s*}{};
    }

    my $sub = sprintf q~
sub %s ($self, %%params) {
    my $request_params = %s;
    return $self->_request( '%s', \%%params, $request_params, { type => '%s' } );
}
~, $method_name, $dump, $uri, $method;

    return ($sub);
}

sub _get_pod ( $method, $description, $object, $endpoint, $params = {}) {
    my $params_list = '';
    if ( $params->%* ) {
        $params_list = "\n" .
            ( join "\n", map {
                "        $_ => 'test',"
            } sort keys $params->%* )
            . "\n    ";
    }

    my $pod = sprintf q~

=head2 %s

%s

    $cloud->%s->%s(%s);
~,
        $method, $description, $endpoint, $method, $params_list;

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
