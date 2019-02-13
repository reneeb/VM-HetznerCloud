package VM::HetznerCloud;

use v5.20;

# ABSTRACT: Perl library to work with the API for the Hetzner Cloud

use Moo;
use Mojo::UserAgent;

use Carp;
use Types::Mojo qw(:all);

use Mojo::Base -strict, -signatures;

with 'VM::HetznerCloud::API';

our $VERSION = 0.01;

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

__PACKAGE__->load_namespace;

sub request ($self, $partial_uri, %opts) {
    my $method = lc $opts{type} // 'get';
    my $sub    = $self->client->can($method);

    #$path =~ s{:(\w+)\b}{ delete $params->{$mandatory} }xmsge;
#    my $body  = JSON->new->utf8(1)->encode( \%req_params );
#    my $query = join '&', map{ $_ . '=' . uri_escape($req_params{$_}) }sort keys %req_params;

#    $path .= '?' . $query if $query;


    if ( !$sub ) {
        croak "Unsupported request method $method";
    }

    my $uri = sprintf "%s/%s", $self->base_uri, $partial_uri;

    my $tx = $self->client->$method(
        $uri,
        {
            Authorization => 'Bearer ' . $self->token,
        },
        delete $opts{body},
        \%opts,
    );

    my $response = $tx->res;

    return if $response->is_error;
    return $response->json;
}

1;

=head1 SYNOPSIS

=head1 ATTRIBUTES

=over 4

=item * base_uri

=item * client 

=item * host

=item * token

=back

=head1 METHODS

=head2 request
