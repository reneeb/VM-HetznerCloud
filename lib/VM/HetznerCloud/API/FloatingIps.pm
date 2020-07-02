package VM::HetznerCloud::API::FloatingIps;

# ABSTRACT: FloatingIps

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

has endpoint  => ( is => 'ro', isa => Str, default => sub { 'floating_ips' } );

sub assign ($self, %params) {
    my $spec   = {
        type       => "object",
        required   => [qw/id server/],
        properties => {
            'id' => { type => "string" },
            'server' => { type => "number" },
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
        '/:id/actions/assign',
        { type => 'post' },
        \%request_params,
    );
}

sub change_dns_ptr ($self, %params) {
    my $spec   = {
        type       => "object",
        required   => [qw/dns_ptr id ip/],
        properties => {
            'dns_ptr' => { type => "ARRAY(0x5654e64ad998)" },
            'id' => { type => "string" },
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
        '/:id/actions/change_dns_ptr',
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
        required   => [qw/type/],
        properties => {
            'type' => { type => "string" },
            'description' => { type => "string" },
            'home_location' => { type => "string" },
            'labels' => { type => "object" },
            'name' => { type => "string" },
            'server' => { type => "number" },
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

sub unassign ($self, %params) {
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
        '/:id/actions/unassign',
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
            'description' => { type => "string" },
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

    $cloud->floating_ip->assign(
    );

=head1 ATTRIBUTES

=over 4

=item * endpoint

=back

=head1 METHODS



=head2 assign

Assign a Floating IP to a Server

    $cloud->floating_ip->assign({
        type       => "object",
        required   => [qw/id server/],
        properties => {
            'id' => { type => "string" },
            'server' => { type => "number" },
        },
    };
);


=head2 change_dns_ptr

Change reverse DNS entry for a Floating IP

    $cloud->floating_ip->change_dns_ptr({
        type       => "object",
        required   => [qw/dns_ptr id ip/],
        properties => {
            'dns_ptr' => { type => "ARRAY(0x5654e64ad998)" },
            'id' => { type => "string" },
            'ip' => { type => "string" },
        },
    };
);


=head2 change_protection

Change Floating IP Protection

    $cloud->floating_ip->change_protection({
        type       => "object",
        required   => [qw/id/],
        properties => {
            'id' => { type => "string" },
            'delete' => { type => "boolean" },
        },
    };
);


=head2 create

Create a Floating IP

    $cloud->floating_ip->create({
        type       => "object",
        required   => [qw/type/],
        properties => {
            'type' => { type => "string" },
            'description' => { type => "string" },
            'home_location' => { type => "string" },
            'labels' => { type => "object" },
            'name' => { type => "string" },
            'server' => { type => "number" },
        },
    };
);


=head2 delete

Delete a Floating IP

    $cloud->floating_ip->delete({
        type       => "object",
        required   => [qw/id/],
        properties => {
            'id' => { type => "string" },
        },
    };
);


=head2 get

Get a specific Floating IP

    $cloud->floating_ip->get({
        type       => "object",
        required   => [qw/id/],
        properties => {
            'id' => { type => "string" },
        },
    };
);


=head2 get_action

Get an Action for a Floating IP

    $cloud->floating_ip->get_action({
        type       => "object",
        required   => [qw/action_id id/],
        properties => {
            'action_id' => { type => "string" },
            'id' => { type => "string" },
        },
    };
);


=head2 get_actions

Get all Actions for a Floating IP

    $cloud->floating_ip->get_actions({
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

Get all Floating IPs

    $cloud->floating_ip->list({
        type       => "object",
        required   => [qw//],
        properties => {
            'label_selector' => { type => "string" },
            'name' => { type => "string" },
            'sort' => { type => "enum[string]" },
        },
    };
);


=head2 unassign

Unassign a Floating IP

    $cloud->floating_ip->unassign({
        type       => "object",
        required   => [qw/id/],
        properties => {
            'id' => { type => "string" },
        },
    };
);


=head2 update

Update a Floating IP

    $cloud->floating_ip->update({
        type       => "object",
        required   => [qw/id/],
        properties => {
            'id' => { type => "string" },
            'description' => { type => "string" },
            'labels' => { type => "object" },
            'name' => { type => "string" },
        },
    };
);


    