package VM::HetznerCloud::ServerType;

# ABSTRACT:

use v5.10;

use strict;
use warnings;

use Moo;

use parent 'VM::HetznerCloud::Utils';

has base   => ( is => 'ro', required => 1, isa => sub {} );
has mapping => ( is => 'ro', default => sub {
+{
  'get' => {
    'mandatory' => {
      'id' => 'string'
    },
    'type' => 'get',
    'uri' => '/:id'
  },
  'list' => {
    'optional' => {
      'name' => 'string'
    },
    'type' => 'get',
    'uri' => ''
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
        'server_types',
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

    $cloud->server_type->get(
    );

=head1 METHODS



=head2 get

Get a Server Type

    $cloud->server_type->get(
        id => string,     # mandatory
    )


=head2 list

Get all Server Types

    $cloud->server_type->list(
        name => string,     # optional
    )


    