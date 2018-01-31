package VM::HetznerCloud::Iso;

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
        'isos',
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

    $cloud->iso->get(
    );

=head1 METHODS



=head2 get

Get an ISO

    $cloud->iso->get(
        id => string,     # mandatory
    )


=head2 list

Get all ISOs

    $cloud->iso->list(
        name => string,     # optional
    )


    