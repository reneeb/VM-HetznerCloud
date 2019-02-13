package VM::HetznerCloud::API::FloatingIp;

# ABSTRACT: FloatingIp

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

has endpoint  => ( is => 'ro', isa => Str, default => sub { 'floating_ip' } );


sub assign ($self, %params) {
    my $spec   = {
        'id' => joi->required->string,
        'server' => joi->required->number,
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
        '/:id/actions/assign',
        \%request_params
    );
}

sub change_dns_ptr ($self, %params) {
    my $spec   = {
        'dns_ptr' => joi->required->ARRAY(0x56322d7bf7b0),
        'id' => joi->required->string,
        'ip' => joi->required->string,
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
        '/:id/actions/change_dns_ptr',
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
        'type' => joi->required->string,
        'description' => joi->string,
        'home_location' => joi->string,
        'labels' => joi->object,
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

sub unassign ($self, %params) {
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
        '/:id/actions/unassign',
        \%request_params
    );
}

sub update ($self, %params) {
    my $spec   = {
        'id' => joi->required->string,
        'description' => joi->string,
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

    $cloud->floating_ip->assign(
    );

=head1 ATTRIBUTES

=over 4

=item * endpoint

=back

=head1 METHODS



=head2 assign

Assign a Floating IP to a Server

    $cloud->floating_ip->assign({
        'id' => joi->required->string,
        'server' => joi->required->number,
    };
);


=head2 change_dns_ptr

Change reverse DNS entry for a Floating IP

    $cloud->floating_ip->change_dns_ptr({
        'dns_ptr' => joi->required->ARRAY(0x56322d7bf7b0),
        'id' => joi->required->string,
        'ip' => joi->required->string,
    };
);


=head2 change_protection

Change protection

    $cloud->floating_ip->change_protection({
        'id' => joi->required->string,
        'delete' => joi->boolean,
    };
);


=head2 create

Create a Floating IP

    $cloud->floating_ip->create({
        'type' => joi->required->string,
        'description' => joi->string,
        'home_location' => joi->string,
        'labels' => joi->object,
        'server' => joi->number,
    };
);


=head2 delete

Delete a Floating IP

    $cloud->floating_ip->delete({
        'id' => joi->required->string,
    };
);


=head2 get

Get a specific Floating IP

    $cloud->floating_ip->get({
        'id' => joi->required->string,
    };
);


=head2 get_action

Get an Action for a Floating IP

    $cloud->floating_ip->get_action({
        'action_id' => joi->required->string,
        'id' => joi->required->string,
    };
);


=head2 get_actions

Get all Actions for a Floating IP

    $cloud->floating_ip->get_actions({
        'id' => joi->required->string,
        'sort' => joi->enum[string],
        'status' => joi->enum[string],
    };
);


=head2 list

Get all Floating IPs

    $cloud->floating_ip->list({
        'label_selector' => joi->string,
    };
);


=head2 unassign

Unassign a Floating IP

    $cloud->floating_ip->unassign({
        'id' => joi->required->string,
    };
);


=head2 update

Update a Floating IP

    $cloud->floating_ip->update({
        'id' => joi->required->string,
        'description' => joi->string,
        'labels' => joi->object,
    };
);


    