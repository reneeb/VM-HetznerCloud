#!/usr/bin/env perl

use strict;
use warnings;

use Test2::V0 -target => 'VM::HetznerCloud::API::Servers';

subtest 'can all required methods' => sub {
    my $client = $CLASS->new(
        token => 'abc135',
    );

    isa_ok $client, 'VM::HetznerCloud::API::Servers';

    my @methods = qw(
        list create
        get delete put
        list_actions actions_add_to_placement_group actions_attach_iso actions_attach_to_network
        actions_change_alias_ips actions_change_dns_ptr actions_change_protection actions_change_type
        actions_create_image actions_detach_from_network actions_detach_iso actions_disable_backup
        actions_disable_rescue actions_enable_backup actions_enable_rescue actions_poweroff
        actions_poweron actions_reboot actions_rebuild actions_remove_from_placement_group
        actions_request_console actions_reset actions_reset_password actions_shutdown
        get_actions
        list_metrics
    );

    can_ok $client, @methods;
};

subtest 'check attribute values' => sub {
    my $client = $CLASS->new(
        token => $ENV{HETZNER_CLOUD_TOKEN} // 'abc135',
    );

    is $client->token, $ENV{HETZNER_CLOUD_TOKEN} // 'abc123';
};


done_testing();
