#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;

use_ok 'VM::HetznerCloud';

my $cloud = VM::HetznerCloud->new(
    token => 'abc123',
);

isa_ok $cloud, 'VM::HetznerCloud';
can_ok $cloud, qw/request token base_uri version server client/;

my $client = $cloud->client;
isa_ok $client, 'REST::Client';

# do some fake requests

done_testing();
