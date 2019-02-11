package VM::HetznerCloud::Server;

# ABSTRACT: Server

use v5.10;

use strict;
use warnings;

use Moo;
use Types::Mojo qw(MojoURL);

use parent 'VM::HetznerCloud::Utils';

has base   => ( is => 'ro', required => 1, isa => MojoURL["https?"] );
has mapping => ( is => 'ro', default => sub {
+{
  'attach_iso' => {
    'required' => {
      'id' => 'string'
    },
    'type' => 'post',
    'uri' => '/:id/actions/attach_iso'
  },
  'change_dns_ptr' => {
    'required' => {
      'id' => 'string'
    },
    'type' => 'post',
    'uri' => '/:id/actions/change_dns_ptr'
  },
  'change_protection' => {
    'required' => {
      'id' => 'string'
    },
    'type' => 'post',
    'uri' => '/:id/actions/change_protection'
  },
  'change_type' => {
    'required' => {
      'id' => 'string'
    },
    'type' => 'post',
    'uri' => '/:id/actions/change_type'
  },
  'create' => {
    'type' => 'post',
    'uri' => ''
  },
  'create_image' => {
    'required' => {
      'id' => 'string'
    },
    'type' => 'post',
    'uri' => '/:id/actions/create_image'
  },
  'delete' => {
    'required' => {
      'id' => 'string'
    },
    'type' => 'delete',
    'uri' => '/:id'
  },
  'detach_iso' => {
    'required' => {
      'id' => 'string'
    },
    'type' => 'post',
    'uri' => '/:id/actions/detach_iso'
  },
  'disable_backup' => {
    'required' => {
      'id' => 'string'
    },
    'type' => 'post',
    'uri' => '/:id/actions/disable_backup'
  },
  'disable_rescue' => {
    'required' => {
      'id' => 'string'
    },
    'type' => 'post',
    'uri' => '/:id/actions/disable_rescue'
  },
  'enable_backup' => {
    'required' => {
      'id' => 'string'
    },
    'type' => 'post',
    'uri' => '/:id/actions/enable_backup'
  },
  'enable_rescue' => {
    'required' => {
      'id' => 'string'
    },
    'type' => 'post',
    'uri' => '/:id/actions/enable_rescue'
  },
  'get' => {
    'required' => {
      'id' => 'string'
    },
    'type' => 'get',
    'uri' => '/:id'
  },
  'get_action' => {
    'required' => {
      'action_id' => 'string',
      'id' => 'string'
    },
    'type' => 'get',
    'uri' => '/:id/actions/:action_id'
  },
  'get_actions' => {
    'optional' => {
      'sort' => 'enum[string]',
      'status' => 'enum[string]'
    },
    'required' => {
      'id' => 'string'
    },
    'type' => 'get',
    'uri' => '/:id/actions'
  },
  'list' => {
    'optional' => {
      'label_selector' => 'string',
      'name' => 'string'
    },
    'type' => 'get',
    'uri' => ''
  },
  'metrics' => {
    'optional' => {
      'step' => 'number'
    },
    'required' => {
      'end' => 'string',
      'id' => 'string',
      'start' => 'string',
      'type' => 'string'
    },
    'type' => 'get',
    'uri' => '/:id/metrics'
  },
  'poweroff' => {
    'required' => {
      'id' => 'string'
    },
    'type' => 'post',
    'uri' => '/:id/actions/poweroff'
  },
  'poweron' => {
    'required' => {
      'id' => 'string'
    },
    'type' => 'post',
    'uri' => '/:id/actions/poweron'
  },
  'reboot' => {
    'required' => {
      'id' => 'string'
    },
    'type' => 'post',
    'uri' => '/:id/actions/reboot'
  },
  'rebuild' => {
    'required' => {
      'id' => 'string'
    },
    'type' => 'post',
    'uri' => '/:id/actions/rebuild'
  },
  'request_console' => {
    'required' => {
      'id' => 'string'
    },
    'type' => 'post',
    'uri' => '/:id/actions/request_console'
  },
  'reset' => {
    'required' => {
      'id' => 'string'
    },
    'type' => 'post',
    'uri' => '/:id/actions/reset'
  },
  'reset_password' => {
    'required' => {
      'id' => 'string'
    },
    'type' => 'post',
    'uri' => '/:id/actions/reset_password'
  },
  'shutdown' => {
    'required' => {
      'id' => 'string'
    },
    'type' => 'post',
    'uri' => '/:id/actions/shutdown'
  },
  'update' => {
    'required' => {
      'id' => 'string'
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
        'server',
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
        token => $api_key,
    );

    $cloud->server->attach_iso(
    );

=head1 METHODS



=head2 attach_iso

Attach an ISO to a Server

    $cloud->server->attach_iso();


=head2 change_dns_ptr

Change reverse DNS entry for this server

    $cloud->server->change_dns_ptr();


=head2 change_protection

Change protection for a Server

    $cloud->server->change_protection();


=head2 change_type

Change the Type of a Server

    $cloud->server->change_type();


=head2 create

Create a Server

    $cloud->server->create();


=head2 create_image

Create Image from a Server

    $cloud->server->create_image();


=head2 delete

Delete a Server

    $cloud->server->delete();


=head2 detach_iso

Detach an ISO from a Server

    $cloud->server->detach_iso();


=head2 disable_backup

Disable Backups for a Server

    $cloud->server->disable_backup();


=head2 disable_rescue

Disable Rescue Mode for a Server

    $cloud->server->disable_rescue();


=head2 enable_backup

Enable and Configure Backups for a Server

    $cloud->server->enable_backup();


=head2 enable_rescue

Enable Rescue Mode for a Server

    $cloud->server->enable_rescue();


=head2 get

Get a Server

    $cloud->server->get();


=head2 get_action

Get a specific Action for a Server

    $cloud->server->get_action();


=head2 get_actions

Get all Actions for a Server

    $cloud->server->get_actions(
        sort => enum[string],     # optional
        status => enum[string],     # optional
    );


=head2 list

Get all Servers

    $cloud->server->list(
        label_selector => string,     # optional
        name => string,     # optional
    );


=head2 metrics

Get Metrics for a Server

    $cloud->server->metrics(
        step => number,     # optional
    );


=head2 poweroff

Power off a Server

    $cloud->server->poweroff();


=head2 poweron

Power on a Server

    $cloud->server->poweron();


=head2 reboot

Soft-reboot a Server

    $cloud->server->reboot();


=head2 rebuild

Rebuild a Server from an Image

    $cloud->server->rebuild();


=head2 request_console

Request Console for a Server

    $cloud->server->request_console();


=head2 reset

Reset a Server

    $cloud->server->reset();


=head2 reset_password

Reset root Password of a Server

    $cloud->server->reset_password();


=head2 shutdown

Shutdown a Server

    $cloud->server->shutdown();


=head2 update

Update a Server

    $cloud->server->update();


    