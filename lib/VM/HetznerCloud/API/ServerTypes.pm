package VM::HetznerCloud::API::ServerTypes;

# ABSTRACT: ServerTypes

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

has endpoint  => ( is => 'ro', isa => Str, default => sub { 'server_types' } );

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

sub list ($self, %params) {
    my $spec   = {
        type       => "object",
        required   => [qw//],
        properties => {
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


1;

__END__

=pod



=head1 SYNOPSIS

    use VM::HetznerCloud;

    my $api_key = '1234abc';
    my $cloud   = VM::HetznerCloud->new(
        token => $api_key,
    );

    $cloud->server_type->get(
    );

=head1 ATTRIBUTES

=over 4

=item * endpoint

=back

=head1 METHODS



=head2 get

Get a Server Type

    $cloud->server_type->get({
        type       => "object",
        required   => [qw/id/],
        properties => {
            'id' => { type => "string" },
        },
    };
);


=head2 list

Get all Server Types

    $cloud->server_type->list({
        type       => "object",
        required   => [qw//],
        properties => {
            'name' => { type => "string" },
        },
    };
);


    