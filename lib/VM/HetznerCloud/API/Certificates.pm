package VM::HetznerCloud::API::Certificates;

# ABSTRACT: Certificates

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

has endpoint  => ( is => 'ro', isa => Str, default => sub { 'certificates' } );

sub create ($self, %params) {
    my $spec   = {
        type       => "object",
        required   => [qw/certificate name private_key/],
        properties => {
            'certificate' => { type => "string" },
            'name' => { type => "string" },
            'private_key' => { type => "string" },
            'labels' => { type => "object" },
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
            'id' => { type => "number" },
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
            'id' => { type => "number" },
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

sub update ($self, %params) {
    my $spec   = {
        type       => "object",
        required   => [qw/id/],
        properties => {
            'id' => { type => "number" },
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

    $cloud->certificate->create(
    );

=head1 ATTRIBUTES

=over 4

=item * endpoint

=back

=head1 METHODS



=head2 create

Create a Certificate

    $cloud->certificate->create({
        type       => "object",
        required   => [qw/certificate name private_key/],
        properties => {
            'certificate' => { type => "string" },
            'name' => { type => "string" },
            'private_key' => { type => "string" },
            'labels' => { type => "object" },
        },
    };
);


=head2 delete

Delete a Certificate

    $cloud->certificate->delete({
        type       => "object",
        required   => [qw/id/],
        properties => {
            'id' => { type => "number" },
        },
    };
);


=head2 get

Get a Certificate

    $cloud->certificate->get({
        type       => "object",
        required   => [qw/id/],
        properties => {
            'id' => { type => "number" },
        },
    };
);


=head2 list

Get all Certificates

    $cloud->certificate->list({
        type       => "object",
        required   => [qw//],
        properties => {
            'label_selector' => { type => "string" },
            'name' => { type => "string" },
            'sort' => { type => "enum[string]" },
        },
    };
);


=head2 update

Update a Certificate

    $cloud->certificate->update({
        type       => "object",
        required   => [qw/id/],
        properties => {
            'id' => { type => "number" },
            'labels' => { type => "object" },
            'name' => { type => "string" },
        },
    };
);


    