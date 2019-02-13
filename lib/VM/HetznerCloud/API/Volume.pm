package VM::HetznerCloud::API::Volume;

# ABSTRACT: Volume

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

has endpoint  => ( is => 'ro', isa => Str, default => sub { 'volume' } );


sub attach ($self, %params) {
    my $spec   = {
        'id' => joi->required->string,
        'server' => joi->required->number,
        'automount' => joi->boolean,
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
        '/:id/actions/attach',
        \%request_params
    );
}

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

sub create ($self, %params) {
    my $spec   = {
        'name' => joi->required->string,
        'size' => joi->required->number,
        'automount' => joi->boolean,
        'format' => joi->string,
        'labels' => joi->object,
        'location' => joi->string,
        'server' => joi->number,
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

sub detach ($self, %params) {
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
        'post',
        '/:id/actions/detach',
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
        'label_selector' => joi->string,
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

sub resize ($self, %params) {
    my $spec   = {
        'id' => joi->required->string,
        'size' => joi->required->number,
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
        '/:id/actions/resize',
        \%request_params
    );
}

sub update ($self, %params) {
    my $spec   = {
        'id' => joi->required->string,
        'name' => joi->required->string,
        'labels' => joi->object,
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

    $cloud->volume->attach(
    );

=head1 ATTRIBUTES

=over 4

=item * endpoint

=back

=head1 METHODS



=head2 attach

Attach Volume to a Server

    $cloud->volume->attach({
        'id' => joi->required->string,
        'server' => joi->required->number,
        'automount' => joi->boolean,
    };
);


=head2 change_protection

Change Volume Protection

    $cloud->volume->change_protection({
        'id' => joi->required->string,
        'delete' => joi->boolean,
    };
);


=head2 create

Create a Volume

    $cloud->volume->create({
        'name' => joi->required->string,
        'size' => joi->required->number,
        'automount' => joi->boolean,
        'format' => joi->string,
        'labels' => joi->object,
        'location' => joi->string,
        'server' => joi->number,
    };
);


=head2 delete

Delete a Volume

    $cloud->volume->delete({
        'id' => joi->required->string,
    };
);


=head2 detach

Detach Volume

    $cloud->volume->detach({
        'id' => joi->required->string,
    };
);


=head2 get

Get a Volume

    $cloud->volume->get({
        'id' => joi->required->string,
    };
);


=head2 get_action

Get an Action for a Volume

    $cloud->volume->get_action({
        'action_id' => joi->required->string,
        'id' => joi->required->string,
    };
);


=head2 get_actions

Get all Actions for a Volume

    $cloud->volume->get_actions({
        'id' => joi->required->string,
        'sort' => joi->enum[string],
        'status' => joi->enum[string],
    };
);


=head2 list

Get all Volumes

    $cloud->volume->list({
        'label_selector' => joi->string,
    };
);


=head2 resize

Resize Volume

    $cloud->volume->resize({
        'id' => joi->required->string,
        'size' => joi->required->number,
    };
);


=head2 update

Update a Volume

    $cloud->volume->update({
        'id' => joi->required->string,
        'name' => joi->required->string,
        'labels' => joi->object,
    };
);


    