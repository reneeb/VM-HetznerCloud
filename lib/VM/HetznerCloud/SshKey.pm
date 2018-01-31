package VM::HetznerCloud::SshKey;

# ABSTRACT:

use v5.10;

use strict;
use warnings;

use Moo;

use parent 'VM::HetznerCloud::Utils';

has base   => ( is => 'ro', required => 1, isa => sub {} );
has mapping => ( is => 'ro', default => sub {
+{
  'add' => {
    'mandatory' => {
      'name' => 'string',
      'public_key' => 'string'
    },
    'type' => 'post',
    'uri' => ''
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
  'list' => {
    'optional' => {
      'name' => 'string'
    },
    'type' => 'get',
    'uri' => ''
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
        'ssh_keys',
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

    $cloud->ssh_key->add(
    );

=head1 METHODS



=head2 add

Create a SSH Key

    $cloud->ssh_key->add(
        name => string,     # mandatory
        public_key => string,     # mandatory
    )


=head2 delete

Delete a SSH Key

    $cloud->ssh_key->delete(
        id => string,     # mandatory
    )


=head2 get

Get a SSH Key

    $cloud->ssh_key->get(
        id => string,     # mandatory
    )


=head2 list

Get all SSH Keys

    $cloud->ssh_key->list(
        name => string,     # optional
    )


=head2 update

Change the name of a SSH Key

    $cloud->ssh_key->update(
        id => string,     # mandatory
        name => string,     # optional
    )


    