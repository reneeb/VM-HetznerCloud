package VM::HetznerCloud;

use v5.10;

use Moo;
use REST::Client;
use JSON;

use VM::HetznerCloud::Server;
#use VM::HetznerCloud::IP;
#use VM::HetznerCloud::Key;
#use VM::HetznerCloud::Location;
#use VM::HetznerCloud::Datacenter;
#use VM::HetznerCloud::Images;
#use VM::HetznerCloud::ISO;
#use VM::HetznerCloud::Price;

has token    => ( is => 'ro', required => 1 );
has host     => ( is => 'ro', default => sub { 'https://api.hetzner.cloud' } );
has base_uri => ( is => 'ro', default => sub { 'v1' } );

has server => ( is => 'ro', lazy => 1, default => sub { VM::HetznerCloud::Server->new( base => shift ); } );
has ip     => ( is => 'ro', lazy => 1, default => sub { VM::HetznerCloud::IP->new( base => shift ); } );
has key    => ( is => 'ro', lazy => 1, default => sub { VM::HetznerCloud::Key->new( base => shift ); } );

has client   => (
    is      => 'ro',
    lazy    => 1,
    default => sub {
        my $self   = shift;
        my $client = REST::Client->new(
            host => $self->host,
        );

        $client;
    }
);

sub request {
    my $self        = shift;
    my $partial_uri = shift;
    my %opts        = @_;

    my $method = uc $opts{type} // 'GET';
    my $uri    = sprintf "%s/%s", $self->base_uri, $partial_uri;

    my $client = $self->client;

    $client->addHeader('Authorization', 'Bearer ' . $self->token );
    $client->request(
        $method,
        $uri,
        delete $opts{body},
        \%opts,
    );

    my $response = $client->responseContent();

    return if !$response;

    my $data = JSON->new->utf8(1)->decode( $reponse );
    return $data;
}

1;
