package VM::HetznerCloud::Image;

# ABSTRACT:

use v5.10;

use strict;
use warnings;

use Moo;

use parent 'VM::HetznerCloud::Utils';

has base   => ( is => 'ro', required => 1, isa => sub {} );
has mapping => ( is => 'ro', default => sub {
+{
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
  'list' => {
    'optional' => {
      'bound_to' => 'string',
      'name' => 'string',
      'sort' => 'string',
      'type' => 'string'
    },
    'type' => 'get',
    'uri' => ''
  },
  'update' => {
    'mandatory' => {
      'id' => 'string'
    },
    'optional' => {
      'description' => 'string',
      'type' => 'string'
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
        'images',
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

    $cloud->image->delete(
    );

=head1 METHODS



=head2 delete

Delete an Image

    $cloud->image->delete(
        id => string,     # mandatory
    )


=head2 get

Get an Image

    $cloud->image->get(
        id => string,     # mandatory
    )


=head2 list

Get all Images

    $cloud->image->list(
        bound_to => string,     # optional
        name => string,     # optional
        sort => string,     # optional
        type => string,     # optional
    )


=head2 update

Update an Image

    $cloud->image->update(
        id => string,     # mandatory
        description => string,     # optional
        type => string,     # optional
    )


    