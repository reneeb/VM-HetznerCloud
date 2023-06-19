#!/usr/bin/env perl

use strict;
use warnings;

use Test2::V0 -target => 'VM::HetznerCloud';

use t::lib::TestClient;

my $cloud = $CLASS->new(
    token  => $ENV{HETZNER_CLOUD_TOKEN} // 'abc123',
    client => t::lib::TestClient->new,
);

my $client = $cloud->servers;

subtest 'get list of servers' => sub {
    my $server_list = $client->list();
    is $server_list->{servers}->[0]->{name}, 'my-resource';
};

subtest 'get a single server' => sub {
    my $server = $client->get( id => "3944327" );
    is $server->{server}->{name}, 'my-resource';
};

done_testing();
