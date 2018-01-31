package VM::HetznerCloud::FloatingIp;

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
      'sort' => 'string'
    },
    'type' => 'get',
    'uri' => '/:id/actions'
  },
  'add' => {
    'mandatory' => {
      'type' => 'string'
    },
    'optional' => {
      'description' => 'string',
      'home_location' => 'string',
      'server' => 'number'
    },
    'type' => 'post',
    'uri' => ''
  },
  'assign' => {
    'mandatory' => {
      'id' => 'string',
      'server' => 'number'
    },
    'type' => 'post',
    'uri' => '/:id/actions/assign'
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
  'delete' => {
    'mandatory' => {
      'id' => 'string'
    },
    'type' => 'delete',
    'uri' => '/:id'
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
    'type' => 'get',
    'uri' => ''
  },
  'unassign' => {
    'mandatory' => {
      'id' => 'string'
    },
    'type' => 'post',
    'uri' => '/:id/actions/unassign'
  },
  'update' => {
    'mandatory' => {
      'id' => 'string'
    },
    'optional' => {
      'description' => 'string'
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
        'floating_ips',
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

    $cloud->floating_ip->action_list(
    );

=head1 METHODS



=head2 action_list

Get all Actions for a Floating IP

    $cloud->floating_ip->action_list(
        id => string,     # mandatory
        sort => string,     # optional
    )


=head2 add

Create a Floating IP

    $cloud->floating_ip->add(
        type => string,     # mandatory
        description => string,     # optional
        home_location => string,     # optional
        server => number,     # optional
    )


=head2 assign

Assign a Floating IP to a Server

    $cloud->floating_ip->assign(
        id => string,     # mandatory
        server => number,     # mandatory
    )


=head2 change_dns_ptr

Change reverse DNS entry for a Floating IP

    $cloud->floating_ip->change_dns_ptr(
        dns_ptr => ARRAY(0x3305f30),     # mandatory
        id => string,     # mandatory
        ip => string,     # mandatory
    )


=head2 delete

Delete a Floating IP

    $cloud->floating_ip->delete(
        id => string,     # mandatory
    )


=head2 get

Get a specific Floating IP

    $cloud->floating_ip->get(
        id => string,     # mandatory
    )


=head2 get_action

Get an Action for a Floating IP

    $cloud->floating_ip->get_action(
        action_id => string,     # mandatory
        id => string,     # mandatory
    )


=head2 list

Get all Floating IPs

    $cloud->floating_ip->list()


=head2 unassign

Unassign a Floating IP

    $cloud->floating_ip->unassign(
        id => string,     # mandatory
    )


=head2 update

Change description of a Floating IP

    $cloud->floating_ip->update(
        id => string,     # mandatory
        description => string,     # optional
    )


    