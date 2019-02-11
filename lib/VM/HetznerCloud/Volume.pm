package VM::HetznerCloud::Volume;

# ABSTRACT: Volume

use v5.10;

use strict;
use warnings;

use Moo;
use Types::Mojo qw(MojoURL);

use parent 'VM::HetznerCloud::Utils';

has base   => ( is => 'ro', required => 1, isa => MojoURL["https?"] );
has mapping => ( is => 'ro', default => sub {
+{
  'attach' => {
    'required' => {
      'id' => 'string'
    },
    'type' => 'post',
    'uri' => '/:id/actions/attach'
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
  'detach' => {
    'required' => {
      'id' => 'string'
    },
    'type' => 'post',
    'uri' => '/:id/actions/detach'
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
  'resize' => {
    'required' => {
      'id' => 'string'
    },
    'type' => 'post',
    'uri' => '/:id/actions/resize'
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
        'volume',
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

    $cloud->volume->attach(
    );

=head1 METHODS



=head2 attach

Attach Volume to a Server

    $cloud->volume->attach();


=head2 change_protection

Change Volume Protection

    $cloud->volume->change_protection();


=head2 create

Create a Volume

    $cloud->volume->create();


=head2 delete

Delete a Volume

    $cloud->volume->delete();


=head2 detach

Detach Volume

    $cloud->volume->detach();


=head2 get

Get a Volume

    $cloud->volume->get();


=head2 get_action

Get an Action for a Volume

    $cloud->volume->get_action();


=head2 get_actions

Get all Actions for a Volume

    $cloud->volume->get_actions(
        sort => enum[string],     # optional
        status => enum[string],     # optional
    );


=head2 list

Get all Volumes

    $cloud->volume->list(
        label_selector => string,     # optional
    );


=head2 resize

Resize Volume

    $cloud->volume->resize();


=head2 update

Update a Volume

    $cloud->volume->update();


    