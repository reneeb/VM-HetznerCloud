package VM::HetznerCloud::API::Networks;

# ABSTRACT: Networks

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

has endpoint  => ( is => 'ro', isa => Str, default => sub { 'networks' } );

sub add_route ($self, %params) {
    my $spec   = {
        type       => "object",
        required   => [qw/destination gateway id/],
        properties => {
            'destination' => { type => "string" },
            'gateway' => { type => "string" },
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
        '/:id/actions/add_route',
        { type => 'post' },
        \%request_params,
    );
}

sub add_subnet ($self, %params) {
    my $spec   = {
        type       => "object",
        required   => [qw/id network_zone type/],
        properties => {
            'id' => { type => "string" },
            'network_zone' => { type => "string" },
            'type' => { type => "string" },
            'ip_range' => { type => "string" },
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
        '/:id/actions/add_subnet',
        { type => 'post' },
        \%request_params,
    );
}

sub change_ip_range ($self, %params) {
    my $spec   = {
        type       => "object",
        required   => [qw/id ip_range/],
        properties => {
            'id' => { type => "string" },
            'ip_range' => { type => "string" },
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
        '/:id/actions/change_ip_range',
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
        required   => [qw/ip_range name/],
        properties => {
            'ip_range' => { type => "string" },
            'name' => { type => "string" },
            'labels' => { type => "object" },
            'routes' => { type => "array" },
            'subnets' => { type => "array" },
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

sub delete_route ($self, %params) {
    my $spec   = {
        type       => "object",
        required   => [qw/destination gateway id/],
        properties => {
            'destination' => { type => "string" },
            'gateway' => { type => "string" },
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
        '/:id/actions/delete_route',
        { type => 'post' },
        \%request_params,
    );
}

sub delete_subnet ($self, %params) {
    my $spec   = {
        type       => "object",
        required   => [qw/id ip_range/],
        properties => {
            'id' => { type => "string" },
            'ip_range' => { type => "string" },
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
        '/:id/actions/delete_subnet',
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


1;

__END__

=pod



=head1 SYNOPSIS

    use VM::HetznerCloud;

    my $api_key = '1234abc';
    my $cloud   = VM::HetznerCloud->new(
        token => $api_key,
    );

    $cloud->network->add_route(
    );

=head1 ATTRIBUTES

=over 4

=item * endpoint

=back

=head1 METHODS



=head2 add_route

Add a route to a Network

    $cloud->network->add_route({
        type       => "object",
        required   => [qw/destination gateway id/],
        properties => {
            'destination' => { type => "string" },
            'gateway' => { type => "string" },
            'id' => { type => "string" },
        },
    };
);


=head2 add_subnet

Add a subnet to a Network

    $cloud->network->add_subnet({
        type       => "object",
        required   => [qw/id network_zone type/],
        properties => {
            'id' => { type => "string" },
            'network_zone' => { type => "string" },
            'type' => { type => "string" },
            'ip_range' => { type => "string" },
        },
    };
);


=head2 change_ip_range

Change IP range of a Network

    $cloud->network->change_ip_range({
        type       => "object",
        required   => [qw/id ip_range/],
        properties => {
            'id' => { type => "string" },
            'ip_range' => { type => "string" },
        },
    };
);


=head2 change_protection

Change Network Protection

    $cloud->network->change_protection({
        type       => "object",
        required   => [qw/id/],
        properties => {
            'id' => { type => "string" },
            'delete' => { type => "boolean" },
        },
    };
);


=head2 create

Create a Network

    $cloud->network->create({
        type       => "object",
        required   => [qw/ip_range name/],
        properties => {
            'ip_range' => { type => "string" },
            'name' => { type => "string" },
            'labels' => { type => "object" },
            'routes' => { type => "array" },
            'subnets' => { type => "array" },
        },
    };
);


=head2 delete

Delete a Network

    $cloud->network->delete({
        type       => "object",
        required   => [qw/id/],
        properties => {
            'id' => { type => "string" },
        },
    };
);


=head2 delete_route

Delete a route from a Network

    $cloud->network->delete_route({
        type       => "object",
        required   => [qw/destination gateway id/],
        properties => {
            'destination' => { type => "string" },
            'gateway' => { type => "string" },
            'id' => { type => "string" },
        },
    };
);


=head2 delete_subnet

Delete a subnet from a Network

    $cloud->network->delete_subnet({
        type       => "object",
        required   => [qw/id ip_range/],
        properties => {
            'id' => { type => "string" },
            'ip_range' => { type => "string" },
        },
    };
);


=head2 get

Get a Network

    $cloud->network->get({
        type       => "object",
        required   => [qw/id/],
        properties => {
            'id' => { type => "string" },
        },
    };
);


=head2 get_action

Get an Action for a Network

    $cloud->network->get_action({
        type       => "object",
        required   => [qw/action_id id/],
        properties => {
            'action_id' => { type => "string" },
            'id' => { type => "string" },
        },
    };
);


=head2 get_actions

Get all Actions for a Network

    $cloud->network->get_actions({
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

Get all Networks

    $cloud->network->list({
        type       => "object",
        required   => [qw//],
        properties => {
            'label_selector' => { type => "string" },
            'name' => { type => "string" },
        },
    };
);


=head2 update

Update a Network

    $cloud->network->update({
        type       => "object",
        required   => [qw/id/],
        properties => {
            'id' => { type => "string" },
            'labels' => { type => "object" },
            'name' => { type => "string" },
        },
    };
);


    