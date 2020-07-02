package VM::HetznerCloud::API::Images;

# ABSTRACT: Images

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

has endpoint  => ( is => 'ro', isa => Str, default => sub { 'images' } );

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
            'bound_to' => { type => "string" },
            'label_selector' => { type => "string" },
            'name' => { type => "string" },
            'sort' => { type => "enum[string]" },
            'status' => { type => "enum[string]" },
            'type' => { type => "enum[string]" },
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
            'description' => { type => "string" },
            'labels' => { type => "object" },
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

    $cloud->image->change_protection(
    );

=head1 ATTRIBUTES

=over 4

=item * endpoint

=back

=head1 METHODS



=head2 change_protection

Change Image Protection

    $cloud->image->change_protection({
        type       => "object",
        required   => [qw/id/],
        properties => {
            'id' => { type => "string" },
            'delete' => { type => "boolean" },
        },
    };
);


=head2 delete

Delete an Image

    $cloud->image->delete({
        type       => "object",
        required   => [qw/id/],
        properties => {
            'id' => { type => "string" },
        },
    };
);


=head2 get

Get an Image

    $cloud->image->get({
        type       => "object",
        required   => [qw/id/],
        properties => {
            'id' => { type => "string" },
        },
    };
);


=head2 get_action

Get an Action for an Image

    $cloud->image->get_action({
        type       => "object",
        required   => [qw/action_id id/],
        properties => {
            'action_id' => { type => "string" },
            'id' => { type => "string" },
        },
    };
);


=head2 get_actions

Get all Actions for an Image

    $cloud->image->get_actions({
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

Get all Images

    $cloud->image->list({
        type       => "object",
        required   => [qw//],
        properties => {
            'bound_to' => { type => "string" },
            'label_selector' => { type => "string" },
            'name' => { type => "string" },
            'sort' => { type => "enum[string]" },
            'status' => { type => "enum[string]" },
            'type' => { type => "enum[string]" },
        },
    };
);


=head2 update

Update an Image

    $cloud->image->update({
        type       => "object",
        required   => [qw/id/],
        properties => {
            'id' => { type => "string" },
            'description' => { type => "string" },
            'labels' => { type => "object" },
            'type' => { type => "string" },
        },
    };
);


    