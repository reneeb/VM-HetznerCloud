#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;

use VM::HetznerCloud;
use t::lib::TestClient;

my $cloud = VM::HetznerCloud->new(
    token  => $ENV{HETZNER_CLOUD_TOKEN} // 'abc123',
    client => t::lib::TestClient->new,
);

my $client = $cloud->servers;
isa_ok $client, 'VM::HetznerCloud::API::Servers';

is $client->token, $ENV{HETZNER_CLOUD_TOKEN} // 'abc123';
is $client->token, $cloud->token;
is $client->host, $cloud->host;
is $client->base_uri, $cloud->base_uri;

my $server = $client->get( id => "3944327" );
my $server_list = $client->list();

is $server->{server}->{name}, 'my-resource';
is $server_list->{servers}->[0]->{name}, 'my-resource';

done_testing();
