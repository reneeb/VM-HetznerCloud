package VM::HetznerCloud::API::Actions;

# ABSTRACT: Actions

# ---
# This class is auto-generated by bin/get_hetzner_info.pl
# ---

use v5.24;

use Moo;
use Types::Standard qw(:all);

use Mojo::Base -strict, -signatures;

extends 'VM::HetznerCloud::APIBase';

use utf8;

# VERSION

has endpoint  => ( is => 'ro', isa => Str, default => sub { 'actions' } );

sub list ($self, %params) {
    my $request_params = {
        'id' => {
            'in'       => 'query',
            'required' => 0,
            'validate' => 'int64',
        },
        'sort' => {
            'in'       => 'query',
            'required' => 0,
            'validate' => 'string',
        },
        'status' => {
            'in'       => 'query',
            'required' => 0,
            'validate' => 'string',
        },
    };

    return $self->_request( '', \%params, $request_params, { type => 'get', oid => '/actions#get' } );
}

sub get ($self, %params) {
    my $request_params = {
        'id' => {
            'in'       => 'path',
            'required' => 1,
            'validate' => 'int64',
        },
    };

    return $self->_request( '/:id', \%params, $request_params, { type => 'get', oid => '/actions/{id}#get' } );
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

Returns all Action objects. You can `sort` the results by using the sort URI parameter, and filter them with the `status` parameter.

    $cloud->actions->list(
        id => 'test',
        sort => 'test',
        status => 'test',
    );


=head2 get

Returns a specific Action object.

    $cloud->actions->get(
        id => 'test',
    );


    