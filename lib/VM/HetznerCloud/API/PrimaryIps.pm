package VM::HetznerCloud::API::PrimaryIps;

# ABSTRACT: PrimaryIps

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

has endpoint  => ( is => 'ro', isa => Str, default => sub { 'primary_ips' } );

sub list ($self, %params) {
    my $request_params = {
        'ip' => {
            'in'       => 'query',
            'required' => 0,
            'validate' => 'string',
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
    };
;
    return $self->_request( '', \%params, $request_params, { type => 'get' } );
}

sub create ($self, %params) {
    my $request_params = {};
    return $self->_request( '', \%params, $request_params, { type => 'post' } );
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

sub create_actions_assign ($self, %params) {
    my $request_params = {
        'id' => {
            'in'       => 'path',
            'required' => 1,
            'validate' => 'int64',
        },
    };
;
    return $self->_request( '/:id/actions/assign', \%params, $request_params, { type => 'post' } );
}

sub create_actions_change_dns_ptr ($self, %params) {
    my $request_params = {
        'id' => {
            'in'       => 'path',
            'required' => 1,
            'validate' => 'int64',
        },
    };
;
    return $self->_request( '/:id/actions/change_dns_ptr', \%params, $request_params, { type => 'post' } );
}

sub create_actions_change_protection ($self, %params) {
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

sub create_actions_unassign ($self, %params) {
    my $request_params = {
        'id' => {
            'in'       => 'path',
            'required' => 1,
            'validate' => 'int64',
        },
    };
;
    return $self->_request( '/:id/actions/unassign', \%params, $request_params, { type => 'post' } );
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

Returns all Primary IP objects.

    $cloud->primary_ips->list(
        ip => 'test',
        label_selector => 'test',
        name => 'test',
        sort => 'test',
    );


=head2 create

Creates a new Primary IP, optionally assigned to a Server.

If you want to create a Primary IP that is not assigned to a Server, you need to provide the `datacenter` key instead of `assignee_id`. This can be either the ID or the name of the Datacenter this Primary IP shall be created in.

Note that a Primary IP can only be assigned to a Server in the same Datacenter later on.

#### Call specific error codes

| Code                          | Description                                                   |
|------------------------------ |-------------------------------------------------------------- |
| `server_not_stopped`          | The specified server is running, but needs to be powered off  |
| `server_has_ipv4`             | The server already has an ipv4 address                        |
| `server_has_ipv6`             | The server already has an ipv6 address                        |


    $cloud->primary_ips->create();


=head2 delete

Deletes a Primary IP.

The Primary IP may be assigned to a Server. In this case it is unassigned automatically. The Server must be powered off (status `off`) in order for this operation to succeed.


    $cloud->primary_ips->delete(
        id => 'test',
    );


=head2 get

Returns a specific Primary IP object.

    $cloud->primary_ips->get(
        id => 'test',
    );


=head2 put

Updates the Primary IP.

Note that when updating labels, the Primary IP's current set of labels will be replaced with the labels provided in the request body. So, for example, if you want to add a new label, you have to provide all existing labels plus the new label in the request body.

If the Primary IP object changes during the request, the response will be a “conflict” error.


    $cloud->primary_ips->put(
        id => 'test',
    );


=head2 create_actions_assign

Assigns a Primary IP to a Server.

A Server can only have one Primary IP of type `ipv4` and one of type `ipv6` assigned. If you need more IPs use Floating IPs.

The Server must be powered off (status `off`) in order for this operation to succeed.

#### Call specific error codes

| Code                          | Description                                                   |
|------------------------------ |-------------------------------------------------------------- |
| `server_not_stopped`          | The server is running, but needs to be powered off            |
| `primary_ip_already_assigned` | Primary ip is already assigned to a different server          |
| `server_has_ipv4`             | The server already has an ipv4 address                        |
| `server_has_ipv6`             | The server already has an ipv6 address                        |


    $cloud->primary_ips->create_actions_assign(
        id => 'test',
    );


=head2 create_actions_change_dns_ptr

Changes the hostname that will appear when getting the hostname belonging to this Primary IP.

    $cloud->primary_ips->create_actions_change_dns_ptr(
        id => 'test',
    );


=head2 create_actions_change_protection

Changes the protection configuration of a Primary IP.

A Primary IP can only be delete protected if its `auto_delete` property is set to `false`.


    $cloud->primary_ips->create_actions_change_protection(
        id => 'test',
    );


=head2 create_actions_unassign

Unassigns a Primary IP from a Server.

The Server must be powered off (status `off`) in order for this operation to succeed.

Note that only Servers that have at least one network interface (public or private) attached can be powered on.

#### Call specific error codes

| Code                              | Description                                                   |
|---------------------------------- |-------------------------------------------------------------- |
| `server_not_stopped`              | The server is running, but needs to be powered off            |
| `server_is_load_balancer_target`  | The server ipv4 address is a loadbalancer target              |


    $cloud->primary_ips->create_actions_unassign(
        id => 'test',
    );


    