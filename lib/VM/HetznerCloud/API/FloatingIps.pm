package VM::HetznerCloud::API::FloatingIps;

# ABSTRACT: FloatingIps

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

has endpoint  => ( is => 'ro', isa => Str, default => sub { 'floating_ips' } );

sub list ($self, %params) {
    my $request_params = {
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
    };

    return $self->_request( '', \%params, $request_params, { type => 'get', oid => '/floating_ips#get' } );
}

sub create ($self, %params) {
    my $request_params = {};
    return $self->_request( '', \%params, $request_params, { type => 'post', oid => '/floating_ips#post' } );
}

sub delete ($self, %params) {
    my $request_params = {
        'id' => {
            'in'       => 'path',
            'required' => 1,
            'validate' => 'int64',
        },
    };

    return $self->_request( '/:id', \%params, $request_params, { type => 'delete', oid => '/floating_ips/{id}#delete' } );
}

sub get ($self, %params) {
    my $request_params = {
        'id' => {
            'in'       => 'path',
            'required' => 1,
            'validate' => 'int64',
        },
    };

    return $self->_request( '/:id', \%params, $request_params, { type => 'get', oid => '/floating_ips/{id}#get' } );
}

sub put ($self, %params) {
    my $request_params = {
        'id' => {
            'in'       => 'path',
            'required' => 1,
            'validate' => 'int64',
        },
    };

    return $self->_request( '/:id', \%params, $request_params, { type => 'put', oid => '/floating_ips/{id}#put' } );
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

    return $self->_request( '/:id/actions', \%params, $request_params, { type => 'get', oid => '/floating_ips/{id}/actions#get' } );
}

sub assign ($self, %params) {
    my $request_params = {
        'id' => {
            'in'       => 'path',
            'required' => 1,
            'validate' => 'int64',
        },
    };

    return $self->_request( '/:id/actions/assign', \%params, $request_params, { type => 'post', oid => '/floating_ips/{id}/actions/assign#post' } );
}

sub change_dns_ptr ($self, %params) {
    my $request_params = {
        'id' => {
            'in'       => 'path',
            'required' => 1,
            'validate' => 'int64',
        },
    };

    return $self->_request( '/:id/actions/change_dns_ptr', \%params, $request_params, { type => 'post', oid => '/floating_ips/{id}/actions/change_dns_ptr#post' } );
}

sub change_protection ($self, %params) {
    my $request_params = {
        'id' => {
            'in'       => 'path',
            'required' => 1,
            'validate' => 'int64',
        },
    };

    return $self->_request( '/:id/actions/change_protection', \%params, $request_params, { type => 'post', oid => '/floating_ips/{id}/actions/change_protection#post' } );
}

sub unassign ($self, %params) {
    my $request_params = {
        'id' => {
            'in'       => 'path',
            'required' => 1,
            'validate' => 'int64',
        },
    };

    return $self->_request( '/:id/actions/unassign', \%params, $request_params, { type => 'post', oid => '/floating_ips/{id}/actions/unassign#post' } );
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

    return $self->_request( '/:id/actions/:action_id', \%params, $request_params, { type => 'get', oid => '/floating_ips/{id}/actions/{action_id}#get' } );
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

Returns all Floating IP objects.

    $cloud->floating_ips->list(
        label_selector => 'test',
        name => 'test',
        sort => 'test',
    );


=head2 create

Creates a new Floating IP assigned to a Server. If you want to create a Floating IP that is not bound to a Server, you need to provide the `home_location` key instead of `server`. This can be either the ID or the name of the Location this IP shall be created in. Note that a Floating IP can be assigned to a Server in any Location later on. For optimal routing it is advised to use the Floating IP in the same Location it was created in.

    $cloud->floating_ips->create();


=head2 delete

Deletes a Floating IP. If it is currently assigned to a Server it will automatically get unassigned.

    $cloud->floating_ips->delete(
        id => 'test',
    );


=head2 get

Returns a specific Floating IP object.

    $cloud->floating_ips->get(
        id => 'test',
    );


=head2 put

Updates the description or labels of a Floating IP.
Also note that when updating labels, the Floating IP’s current set of labels will be replaced with the labels provided in the request body. So, for example, if you want to add a new label, you have to provide all existing labels plus the new label in the request body.

    $cloud->floating_ips->put(
        id => 'test',
    );


=head2 list_actions

Returns all Action objects for a Floating IP. You can sort the results by using the `sort` URI parameter, and filter them with the `status` parameter.

    $cloud->floating_ips->list_actions(
        id => 'test',
        sort => 'test',
        status => 'test',
    );


=head2 assign

Assigns a Floating IP to a Server.

    $cloud->floating_ips->assign(
        id => 'test',
    );


=head2 change_dns_ptr

Changes the hostname that will appear when getting the hostname belonging to this Floating IP.

    $cloud->floating_ips->change_dns_ptr(
        id => 'test',
    );


=head2 change_protection

Changes the protection configuration of the Floating IP.

    $cloud->floating_ips->change_protection(
        id => 'test',
    );


=head2 unassign

Unassigns a Floating IP, resulting in it being unreachable. You may assign it to a Server again at a later time.

    $cloud->floating_ips->unassign(
        id => 'test',
    );


=head2 get_actions

Returns a specific Action object for a Floating IP.

    $cloud->floating_ips->get_actions(
        action_id => 'test',
        id => 'test',
    );


    