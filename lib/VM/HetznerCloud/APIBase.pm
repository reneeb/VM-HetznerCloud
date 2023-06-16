package VM::HetznerCloud::APIBase;

# ABSTRACT: Base class for all entity classes

use v5.24;

use Carp;
use Moo;
use Mojo::UserAgent;
use Mojo::Util qw(url_escape);
use Types::Mojo qw(:all);
use Types::Standard qw(Str);

use VM::HetznerCloud::Schema;

use Mojo::Base -strict, -signatures;

# VERSION

has token    => ( is => 'ro', isa => Str, required => 1 );
has host     => ( is => 'ro', isa => MojoURL["https?"], default => sub { 'https://api.hetzner.cloud' }, coerce => 1 );
has base_uri => ( is => 'ro', isa => Str, default => sub { 'v1' } );

has client   => (
    is      => 'ro',
    lazy    => 1,
    isa     => MojoUserAgent,
    default => sub {
        Mojo::UserAgent->new,
    }
);

sub _request ( $self, $partial_uri, $params = {}, $param_def = {}, $opts = {} ) {
    if ( $param_def->%* ) {
        $self->_validate( $params, $param_def );
    }

    my $method = delete $opts->{type} // 'get';
    my $sub    = $self->client->can(lc $method);

    if ( !$sub ) {
        croak sprintf 'Invalid request method %s', $method;
    }

    $partial_uri =~ s{:(?<mandatory>\w+)\b}{ delete $params->{$+{mandatory}} }xmsge;

    my %request_opts;
    if ( $params->%* ) {
        %request_opts = ( json => $params );
    }

    $opts->{query} //= {};
    my $query = '';
    if ( $opts->{query}->%* ) {
        my $query_params = delete $opts->{query};

        $query = join '&', map{ 
            $_ . '=' . uri_escape($query_params->{$_}) 
        }sort keys $query_params->%*;
    }

    $partial_uri .= '?' . $query if $query;

    my $uri = join '/', 
        $self->host, 
        $self->base_uri,
        $self->endpoint,
        $partial_uri;

    my $tx = $self->client->$method(
        $uri,
        {
            Authorization => 'Bearer ' . $self->token,
        },
        %request_opts,
    );

    my $response = $tx->res;

    say STDERR $tx->req->to_string if $ENV{VM_HETZNERCLOUD_DEBUG};
    say STDERR $tx->res->to_string if $ENV{VM_HETZNERCLOUD_DEBUG};

    return if $response->is_error;
    return $response->json;
}

sub _validate ( $self, $params, $def ) {
    for my $param ( sort keys $def->%* ) {
        if ( $def->{$param}->{required} && !length $params->{$param} ) {
            die "Mandatory parameter $param not set!";
        }

        if ( $def->{$param}->{validation} ) {
            my $error = $self->_validate_param( $params->{$param}, $def->{$param}->{validation} );
        }
    }

    return 1;
}

sub _validate_param ( $self, $value, $format ) {
    return if !$value;

    return;
}

1;