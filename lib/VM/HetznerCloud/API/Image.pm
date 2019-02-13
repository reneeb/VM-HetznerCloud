package VM::HetznerCloud::API::Image;

# ABSTRACT: Image

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

has endpoint  => ( is => 'ro', isa => Str, default => sub { 'image' } );


sub change_protection ($self, %params) {
    my $spec   = {
        'id' => joi->required->string,
        'delete' => joi->boolean,
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
        '/:id/actions/change_protection',
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

sub get_action ($self, %params) {
    my $spec   = {
        'action_id' => joi->required->string,
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
        '/:id/actions/:action_id',
        \%request_params
    );
}

sub get_actions ($self, %params) {
    my $spec   = {
        'id' => joi->required->string,
        'sort' => joi->enum[string],
        'status' => joi->enum[string],
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
        '/:id/actions',
        \%request_params
    );
}

sub list ($self, %params) {
    my $spec   = {
        'bound_to' => joi->string,
        'label_selector' => joi->string,
        'name' => joi->string,
        'sort' => joi->enum[string],
        'type' => joi->enum[string],
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
        'description' => joi->string,
        'labels' => joi->object,
        'type' => joi->string,
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

    $cloud->image->change_protection(
    );

=head1 ATTRIBUTES

=over 4

=item * endpoint

=back

=head1 METHODS



=head2 change_protection

Change protection for an Image

    $cloud->image->change_protection({
        'id' => joi->required->string,
        'delete' => joi->boolean,
    };
);


=head2 delete

Delete an Image

    $cloud->image->delete({
        'id' => joi->required->string,
    };
);


=head2 get

Get an Image

    $cloud->image->get({
        'id' => joi->required->string,
    };
);


=head2 get_action

Get an Action for an Image

    $cloud->image->get_action({
        'action_id' => joi->required->string,
        'id' => joi->required->string,
    };
);


=head2 get_actions

Get all Actions for an Image

    $cloud->image->get_actions({
        'id' => joi->required->string,
        'sort' => joi->enum[string],
        'status' => joi->enum[string],
    };
);


=head2 list

Get all Images

    $cloud->image->list({
        'bound_to' => joi->string,
        'label_selector' => joi->string,
        'name' => joi->string,
        'sort' => joi->enum[string],
        'type' => joi->enum[string],
    };
);


=head2 update

Update an Image

    $cloud->image->update({
        'id' => joi->required->string,
        'description' => joi->string,
        'labels' => joi->object,
        'type' => joi->string,
    };
);


    