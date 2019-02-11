package VM::HetznerCloud::FloatingIp;

# ABSTRACT: FloatingIp

use v5.10;

use strict;
use warnings;

use Moo;
use Types::Mojo qw(MojoURL);

use parent 'VM::HetznerCloud::Utils';

has base   => ( is => 'ro', required => 1, isa => MojoURL["https?"] );
has mapping => ( is => 'ro', default => sub {
+{
  'assign' => {
    'required' => {
      'id' => 'string'
    },
    'type' => 'post',
    'uri' => '/:id/actions/assign'
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
  'create' => {
    'type' => 'post',
    'uri' => ''
  },
  'delete' => {
    'required' => {
      'id' => 'string'
    },
    'type' => 'delete',
    'uri' => '/:id'
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
      'label_selector' => 'string'
    },
    'type' => 'get',
    'uri' => ''
  },
  'unassign' => {
    'required' => {
      'id' => 'string'
    },
    'type' => 'post',
    'uri' => '/:id/actions/unassign'
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
        'floating_ip',
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

    $cloud->floating_ip->assign(
    );

=head1 METHODS



=head2 assign

Assign a Floating IP to a Server

    $cloud->floating_ip->assign();


=head2 change_dns_ptr

Change reverse DNS entry for a Floating IP

    $cloud->floating_ip->change_dns_ptr();


=head2 change_protection

Change protection

    $cloud->floating_ip->change_protection();


=head2 create

Create a Floating IP

    $cloud->floating_ip->create();


=head2 delete

Delete a Floating IP

    $cloud->floating_ip->delete();


=head2 get

Get a specific Floating IP

    $cloud->floating_ip->get();


=head2 get_action

Get an Action for a Floating IP

    $cloud->floating_ip->get_action();


=head2 get_actions

Get all Actions for a Floating IP

    $cloud->floating_ip->get_actions(
        sort => enum[string],     # optional
        status => enum[string],     # optional
    );


=head2 list

Get all Floating IPs

    $cloud->floating_ip->list(
        label_selector => string,     # optional
    );


=head2 unassign

Unassign a Floating IP

    $cloud->floating_ip->unassign();


=head2 update

Update a Floating IP

    $cloud->floating_ip->update();


    