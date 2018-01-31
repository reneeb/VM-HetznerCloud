#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;

use VM::HetznerCloud;

my $cloud = VM::HetznerCloud->new(
    token => 'abc123',
);

my $client = $cloud->server;
isa_ok $client, 'VM::HetznerCloud::Server';

my $server = $client->get();
my $server = $client->list();


done_testing();
