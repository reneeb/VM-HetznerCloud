package VM::HetznerCloud::API::Images;

# ABSTRACT: Images

# ---
# This class is auto-generated by bin/get_hetzner_info.pl
# ---

use v5.24;

use Moo;
use Types::Standard qw(:all);

use Mojo::Base -strict, -signatures;

extends 'VM::HetznerCloud::APIBase';

# VERSION

has endpoint  => ( is => 'ro', isa => Str, default => sub { 'images' } );

sub list ($self, %params) {
    my $request_params = {
        'architecture' => {
            'in'       => 'query',
            'required' => 0,
            'validate' => 'string',
        },
        'bound_to' => {
            'in'       => 'query',
            'required' => 0,
            'validate' => 'string',
        },
        'include_deprecated' => {
            'in'       => 'query',
            'required' => 0,
            'validate' => 'boolean',
        },
        'label_selector' => {
            'in'       => 'query',
            'required' => 0,
            'validate' => 'string',
        },
        'name' => {
            'in'       => 'query',
            'required' => 0,
            'validate' => 'string',
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
        'type' => {
            'in'       => 'query',
            'required' => 0,
            'validate' => 'string',
        },
    };
;
    return $self->_request( '', \%params, $request_params, { type => 'get' } );
}

sub delete ($self, %params) {
    my $request_params = {
        'id' => {
            'in'       => 'path',
            'required' => 1,
            'validate' => 'int64',
        },
    };
;
    return $self->_request( '/:id', \%params, $request_params, { type => 'delete' } );
}

sub get ($self, %params) {
    my $request_params = {
        'id' => {
            'in'       => 'path',
            'required' => 1,
            'validate' => 'int64',
        },
    };
;
    return $self->_request( '/:id', \%params, $request_params, { type => 'get' } );
}

sub put ($self, %params) {
    my $request_params = {
        'id' => {
            'in'       => 'path',
            'required' => 1,
            'validate' => 'int64',
        },
    };
;
    return $self->_request( '/:id', \%params, $request_params, { type => 'put' } );
}

sub list_actions ($self, %params) {
    my $request_params = {
        'id' => {
            'in'       => 'path',
            'required' => 1,
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
;
    return $self->_request( '/:id/actions', \%params, $request_params, { type => 'get' } );
}

sub change_protection ($self, %params) {
    my $request_params = {
        'id' => {
            'in'       => 'path',
            'required' => 1,
            'validate' => 'int64',
        },
    };
;
    return $self->_request( '/:id/actions/change_protection', \%params, $request_params, { type => 'post' } );
}

sub get_actions ($self, %params) {
    my $request_params = {
        'action_id' => {
            'in'       => 'path',
            'required' => 1,
            'validate' => 'int64',
        },
        'id' => {
            'in'       => 'path',
            'required' => 1,
            'validate' => 'int64',
        },
    };
;
    return $self->_request( '/:id/actions/:action_id', \%params, $request_params, { type => 'get' } );
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

Returns all Image objects. You can select specific Image types only and sort the results by using URI parameters.

    $cloud->images->list(
        architecture => 'test',
        bound_to => 'test',
        include_deprecated => 'test',
        label_selector => 'test',
        name => 'test',
        sort => 'test',
        status => 'test',
        type => 'test',
    );


=head2 delete

Deletes an Image. Only Images of type `snapshot` and `backup` can be deleted.

    $cloud->images->delete(
        id => 'test',
    );


=head2 get

Returns a specific Image object.

    $cloud->images->get(
        id => 'test',
    );


=head2 put

Updates the Image. You may change the description, convert a Backup Image to a Snapshot Image or change the Image labels. Only Images of type `snapshot` and `backup` can be updated.

Note that when updating labels, the current set of labels will be replaced with the labels provided in the request body. So, for example, if you want to add a new label, you have to provide all existing labels plus the new label in the request body.


    $cloud->images->put(
        id => 'test',
    );


=head2 list_actions

Returns all Action objects for an Image. You can sort the results by using the `sort` URI parameter, and filter them with the `status` parameter.

    $cloud->images->list_actions(
        id => 'test',
        sort => 'test',
        status => 'test',
    );


=head2 change_protection

Changes the protection configuration of the Image. Can only be used on snapshots.

    $cloud->images->change_protection(
        id => 'test',
    );


=head2 get_actions

Returns a specific Action for an Image.

    $cloud->images->get_actions(
        action_id => 'test',
        id => 'test',
    );


    