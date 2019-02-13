package VM::HetznerCloud::API::ServerType;

# ABSTRACT: ServerType

use v5.10;

use strict;
use warnings;

use Moo;
use Types::Standard qw(:all);

use Mojo::Base -strict, -signatures;

use parent 'VM::HetznerCloud';;

with 'VM::HetznerCloud::Utils';
with 'MooX::Singleton';

use JSON::Validator qw(joi);
use Carp;

has endpoint  => ( is => 'ro', isa => Str, default => sub { 'server_type' } );


sub get ($self, %params) {
    my $spec   = {
        'id' => joi->required->string,
    };

    my @errors = joi(
        \%params,
        joi->object->props( $spec ),
    );

    if ( @errors ) {
        croak 'invalid parameters';
    }

    my %request_params = map{
        exists $params{$_} ?
            ($_ => $params{$_}) :
            ();
    } keys %{$spec},

    $self->request(
        'get',
        '/:id',
        \%request_params
    );
}

sub list ($self, %params) {
    my $spec   = {
        'name' => joi->string,
    };

    my @errors = joi(
        \%params,
        joi->object->props( $spec ),
    );

    if ( @errors ) {
        croak 'invalid parameters';
    }

    my %request_params = map{
        exists $params{$_} ?
            ($_ => $params{$_}) :
            ();
    } keys %{$spec},

    $self->request(
        'get',
        '',
        \%request_params
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
        'id' => joi->required->string,
    };
);


=head2 list

Get all Server Types

    $cloud->server_type->list({
        'name' => joi->string,
    };
);


    