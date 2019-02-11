package VM::HetznerCloud::SshKey;

# ABSTRACT: SshKey

use v5.10;

use strict;
use warnings;

use Moo;
use Types::Mojo qw(MojoURL);

use parent 'VM::HetznerCloud::Utils';

has base   => ( is => 'ro', required => 1, isa => MojoURL["https?"] );
has mapping => ( is => 'ro', default => sub {
+{
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
  'list' => {
    'optional' => {
      'fingerprint' => 'string',
      'label_selector' => 'string',
      'name' => 'string'
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
        'ssh_key',
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

    $cloud->ssh_key->create(
    );

=head1 METHODS



=head2 create

Create an SSH key

    $cloud->ssh_key->create();


=head2 delete

Delete an SSH key

    $cloud->ssh_key->delete();


=head2 get

Get an SSH key

    $cloud->ssh_key->get();


=head2 list

Get all SSH keys

    $cloud->ssh_key->list(
        fingerprint => string,     # optional
        label_selector => string,     # optional
        name => string,     # optional
    );


=head2 update

Update an SSH key

    $cloud->ssh_key->update();


    