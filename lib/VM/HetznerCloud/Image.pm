package VM::HetznerCloud::Image;

# ABSTRACT: Image

use v5.10;

use strict;
use warnings;

use Moo;
use Types::Mojo qw(MojoURL);

use parent 'VM::HetznerCloud::Utils';

has base   => ( is => 'ro', required => 1, isa => MojoURL["https?"] );
has mapping => ( is => 'ro', default => sub {
+{
  'change_protection' => {
    'required' => {
      'id' => 'string'
    },
    'type' => 'post',
    'uri' => '/:id/actions/change_protection'
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
      'bound_to' => 'string',
      'label_selector' => 'string',
      'name' => 'string',
      'sort' => 'enum[string]',
      'type' => 'enum[string]'
    },
    'type' => 'get',
    'uri' => ''
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
        'image',
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

    $cloud->image->change_protection(
    );

=head1 METHODS



=head2 change_protection

Change protection for an Image

    $cloud->image->change_protection();


=head2 delete

Delete an Image

    $cloud->image->delete();


=head2 get

Get an Image

    $cloud->image->get();


=head2 get_action

Get an Action for an Image

    $cloud->image->get_action();


=head2 get_actions

Get all Actions for an Image

    $cloud->image->get_actions(
        sort => enum[string],     # optional
        status => enum[string],     # optional
    );


=head2 list

Get all Images

    $cloud->image->list(
        bound_to => string,     # optional
        label_selector => string,     # optional
        name => string,     # optional
        sort => enum[string],     # optional
        type => enum[string],     # optional
    );


=head2 update

Update an Image

    $cloud->image->update();


    