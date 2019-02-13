#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;

use VM::HetznerCloud;

use_ok 'VM::HetznerCloud::API::Server';

my $cloud = VM::HetznerCloud->new(
    token => 'abc123',
);
isa_ok $cloud, 'VM::HetznerCloud';

my $server = VM::HetznerCloud::API::Server->new(
    token => 'abc135',
);

isa_ok $server, 'VM::HetznerCloud::API::Server';

my $client = $cloud->server;
isa_ok $client, 'VM::HetznerCloud::API::Server';


done_testing();
