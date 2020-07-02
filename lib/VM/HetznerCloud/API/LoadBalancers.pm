package VM::HetznerCloud::API::LoadBalancers;

# ABSTRACT: LoadBalancers

use v5.20;

use strict;
use warnings;

use Moo;
use Types::Standard qw(:all);

use Mojo::Base -strict, -signatures;

extends 'VM::HetznerCloud';

with 'VM::HetznerCloud::Utils';
with 'MooX::Singleton';

use JSON::Validator;
use Carp;

has endpoint  => ( is => 'ro', isa => Str, default => sub { 'load_balancers' } );

sub add_service ($self, %params) {
    my $spec   = {
        type       => "object",
        required   => [qw/id protocol/],
        properties => {
            'id' => { type => "string" },
            'protocol' => { type => "string" },
            'destination_port' => { type => "number" },
            'health_check' => { type => "object" },
            'http' => { type => "object" },
            'listen_port' => { type => "number" },
            'proxyprotocol' => { type => "boolean" },
        },
    };

    my $validator = JSON::Validator->new->schema($spec);

    my @errors = $validator->validate(
        \%params,
    );

    if ( @errors ) {
        croak 'invalid parameters';
    }

    my %request_params = map{
        exists $params{$_} ?
            ($_ => $params{$_}) :
            ();
    } keys %{$spec->{properties}};

    $self->request(
        '/:id/actions/add_service',
        { type => 'post' },
        \%request_params,
    );
}

sub add_target ($self, %params) {
    my $spec   = {
        type       => "object",
        required   => [qw/id type/],
        properties => {
            'id' => { type => "string" },
            'type' => { type => "string" },
            'server' => { type => "object" },
            'use_private_ip' => { type => "boolean" },
        },
    };

    my $validator = JSON::Validator->new->schema($spec);

    my @errors = $validator->validate(
        \%params,
    );

    if ( @errors ) {
        croak 'invalid parameters';
    }

    my %request_params = map{
        exists $params{$_} ?
            ($_ => $params{$_}) :
            ();
    } keys %{$spec->{properties}};

    $self->request(
        '/:id/actions/add_target',
        { type => 'post' },
        \%request_params,
    );
}

sub attach_to_network ($self, %params) {
    my $spec   = {
        type       => "object",
        required   => [qw/id network/],
        properties => {
            'id' => { type => "string" },
            'network' => { type => "number" },
            'ip' => { type => "string" },
        },
    };

    my $validator = JSON::Validator->new->schema($spec);

    my @errors = $validator->validate(
        \%params,
    );

    if ( @errors ) {
        croak 'invalid parameters';
    }

    my %request_params = map{
        exists $params{$_} ?
            ($_ => $params{$_}) :
            ();
    } keys %{$spec->{properties}};

    $self->request(
        '/:id/actions/attach_to_network',
        { type => 'post' },
        \%request_params,
    );
}

sub change_algorithm ($self, %params) {
    my $spec   = {
        type       => "object",
        required   => [qw/id type/],
        properties => {
            'id' => { type => "string" },
            'type' => { type => "string" },
        },
    };

    my $validator = JSON::Validator->new->schema($spec);

    my @errors = $validator->validate(
        \%params,
    );

    if ( @errors ) {
        croak 'invalid parameters';
    }

    my %request_params = map{
        exists $params{$_} ?
            ($_ => $params{$_}) :
            ();
    } keys %{$spec->{properties}};

    $self->request(
        '/:id/actions/change_algorithm',
        { type => 'post' },
        \%request_params,
    );
}

sub change_protection ($self, %params) {
    my $spec   = {
        type       => "object",
        required   => [qw/id/],
        properties => {
            'id' => { type => "string" },
            'delete' => { type => "boolean" },
        },
    };

    my $validator = JSON::Validator->new->schema($spec);

    my @errors = $validator->validate(
        \%params,
    );

    if ( @errors ) {
        croak 'invalid parameters';
    }

    my %request_params = map{
        exists $params{$_} ?
            ($_ => $params{$_}) :
            ();
    } keys %{$spec->{properties}};

    $self->request(
        '/:id/actions/change_protection',
        { type => 'post' },
        \%request_params,
    );
}

sub create ($self, %params) {
    my $spec   = {
        type       => "object",
        required   => [qw/algorithm load_balancer_type name/],
        properties => {
            'algorithm' => { type => "object" },
            'load_balancer_type' => { type => "string" },
            'name' => { type => "string" },
            'labels' => { type => "object" },
            'location' => { type => "string" },
            'network' => { type => "number" },
            'network_zone' => { type => "string" },
            'public_interface' => { type => "boolean" },
            'services' => { type => "array" },
            'targets' => { type => "array" },
        },
    };

    my $validator = JSON::Validator->new->schema($spec);

    my @errors = $validator->validate(
        \%params,
    );

    if ( @errors ) {
        croak 'invalid parameters';
    }

    my %request_params = map{
        exists $params{$_} ?
            ($_ => $params{$_}) :
            ();
    } keys %{$spec->{properties}};

    $self->request(
        '',
        { type => 'post' },
        \%request_params,
    );
}

sub delete ($self, %params) {
    my $spec   = {
        type       => "object",
        required   => [qw/id/],
        properties => {
            'id' => { type => "string" },
        },
    };

    my $validator = JSON::Validator->new->schema($spec);

    my @errors = $validator->validate(
        \%params,
    );

    if ( @errors ) {
        croak 'invalid parameters';
    }

    my %request_params = map{
        exists $params{$_} ?
            ($_ => $params{$_}) :
            ();
    } keys %{$spec->{properties}};

    $self->request(
        '/:id',
        { type => 'delete' },
        \%request_params,
    );
}

sub delete_service ($self, %params) {
    my $spec   = {
        type       => "object",
        required   => [qw/id listen_port/],
        properties => {
            'id' => { type => "string" },
            'listen_port' => { type => "number" },
        },
    };

    my $validator = JSON::Validator->new->schema($spec);

    my @errors = $validator->validate(
        \%params,
    );

    if ( @errors ) {
        croak 'invalid parameters';
    }

    my %request_params = map{
        exists $params{$_} ?
            ($_ => $params{$_}) :
            ();
    } keys %{$spec->{properties}};

    $self->request(
        '/:id/actions/delete_service',
        { type => 'post' },
        \%request_params,
    );
}

sub detach_from_network ($self, %params) {
    my $spec   = {
        type       => "object",
        required   => [qw/id network/],
        properties => {
            'id' => { type => "string" },
            'network' => { type => "number" },
        },
    };

    my $validator = JSON::Validator->new->schema($spec);

    my @errors = $validator->validate(
        \%params,
    );

    if ( @errors ) {
        croak 'invalid parameters';
    }

    my %request_params = map{
        exists $params{$_} ?
            ($_ => $params{$_}) :
            ();
    } keys %{$spec->{properties}};

    $self->request(
        '/:id/actions/detach_from_network',
        { type => 'post' },
        \%request_params,
    );
}

sub disable_public_interface ($self, %params) {
    my $spec   = {
        type       => "object",
        required   => [qw/id/],
        properties => {
            'id' => { type => "string" },
        },
    };

    my $validator = JSON::Validator->new->schema($spec);

    my @errors = $validator->validate(
        \%params,
    );

    if ( @errors ) {
        croak 'invalid parameters';
    }

    my %request_params = map{
        exists $params{$_} ?
            ($_ => $params{$_}) :
            ();
    } keys %{$spec->{properties}};

    $self->request(
        '/:id/actions/disable_public_interface',
        { type => 'post' },
        \%request_params,
    );
}

sub enable_public_interface ($self, %params) {
    my $spec   = {
        type       => "object",
        required   => [qw/id/],
        properties => {
            'id' => { type => "string" },
        },
    };

    my $validator = JSON::Validator->new->schema($spec);

    my @errors = $validator->validate(
        \%params,
    );

    if ( @errors ) {
        croak 'invalid parameters';
    }

    my %request_params = map{
        exists $params{$_} ?
            ($_ => $params{$_}) :
            ();
    } keys %{$spec->{properties}};

    $self->request(
        '/:id/actions/enable_public_interface',
        { type => 'post' },
        \%request_params,
    );
}

sub get ($self, %params) {
    my $spec   = {
        type       => "object",
        required   => [qw/id/],
        properties => {
            'id' => { type => "string" },
        },
    };

    my $validator = JSON::Validator->new->schema($spec);

    my @errors = $validator->validate(
        \%params,
    );

    if ( @errors ) {
        croak 'invalid parameters';
    }

    my %request_params = map{
        exists $params{$_} ?
            ($_ => $params{$_}) :
            ();
    } keys %{$spec->{properties}};

    $self->request(
        '/:id',
        { type => 'get' },
        \%request_params,
    );
}

sub get_action ($self, %params) {
    my $spec   = {
        type       => "object",
        required   => [qw/action_id id/],
        properties => {
            'action_id' => { type => "string" },
            'id' => { type => "string" },
        },
    };

    my $validator = JSON::Validator->new->schema($spec);

    my @errors = $validator->validate(
        \%params,
    );

    if ( @errors ) {
        croak 'invalid parameters';
    }

    my %request_params = map{
        exists $params{$_} ?
            ($_ => $params{$_}) :
            ();
    } keys %{$spec->{properties}};

    $self->request(
        '/:id/actions/:action_id',
        { type => 'get' },
        \%request_params,
    );
}

sub get_actions ($self, %params) {
    my $spec   = {
        type       => "object",
        required   => [qw/id/],
        properties => {
            'id' => { type => "string" },
            'sort' => { type => "enum[string]" },
            'status' => { type => "enum[string]" },
        },
    };

    my $validator = JSON::Validator->new->schema($spec);

    my @errors = $validator->validate(
        \%params,
    );

    if ( @errors ) {
        croak 'invalid parameters';
    }

    my %request_params = map{
        exists $params{$_} ?
            ($_ => $params{$_}) :
            ();
    } keys %{$spec->{properties}};

    $self->request(
        '/:id/actions',
        { type => 'get' },
        \%request_params,
    );
}

sub list ($self, %params) {
    my $spec   = {
        type       => "object",
        required   => [qw//],
        properties => {
            'label_selector' => { type => "string" },
            'name' => { type => "string" },
            'sort' => { type => "enum[string]" },
        },
    };

    my $validator = JSON::Validator->new->schema($spec);

    my @errors = $validator->validate(
        \%params,
    );

    if ( @errors ) {
        croak 'invalid parameters';
    }

    my %request_params = map{
        exists $params{$_} ?
            ($_ => $params{$_}) :
            ();
    } keys %{$spec->{properties}};

    $self->request(
        '',
        { type => 'get' },
        \%request_params,
    );
}

sub remove_target ($self, %params) {
    my $spec   = {
        type       => "object",
        required   => [qw/id type/],
        properties => {
            'id' => { type => "string" },
            'type' => { type => "string" },
            'server' => { type => "object" },
        },
    };

    my $validator = JSON::Validator->new->schema($spec);

    my @errors = $validator->validate(
        \%params,
    );

    if ( @errors ) {
        croak 'invalid parameters';
    }

    my %request_params = map{
        exists $params{$_} ?
            ($_ => $params{$_}) :
            ();
    } keys %{$spec->{properties}};

    $self->request(
        '/:id/actions/remove_target',
        { type => 'post' },
        \%request_params,
    );
}

sub update ($self, %params) {
    my $spec   = {
        type       => "object",
        required   => [qw/id/],
        properties => {
            'id' => { type => "string" },
            'labels' => { type => "object" },
            'name' => { type => "string" },
        },
    };

    my $validator = JSON::Validator->new->schema($spec);

    my @errors = $validator->validate(
        \%params,
    );

    if ( @errors ) {
        croak 'invalid parameters';
    }

    my %request_params = map{
        exists $params{$_} ?
            ($_ => $params{$_}) :
            ();
    } keys %{$spec->{properties}};

    $self->request(
        '/:id',
        { type => 'put' },
        \%request_params,
    );
}

sub update_service ($self, %params) {
    my $spec   = {
        type       => "object",
        required   => [qw/id listen_port/],
        properties => {
            'id' => { type => "string" },
            'listen_port' => { type => "number" },
            'destination_port' => { type => "number" },
            'health_check' => { type => "object" },
            'http' => { type => "object" },
            'protocol' => { type => "string" },
            'proxyprotocol' => { type => "boolean" },
        },
    };

    my $validator = JSON::Validator->new->schema($spec);

    my @errors = $validator->validate(
        \%params,
    );

    if ( @errors ) {
        croak 'invalid parameters';
    }

    my %request_params = map{
        exists $params{$_} ?
            ($_ => $params{$_}) :
            ();
    } keys %{$spec->{properties}};

    $self->request(
        '/:id/actions/update_service',
        { type => 'post' },
        \%request_params,
    );
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

    $cloud->load_balancer->add_service(
    );

=head1 ATTRIBUTES

=over 4

=item * endpoint

=back

=head1 METHODS



=head2 add_service

Add Service

    $cloud->load_balancer->add_service({
        type       => "object",
        required   => [qw/id protocol/],
        properties => {
            'id' => { type => "string" },
            'protocol' => { type => "string" },
            'destination_port' => { type => "number" },
            'health_check' => { type => "object" },
            'http' => { type => "object" },
            'listen_port' => { type => "number" },
            'proxyprotocol' => { type => "boolean" },
        },
    };
);


=head2 add_target

Add Target

    $cloud->load_balancer->add_target({
        type       => "object",
        required   => [qw/id type/],
        properties => {
            'id' => { type => "string" },
            'type' => { type => "string" },
            'server' => { type => "object" },
            'use_private_ip' => { type => "boolean" },
        },
    };
);


=head2 attach_to_network

Attach a Load Balancer to a Network

    $cloud->load_balancer->attach_to_network({
        type       => "object",
        required   => [qw/id network/],
        properties => {
            'id' => { type => "string" },
            'network' => { type => "number" },
            'ip' => { type => "string" },
        },
    };
);


=head2 change_algorithm

Change Algorithm

    $cloud->load_balancer->change_algorithm({
        type       => "object",
        required   => [qw/id type/],
        properties => {
            'id' => { type => "string" },
            'type' => { type => "string" },
        },
    };
);


=head2 change_protection

Change Load Balancer Protection

    $cloud->load_balancer->change_protection({
        type       => "object",
        required   => [qw/id/],
        properties => {
            'id' => { type => "string" },
            'delete' => { type => "boolean" },
        },
    };
);


=head2 create

Create a Load Balancer

    $cloud->load_balancer->create({
        type       => "object",
        required   => [qw/algorithm load_balancer_type name/],
        properties => {
            'algorithm' => { type => "object" },
            'load_balancer_type' => { type => "string" },
            'name' => { type => "string" },
            'labels' => { type => "object" },
            'location' => { type => "string" },
            'network' => { type => "number" },
            'network_zone' => { type => "string" },
            'public_interface' => { type => "boolean" },
            'services' => { type => "array" },
            'targets' => { type => "array" },
        },
    };
);


=head2 delete

Delete a Load Balancer

    $cloud->load_balancer->delete({
        type       => "object",
        required   => [qw/id/],
        properties => {
            'id' => { type => "string" },
        },
    };
);


=head2 delete_service

Delete Service

    $cloud->load_balancer->delete_service({
        type       => "object",
        required   => [qw/id listen_port/],
        properties => {
            'id' => { type => "string" },
            'listen_port' => { type => "number" },
        },
    };
);


=head2 detach_from_network

Detach a Load Balancer from a Network

    $cloud->load_balancer->detach_from_network({
        type       => "object",
        required   => [qw/id network/],
        properties => {
            'id' => { type => "string" },
            'network' => { type => "number" },
        },
    };
);


=head2 disable_public_interface

Disable the public interface of a Load Balancer

    $cloud->load_balancer->disable_public_interface({
        type       => "object",
        required   => [qw/id/],
        properties => {
            'id' => { type => "string" },
        },
    };
);


=head2 enable_public_interface

Enable the public interface of a Load Balancer

    $cloud->load_balancer->enable_public_interface({
        type       => "object",
        required   => [qw/id/],
        properties => {
            'id' => { type => "string" },
        },
    };
);


=head2 get

Get a Load Balancer

    $cloud->load_balancer->get({
        type       => "object",
        required   => [qw/id/],
        properties => {
            'id' => { type => "string" },
        },
    };
);


=head2 get_action

Get an Action for a Load Balancer

    $cloud->load_balancer->get_action({
        type       => "object",
        required   => [qw/action_id id/],
        properties => {
            'action_id' => { type => "string" },
            'id' => { type => "string" },
        },
    };
);


=head2 get_actions

Get all Actions for a Load Balancer

    $cloud->load_balancer->get_actions({
        type       => "object",
        required   => [qw/id/],
        properties => {
            'id' => { type => "string" },
            'sort' => { type => "enum[string]" },
            'status' => { type => "enum[string]" },
        },
    };
);


=head2 list

Get all Load Balancers

    $cloud->load_balancer->list({
        type       => "object",
        required   => [qw//],
        properties => {
            'label_selector' => { type => "string" },
            'name' => { type => "string" },
            'sort' => { type => "enum[string]" },
        },
    };
);


=head2 remove_target

Remove Target

    $cloud->load_balancer->remove_target({
        type       => "object",
        required   => [qw/id type/],
        properties => {
            'id' => { type => "string" },
            'type' => { type => "string" },
            'server' => { type => "object" },
        },
    };
);


=head2 update

Update a Load Balancer

    $cloud->load_balancer->update({
        type       => "object",
        required   => [qw/id/],
        properties => {
            'id' => { type => "string" },
            'labels' => { type => "object" },
            'name' => { type => "string" },
        },
    };
);


=head2 update_service

Update Service

    $cloud->load_balancer->update_service({
        type       => "object",
        required   => [qw/id listen_port/],
        properties => {
            'id' => { type => "string" },
            'listen_port' => { type => "number" },
            'destination_port' => { type => "number" },
            'health_check' => { type => "object" },
            'http' => { type => "object" },
            'protocol' => { type => "string" },
            'proxyprotocol' => { type => "boolean" },
        },
    };
);


    