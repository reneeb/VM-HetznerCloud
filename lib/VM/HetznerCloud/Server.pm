package VM::HetznerCloud::Server;

# ABSTRACT:

use v5.10;

use strict;
use warnings;

use Moo;

use parent 'VM::HetznerCloud::Utils';

has base   => ( is => 'ro', required => 1, isa => sub {} );
has mapping => ( is => 'ro', default => sub {
+{
  'action_list' => {
    'mandatory' => {
      'id' => 'string'
    },
    'optional' => {
      'sort' => 'string',
      'status' => 'string'
    },
    'type' => 'get',
    'uri' => '/:id/actions'
  },
  'attach_iso' => {
    'mandatory' => {
      'id' => 'string',
      'iso' => 'string'
    },
    'type' => 'post',
    'uri' => '/:id/actions/attach_iso'
  },
  'change_dns_ptr' => {
    'mandatory' => {
      'dns_ptr' => [
        'string',
        'null'
      ],
      'id' => 'string',
      'ip' => 'string'
    },
    'type' => 'post',
    'uri' => '/:id/actions/change_dns_ptr'
  },
  'change_type' => {
    'mandatory' => {
      'id' => 'string',
      'server_type' => 'string'
    },
    'optional' => {
      'upgrade_disk' => 'boolean'
    },
    'type' => 'post',
    'uri' => '/:id/actions/change_type'
  },
  'create' => {
    'mandatory' => {
      'image' => 'string',
      'name' => 'string',
      'server_type' => 'string'
    },
    'optional' => {
      'datacenter' => 'string',
      'location' => 'string',
      'ssh_keys' => 'array',
      'start_after_create' => 'boolean',
      'user_data' => 'string'
    },
    'type' => 'post',
    'uri' => ''
  },
  'create_image' => {
    'mandatory' => {
      'id' => 'string'
    },
    'optional' => {
      'description' => 'string',
      'type' => 'string'
    },
    'type' => 'post',
    'uri' => '/:id/actions/create_image'
  },
  'delete' => {
    'mandatory' => {
      'id' => 'string'
    },
    'type' => 'delete',
    'uri' => '/:id'
  },
  'detach_iso' => {
    'mandatory' => {
      'id' => 'string'
    },
    'type' => 'post',
    'uri' => '/:id/actions/detach_iso'
  },
  'disable_backup' => {
    'mandatory' => {
      'id' => 'string'
    },
    'type' => 'post',
    'uri' => '/:id/actions/disable_backup'
  },
  'disable_rescue' => {
    'mandatory' => {
      'id' => 'string'
    },
    'type' => 'post',
    'uri' => '/:id/actions/disable_rescue'
  },
  'enable_backup' => {
    'mandatory' => {
      'id' => 'string'
    },
    'optional' => {
      'backup_window' => 'string'
    },
    'type' => 'post',
    'uri' => '/:id/actions/enable_backup'
  },
  'enable_rescue' => {
    'mandatory' => {
      'id' => 'string'
    },
    'optional' => {
      'ssh_keys' => 'array',
      'type' => 'string'
    },
    'type' => 'post',
    'uri' => '/:id/actions/enable_rescue'
  },
  'get' => {
    'mandatory' => {
      'id' => 'string'
    },
    'type' => 'get',
    'uri' => '/:id'
  },
  'get_action' => {
    'mandatory' => {
      'action_id' => 'string',
      'id' => 'string'
    },
    'type' => 'get',
    'uri' => '/:id/actions/:action_id'
  },
  'list' => {
    'optional' => {
      'name' => 'string'
    },
    'type' => 'get',
    'uri' => ''
  },
  'metrics' => {
    'mandatory' => {
      'end' => 'string',
      'id' => 'string',
      'start' => 'string',
      'type' => 'string'
    },
    'optional' => {
      'step' => 'number'
    },
    'type' => 'get',
    'uri' => '/:id/metrics'
  },
  'poweroff' => {
    'mandatory' => {
      'id' => 'string'
    },
    'type' => 'post',
    'uri' => '/:id/actions/poweroff'
  },
  'poweron' => {
    'mandatory' => {
      'id' => 'string'
    },
    'type' => 'post',
    'uri' => '/:id/actions/poweron'
  },
  'reboot' => {
    'mandatory' => {
      'id' => 'string'
    },
    'type' => 'post',
    'uri' => '/:id/actions/reboot'
  },
  'rebuild' => {
    'mandatory' => {
      'id' => 'string',
      'image' => 'string'
    },
    'type' => 'post',
    'uri' => '/:id/actions/rebuild'
  },
  'reset' => {
    'mandatory' => {
      'id' => 'string'
    },
    'type' => 'post',
    'uri' => '/:id/actions/reset'
  },
  'reset_password' => {
    'mandatory' => {
      'id' => 'string'
    },
    'type' => 'post',
    'uri' => '/:id/actions/reset_password'
  },
  'shutdown' => {
    'mandatory' => {
      'id' => 'string'
    },
    'type' => 'post',
    'uri' => '/:id/actions/shutdown'
  },
  'update' => {
    'mandatory' => {
      'id' => 'string'
    },
    'optional' => {
      'name' => 'string'
    },
    'type' => 'put',
    'uri' => '/:id'
  }
};
;
});

around new => sub {
    my $orig  = shift;
    my $class = shift;

    my $self = $orig->( @_ );
    $self->_build(
        __PACKAGE__,
        'servers',
    );

    return $self;
};

1;

__END__

=pod



=head1 SYNOPSIS

    use VM::HetznerCloud;

    my $api_key = '1234abc';
    my $cloud   = VM::HetznerCloud->new(
        api_key => $api_key,
    );

    $cloud->server->action_list(
    );

=head1 METHODS



=head2 action_list

Get all Actions for a Server

    $cloud->server->action_list(
        id => string,     # mandatory
        sort => string,     # optional
        status => string,     # optional
    )


=head2 attach_iso

Attach an ISO to a Server

    $cloud->server->attach_iso(
        id => string,     # mandatory
        iso => string,     # mandatory
    )


=head2 change_dns_ptr

Change reverse DNS entry for this server

    $cloud->server->change_dns_ptr(
        dns_ptr => ARRAY(0x3305468),     # mandatory
        id => string,     # mandatory
        ip => string,     # mandatory
    )


=head2 change_type

Change the Type of a Server

    $cloud->server->change_type(
        id => string,     # mandatory
        server_type => string,     # mandatory
        upgrade_disk => boolean,     # optional
    )


=head2 create

Create a Server

    $cloud->server->create(
        image => string,     # mandatory
        name => string,     # mandatory
        server_type => string,     # mandatory
        datacenter => string,     # optional
        location => string,     # optional
        ssh_keys => array,     # optional
        start_after_create => boolean,     # optional
        user_data => string,     # optional
    )


=head2 create_image

Create Image from a Server

    $cloud->server->create_image(
        id => string,     # mandatory
        description => string,     # optional
        type => string,     # optional
    )


=head2 delete

Delete a Server

    $cloud->server->delete(
        id => string,     # mandatory
    )


=head2 detach_iso

Detach an ISO from a Server

    $cloud->server->detach_iso(
        id => string,     # mandatory
    )


=head2 disable_backup

Disable Backups for a Server

    $cloud->server->disable_backup(
        id => string,     # mandatory
    )


=head2 disable_rescue

Disable Rescue Mode for a Server

    $cloud->server->disable_rescue(
        id => string,     # mandatory
    )


=head2 enable_backup

Enable and Configure Backups for a Server

    $cloud->server->enable_backup(
        id => string,     # mandatory
        backup_window => string,     # optional
    )


=head2 enable_rescue

Enable Rescue Mode for a Server

    $cloud->server->enable_rescue(
        id => string,     # mandatory
        ssh_keys => array,     # optional
        type => string,     # optional
    )


=head2 get

Get a Server

    $cloud->server->get(
        id => string,     # mandatory
    )


=head2 get_action

Get a specific Action for a Server

    $cloud->server->get_action(
        action_id => string,     # mandatory
        id => string,     # mandatory
    )


=head2 list

Get all Servers

    $cloud->server->list(
        name => string,     # optional
    )


=head2 metrics

Get Metrics for a Server

    $cloud->server->metrics(
        end => string,     # mandatory
        id => string,     # mandatory
        start => string,     # mandatory
        type => string,     # mandatory
        step => number,     # optional
    )


=head2 poweroff

Power off a Server

    $cloud->server->poweroff(
        id => string,     # mandatory
    )


=head2 poweron

Power on a Server

    $cloud->server->poweron(
        id => string,     # mandatory
    )


=head2 reboot

Soft-reboot a Server

    $cloud->server->reboot(
        id => string,     # mandatory
    )


=head2 rebuild

Rebuild a Server from an Image

    $cloud->server->rebuild(
        id => string,     # mandatory
        image => string,     # mandatory
    )


=head2 reset

Reset a Server

    $cloud->server->reset(
        id => string,     # mandatory
    )


=head2 reset_password

Reset root Password of a Server

    $cloud->server->reset_password(
        id => string,     # mandatory
    )


=head2 shutdown

Shutdown a Server

    $cloud->server->shutdown(
        id => string,     # mandatory
    )


=head2 update

Change Name of a Server

    $cloud->server->update(
        id => string,     # mandatory
        name => string,     # optional
    )


    