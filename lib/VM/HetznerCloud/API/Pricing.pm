package VM::HetznerCloud::API::Pricing;

# ABSTRACT: Pricing

# ---
# This class is auto-generated by bin/get_hetzner_info.pl
# ---

use v5.24;

use Moo;
use Types::Standard qw(:all);

use Mojo::Base -strict, -signatures;

extends 'VM::HetznerCloud::APIBase';

use utf8;

# VERSION

has endpoint  => ( is => 'ro', isa => Str, default => sub { 'pricing' } );

sub list ($self, %params) {
    my $request_params = {};
    return $self->_request( '', \%params, $request_params, { type => 'get', oid => '/pricing#get' } );
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

Returns prices for all resources available on the platform. VAT and currency of the Project owner are used for calculations.

Both net and gross prices are included in the response.


    $cloud->pricing->list();


    