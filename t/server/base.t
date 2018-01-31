#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;

use VM::HetznerCloud;

use_ok 'VM::HetznerCloud::Server';

my $cloud = VM::HetznerCloud->new(
    token => 'abc123',
);

my $server = VM::HetznerCloud::Server->new( base => $cloud );
isa_ok $server, 'VM::HetznerCloud';

my $client = $cloud->server;
isa_ok $client, 'VM::HetznerCloud::Server';


done_testing();
