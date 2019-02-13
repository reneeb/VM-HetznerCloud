package VM::HetznerCloud::API::Server;

# ABSTRACT: Server

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

has endpoint  => ( is => 'ro', isa => Str, default => sub { 'server' } );


sub attach_iso ($self, %params) {
    my $spec   = {
        'id' => joi->required->string,
        'iso' => joi->required->string,
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
        '/:id/actions/attach_iso',
        \%request_params
    );
}

sub change_dns_ptr ($self, %params) {
    my $spec   = {
        'dns_ptr' => joi->required->ARRAY(0x56322d7b2bb0),
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
        'rebuild' => joi->boolean,
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

sub change_type ($self, %params) {
    my $spec   = {
        'id' => joi->required->string,
        'server_type' => joi->required->string,
        'upgrade_disk' => joi->required->boolean,
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
        '/:id/actions/change_type',
        \%request_params
    );
}

sub create ($self, %params) {
    my $spec   = {
        'image' => joi->required->string,
        'name' => joi->required->string,
        'server_type' => joi->required->string,
        'automount' => joi->boolean,
        'datacenter' => joi->string,
        'labels' => joi->object,
        'location' => joi->string,
        'ssh_keys' => joi->array,
        'start_after_create' => joi->boolean,
        'user_data' => joi->string,
        'volumes' => joi->array,
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

sub create_image ($self, %params) {
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
        'post',
        '/:id/actions/create_image',
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

sub detach_iso ($self, %params) {
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
        '/:id/actions/detach_iso',
        \%request_params
    );
}

sub disable_backup ($self, %params) {
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
        '/:id/actions/disable_backup',
        \%request_params
    );
}

sub disable_rescue ($self, %params) {
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
        '/:id/actions/disable_rescue',
        \%request_params
    );
}

sub enable_backup ($self, %params) {
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
        '/:id/actions/enable_backup',
        \%request_params
    );
}

sub enable_rescue ($self, %params) {
    my $spec   = {
        'id' => joi->required->string,
        'ssh_keys' => joi->array,
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
        'post',
        '/:id/actions/enable_rescue',
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

sub metrics ($self, %params) {
    my $spec   = {
        'end' => joi->required->string,
        'id' => joi->required->string,
        'start' => joi->required->string,
        'type' => joi->required->string,
        'step' => joi->number,
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
        '/:id/metrics',
        \%request_params
    );
}

sub poweroff ($self, %params) {
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
        '/:id/actions/poweroff',
        \%request_params
    );
}

sub poweron ($self, %params) {
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
        '/:id/actions/poweron',
        \%request_params
    );
}

sub reboot ($self, %params) {
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
        '/:id/actions/reboot',
        \%request_params
    );
}

sub rebuild ($self, %params) {
    my $spec   = {
        'id' => joi->required->string,
        'image' => joi->required->string,
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
        '/:id/actions/rebuild',
        \%request_params
    );
}

sub request_console ($self, %params) {
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
        '/:id/actions/request_console',
        \%request_params
    );
}

sub reset ($self, %params) {
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
        '/:id/actions/reset',
        \%request_params
    );
}

sub reset_password ($self, %params) {
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
        '/:id/actions/reset_password',
        \%request_params
    );
}

sub shutdown ($self, %params) {
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
        '/:id/actions/shutdown',
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

    $cloud->server->attach_iso(
    );

=head1 ATTRIBUTES

=over 4

=item * endpoint

=back

=head1 METHODS



=head2 attach_iso

Attach an ISO to a Server

    $cloud->server->attach_iso({
        'id' => joi->required->string,
        'iso' => joi->required->string,
    };
);


=head2 change_dns_ptr

Change reverse DNS entry for this server

    $cloud->server->change_dns_ptr({
        'dns_ptr' => joi->required->ARRAY(0x56322d7b2bb0),
        'id' => joi->required->string,
        'ip' => joi->required->string,
    };
);


=head2 change_protection

Change protection for a Server

    $cloud->server->change_protection({
        'id' => joi->required->string,
        'delete' => joi->boolean,
        'rebuild' => joi->boolean,
    };
);


=head2 change_type

Change the Type of a Server

    $cloud->server->change_type({
        'id' => joi->required->string,
        'server_type' => joi->required->string,
        'upgrade_disk' => joi->required->boolean,
    };
);


=head2 create

Create a Server

    $cloud->server->create({
        'image' => joi->required->string,
        'name' => joi->required->string,
        'server_type' => joi->required->string,
        'automount' => joi->boolean,
        'datacenter' => joi->string,
        'labels' => joi->object,
        'location' => joi->string,
        'ssh_keys' => joi->array,
        'start_after_create' => joi->boolean,
        'user_data' => joi->string,
        'volumes' => joi->array,
    };
);


=head2 create_image

Create Image from a Server

    $cloud->server->create_image({
        'id' => joi->required->string,
        'description' => joi->string,
        'labels' => joi->object,
        'type' => joi->string,
    };
);


=head2 delete

Delete a Server

    $cloud->server->delete({
        'id' => joi->required->string,
    };
);


=head2 detach_iso

Detach an ISO from a Server

    $cloud->server->detach_iso({
        'id' => joi->required->string,
    };
);


=head2 disable_backup

Disable Backups for a Server

    $cloud->server->disable_backup({
        'id' => joi->required->string,
    };
);


=head2 disable_rescue

Disable Rescue Mode for a Server

    $cloud->server->disable_rescue({
        'id' => joi->required->string,
    };
);


=head2 enable_backup

Enable and Configure Backups for a Server

    $cloud->server->enable_backup({
        'id' => joi->required->string,
    };
);


=head2 enable_rescue

Enable Rescue Mode for a Server

    $cloud->server->enable_rescue({
        'id' => joi->required->string,
        'ssh_keys' => joi->array,
        'type' => joi->string,
    };
);


=head2 get

Get a Server

    $cloud->server->get({
        'id' => joi->required->string,
    };
);


=head2 get_action

Get a specific Action for a Server

    $cloud->server->get_action({
        'action_id' => joi->required->string,
        'id' => joi->required->string,
    };
);


=head2 get_actions

Get all Actions for a Server

    $cloud->server->get_actions({
        'id' => joi->required->string,
        'sort' => joi->enum[string],
        'status' => joi->enum[string],
    };
);


=head2 list

Get all Servers

    $cloud->server->list({
        'label_selector' => joi->string,
        'name' => joi->string,
    };
);


=head2 metrics

Get Metrics for a Server

    $cloud->server->metrics({
        'end' => joi->required->string,
        'id' => joi->required->string,
        'start' => joi->required->string,
        'type' => joi->required->string,
        'step' => joi->number,
    };
);


=head2 poweroff

Power off a Server

    $cloud->server->poweroff({
        'id' => joi->required->string,
    };
);


=head2 poweron

Power on a Server

    $cloud->server->poweron({
        'id' => joi->required->string,
    };
);


=head2 reboot

Soft-reboot a Server

    $cloud->server->reboot({
        'id' => joi->required->string,
    };
);


=head2 rebuild

Rebuild a Server from an Image

    $cloud->server->rebuild({
        'id' => joi->required->string,
        'image' => joi->required->string,
    };
);


=head2 request_console

Request Console for a Server

    $cloud->server->request_console({
        'id' => joi->required->string,
    };
);


=head2 reset

Reset a Server

    $cloud->server->reset({
        'id' => joi->required->string,
    };
);


=head2 reset_password

Reset root Password of a Server

    $cloud->server->reset_password({
        'id' => joi->required->string,
    };
);


=head2 shutdown

Shutdown a Server

    $cloud->server->shutdown({
        'id' => joi->required->string,
    };
);


=head2 update

Update a Server

    $cloud->server->update({
        'id' => joi->required->string,
        'labels' => joi->object,
        'name' => joi->string,
    };
);


    