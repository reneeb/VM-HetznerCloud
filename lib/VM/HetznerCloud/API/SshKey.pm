package VM::HetznerCloud::API::SshKey;

# ABSTRACT: SshKey

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

has endpoint  => ( is => 'ro', isa => Str, default => sub { 'ssh_key' } );


sub create ($self, %params) {
    my $spec   = {
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
        'post',
        '',
        \%request_params
    );
}

sub delete ($self, %params) {
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
        'delete',
        '/:id',
        \%request_params
    );
}

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
        'fingerprint' => joi->string,
        'label_selector' => joi->string,
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

sub update ($self, %params) {
    my $spec   = {
        'id' => joi->required->string,
        'labels' => joi->object,
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
        'put',
        '/:id',
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

    $cloud->ssh_key->create(
    );

=head1 ATTRIBUTES

=over 4

=item * endpoint

=back

=head1 METHODS



=head2 create

Create an SSH key

    $cloud->ssh_key->create({
    };
);


=head2 delete

Delete an SSH key

    $cloud->ssh_key->delete({
        'id' => joi->required->string,
    };
);


=head2 get

Get an SSH key

    $cloud->ssh_key->get({
        'id' => joi->required->string,
    };
);


=head2 list

Get all SSH keys

    $cloud->ssh_key->list({
        'fingerprint' => joi->string,
        'label_selector' => joi->string,
        'name' => joi->string,
    };
);


=head2 update

Update an SSH key

    $cloud->ssh_key->update({
        'id' => joi->required->string,
        'labels' => joi->object,
        'name' => joi->string,
    };
);


    