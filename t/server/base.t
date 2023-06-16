#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;

use VM::HetznerCloud;

use_ok 'VM::HetznerCloud::API::Servers';

my $cloud = VM::HetznerCloud->new(
    token => 'abc123',
);
isa_ok $cloud, 'VM::HetznerCloud';

my $server = VM::HetznerCloud::API::Servers->new(
    token => 'abc135',
);

isa_ok $server, 'VM::HetznerCloud::API::Servers';

my $client = $cloud->servers;
isa_ok $client, 'VM::HetznerCloud::API::Servers';


done_testing();
