package VM::HetznerCloud::API::Location;

# ABSTRACT: Location

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

has endpoint  => ( is => 'ro', isa => Str, default => sub { 'location' } );


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

    $cloud->location->get(
    );

=head1 ATTRIBUTES

=over 4

=item * endpoint

=back

=head1 METHODS



=head2 get

Get a Location

    $cloud->location->get({
        'id' => joi->required->string,
    };
);


=head2 list

Get all Locations

    $cloud->location->list({
        'name' => joi->string,
    };
);


    