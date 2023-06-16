package VM::HetznerCloud::API::LoadBalancerTypes;

# ABSTRACT: LoadBalancerTypes

# ---
# This class is auto-generated by bin/get_hetzner_info.pl
# ---

use v5.24;

use Moo;
use Types::Standard qw(:all);

use Mojo::Base -strict, -signatures;

extends 'VM::HetznerCloud::APIBase';

with 'MooX::Singleton';

use VM::HetznerCloud::Schema;

# VERSION

has endpoint  => ( is => 'ro', isa => Str, default => sub { 'load_balancer_types' } );

sub list ($self, %params) {
    my $request_params = {
        'name' => {
            'in'       => 'query',
            'required' => 0,
            'validate' => 'string',
        },
    };
;
    return $self->_request( '', \%params, $request_params, { type => 'get' } );
}

sub get ($self, %params) {
    my $request_params = {
        'id' => {
            'in'       => 'path',
            'required' => 1,
            'validate' => 'integer',
        },
    };
;
    return $self->_request( '/:id', \%params, $request_params, { type => 'get' } );
}


1;

__END__

=pod


=head1 SYNOPSIS

    use VM::HetznerCloud;

    my $api_key = '1234abc';
    my $cloud   = VM::HetznerCloud->new(
        token => $api_key,
    );

    $cloud->records->create(
    );

=head1 ATTRIBUTES

=over 4

=item * endpoint

=back

=head1 METHODS



=head2 list

Gets all Load Balancer type objects.

    $cloud->load_balancer_types->list(
        name => 'test',
    );


=head2 get

Gets a specific Load Balancer type object.

    $cloud->load_balancer_types->get(
        id => 'test',
    );


    