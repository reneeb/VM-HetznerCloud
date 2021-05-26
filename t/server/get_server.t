#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;

use VM::HetznerCloud;

use Data::Printer;

my $cloud = VM::HetznerCloud->new(
    token => $ENV{HETZNER_CLOUD_TOKEN} // 'abc123',
);

my $client = $cloud->servers;
isa_ok $client, 'VM::HetznerCloud::API::Servers';

is $client->token, $ENV{HETZNER_CLOUD_TOKEN} // 'abc123';
is $client->token, $cloud->token;
is $client->host, $cloud->host;
is $client->base_uri, $cloud->base_uri;

my $server = $client->get( id => "3944327" );
my $server_list = $client->list();

#print np $server;
#print np $server_list;

done_testing();
