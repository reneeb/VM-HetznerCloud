#!/usr/bin/env perl

# PODNAME: get_hcloud_info.pl
# ABSTRACT: get API definitions from docs.hetzner.cloud

use v5.20;

use strict;
use warnings;

use Mojo::UserAgent;
use Mojo::Util qw(dumper);
use Data::Dumper;
use File::Basename;
use File::Spec;

my $ua   = Mojo::UserAgent->new;
my $url  = 'https://docs.hetzner.cloud';
my $base = 'https://api.hetzner.cloud/v1/';

my $tx  = $ua->get( $url );
my $dom = $tx->res->dom;

my %resources;

my $current_resource;
$dom->find('section.method')->each( sub {
    my $description_div = $_->find('div.method__description')->first;
    my $tmp_resource    = $description_div->find('h2')->first;

    if ( $tmp_resource ) {   
        $current_resource = $tmp_resource->attr('id');
        return;
    }

    if ( !$current_resource || $current_resource eq 'overview' ) {
        return;
    }

    my $description = $description_div->find('h3')->first->text;

    my $uri_text                  = $description_div->children('code')->first->text;
    my ($method, $endpoint, $uri) = $uri_text =~ m{([A-Z]+) \s+ \Q$base\E /? (\w+) (.*) \s* \z}xms;

    $uri //= '';
    $uri =~ s/\{\?.*\}\z//;
    $uri =~ s/\{ (\w+) \}/:$1/xg;

    $endpoint =~ s{s\z}{};
    my $perl_class = join "", map { ucfirst lc $_ } split /_/, $endpoint;

    my $verb = lc $method;
    $verb    = 'create' if $verb eq 'post';
    $verb    = 'update' if $verb eq 'put';

    my @parts = split /\//, $uri;

    my $action_name = $verb;

    my $action = pop @parts;
    if ( !$action ) {
        $action_name = 'list' if $method eq 'GET';
    }
    elsif ( $action eq 'actions' ) {
        $action_name = 'get_actions';
    }
    elsif ( ':' ne substr $action, 0, 1 ) {
        $action_name = $action;
    }
    elsif ( $action eq ':action_id' ) {
        $action_name = 'get_action';
    }


    my %params;
    for my $header ( 'URI Parameters', 'Request' ) {
        _get_parameters( $header, $_, \%params );
    }

    $resources{$perl_class}->{$action_name} = {
        type        => lc $method,
        uri         => $uri,
        endpoint    => $endpoint,
        description => $description,
        %params,
    };
});

#say Dumper( \%resources );

for my $class ( keys %resources ) {
    say "Build class $class.pm";
    my $def = $resources{$class};

    my $code = _get_code( $class, $def );
    my $path = File::Spec->catfile(
        dirname( __FILE__ ),
        qw/.. lib VM HetznerCloud API/,
        "$class.pm"
    );

    my $fh = IO::File->new( $path, 'w' );
    $fh->print( $code );
    $fh->close;
}

sub _get_parameters {
    my ($header, $object, $params) = @_;

    my $head_node = $object->find( 'h4')->grep( sub {
        $_->text eq $header;
    })->first;

    return if !$head_node;

    my $table = $head_node->following('div.table-wrapper')->first;

    return if !$table;

    $table->find('table tbody tr')->each( sub {
         my ($name, $type, $desc) = map{ $_->text }@{ $_->find('td')->to_array };

         my ($type_name, $type_required) = $type =~ m{\A\s* (.*?) (?:\s \((required|optional)\) \s* )? \z}x;
         my $man_opt   = $type_required =~ m{required} ? 'required' : 'optional';
         my @types     = split /\s*,\s*/, $type_name;
         my $type_info = @types > 1 ? [ @types ] : $types[0];
         $params->{$man_opt}->{$name} = $type_info;
    });
}

sub _get_code {
    my ($class, $definitions) = @_;

    my $methods_pod = '';
    my $endpoint    = '';
    my $method_name = '';
    my $obj_method  = '';
    my $subs        = '';

    for my $method ( sort keys %{ $definitions } ) {
        $endpoint       = delete $definitions->{$method}->{endpoint};
        my $description = delete $definitions->{$method}->{description};
        $obj_method     = $endpoint =~ s{s\z}{}r;
        $method_name  ||= $method;

        my $params = '{';

        TYPE:
        for my $type ( qw/required optional/ ) {

            next TYPE if !exists $definitions->{$method}->{$type};

            my $type_param = $definitions->{$method}->{$type} || {};
            my $method     = $type eq 'required' ? '->required' : '';

            for my $param ( sort keys %{ $type_param } ) {
                $params .= sprintf "\n        '%s' => joi%s->%s,", $param, $method, $type_param->{$param};
            }
        }

        $params .= "\n    };\n";

        $methods_pod .= sprintf q~

=head2 %s

%s

    $cloud->%s->%s(%s);
~,
        $method, $description, $obj_method, $method, $params;

        $subs .= sprintf q~
sub %s ($self, %%params) {
    my $spec   = %s
    my @errors = joi(
        \%%params,
        joi->object->props( $spec ),
    );

    if ( @errors ) {
        croak 'invalid parameters';
    }

    my %%request_params = map{
        exists $params{$_} ?
            ($_ => $params{$_}) :
            ();
    } keys %%{$spec},

    $self->request(
        '%s',
        '%s',
        \%%request_params
    );
}
~, $method, $params, $definitions->{$method}->{type}, $definitions->{$method}->{uri};
    }

    my $pod = sprintf q~

=head1 SYNOPSIS

    use VM::HetznerCloud;

    my $api_key = '1234abc';
    my $cloud   = VM::HetznerCloud->new(
        token => $api_key,
    );

    $cloud->%s->%s(
    );

=head1 ATTRIBUTES

=over 4

=item * endpoint

=back

=head1 METHODS

%s
~,
    $obj_method, $method_name, $methods_pod;

    my $code = sprintf q~package VM::HetznerCloud::API::%s;

# ABSTRACT: %s

use v5.10;

use strict;
use warnings;

use Moo;
use Types::Standard qw(:all);

use Mojo::Base -strict, -signatures;

use parent 'VM::HetznerCloud';;

with 'VM::HetznerCloud::Utils';
with 'MooX::Singleton';

use JSON::Validator qw(joi);
use Carp;

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
