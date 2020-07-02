package VM::HetznerCloud::API::Pricing;

# ABSTRACT: Pricing

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

has endpoint  => ( is => 'ro', isa => Str, default => sub { 'pricing' } );

sub list ($self, %params) {
    my $spec   = {
        type       => "object",
        required   => [qw//],
        properties => {
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

    $cloud->pricing->list(
    );

=head1 ATTRIBUTES

=over 4

=item * endpoint

=back

=head1 METHODS



=head2 list

Get all prices

    $cloud->pricing->list({
        type       => "object",
        required   => [qw//],
        properties => {
        },
    };
);


    