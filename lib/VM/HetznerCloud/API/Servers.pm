package VM::HetznerCloud::API::Servers;

# ABSTRACT: Servers

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

has endpoint  => ( is => 'ro', isa => Str, default => sub { 'servers' } );

sub attach_iso ($self, %params) {
    my $spec   = {
        type       => "object",
        required   => [qw/id iso/],
        properties => {
            'id' => { type => "string" },
            'iso' => { type => "string" },
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
        '/:id/actions/attach_iso',
        { type => 'post' },
        \%request_params,
    );
}

sub attach_to_network ($self, %params) {
    my $spec   = {
        type       => "object",
        required   => [qw/id network/],
        properties => {
            'id' => { type => "string" },
            'network' => { type => "number" },
            'alias_ips' => { type => "array" },
            'ip' => { type => "string" },
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
        '/:id/actions/attach_to_network',
        { type => 'post' },
        \%request_params,
    );
}

sub change_alias_ips ($self, %params) {
    my $spec   = {
        type       => "object",
        required   => [qw/alias_ips id network/],
        properties => {
            'alias_ips' => { type => "array" },
            'id' => { type => "string" },
            'network' => { type => "number" },
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
        '/:id/actions/change_alias_ips',
        { type => 'post' },
        \%request_params,
    );
}

sub change_dns_ptr ($self, %params) {
    my $spec   = {
        type       => "object",
        required   => [qw/dns_ptr id ip/],
        properties => {
            'dns_ptr' => { type => "ARRAY(0x5654e64add88)" },
            'id' => { type => "string" },
            'ip' => { type => "string" },
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
        '/:id/actions/change_dns_ptr',
        { type => 'post' },
        \%request_params,
    );
}

sub change_protection ($self, %params) {
    my $spec   = {
        type       => "object",
        required   => [qw/id/],
        properties => {
            'id' => { type => "string" },
            'delete' => { type => "boolean" },
            'rebuild' => { type => "boolean" },
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
        '/:id/actions/change_protection',
        { type => 'post' },
        \%request_params,
    );
}

sub change_type ($self, %params) {
    my $spec   = {
        type       => "object",
        required   => [qw/id server_type upgrade_disk/],
        properties => {
            'id' => { type => "string" },
            'server_type' => { type => "string" },
            'upgrade_disk' => { type => "boolean" },
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
        '/:id/actions/change_type',
        { type => 'post' },
        \%request_params,
    );
}

sub create ($self, %params) {
    my $spec   = {
        type       => "object",
        required   => [qw/image name server_type/],
        properties => {
            'image' => { type => "string" },
            'name' => { type => "string" },
            'server_type' => { type => "string" },
            'automount' => { type => "boolean" },
            'datacenter' => { type => "string" },
            'labels' => { type => "object" },
            'location' => { type => "string" },
            'networks' => { type => "array" },
            'ssh_keys' => { type => "array" },
            'start_after_create' => { type => "boolean" },
            'user_data' => { type => "string" },
            'volumes' => { type => "array" },
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
        { type => 'post' },
        \%request_params,
    );
}

sub create_image ($self, %params) {
    my $spec   = {
        type       => "object",
        required   => [qw/id/],
        properties => {
            'id' => { type => "string" },
            'description' => { type => "string" },
            'labels' => { type => "object" },
            'type' => { type => "string" },
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
        '/:id/actions/create_image',
        { type => 'post' },
        \%request_params,
    );
}

sub delete ($self, %params) {
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
        { type => 'delete' },
        \%request_params,
    );
}

sub detach_from_network ($self, %params) {
    my $spec   = {
        type       => "object",
        required   => [qw/id network/],
        properties => {
            'id' => { type => "string" },
            'network' => { type => "number" },
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
        '/:id/actions/detach_from_network',
        { type => 'post' },
        \%request_params,
    );
}

sub detach_iso ($self, %params) {
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
        '/:id/actions/detach_iso',
        { type => 'post' },
        \%request_params,
    );
}

sub disable_backup ($self, %params) {
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
        '/:id/actions/disable_backup',
        { type => 'post' },
        \%request_params,
    );
}

sub disable_rescue ($self, %params) {
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
        '/:id/actions/disable_rescue',
        { type => 'post' },
        \%request_params,
    );
}

sub enable_backup ($self, %params) {
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
        '/:id/actions/enable_backup',
        { type => 'post' },
        \%request_params,
    );
}

sub enable_rescue ($self, %params) {
    my $spec   = {
        type       => "object",
        required   => [qw/id/],
        properties => {
            'id' => { type => "string" },
            'ssh_keys' => { type => "array" },
            'type' => { type => "string" },
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
        '/:id/actions/enable_rescue',
        { type => 'post' },
        \%request_params,
    );
}

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
        croak 'invalid parameters:' . join ', ', @errors;
    }

    my %request_params = map{
        exists $params{$_} ?
            ($_ => $params{$_}) :
            ();
    } keys %{$spec->{properties}};

    $self->request(
        ':id',
        { type => 'get' },
        \%request_params,
    );
}

sub get_action ($self, %params) {
    my $spec   = {
        type       => "object",
        required   => [qw/action_id id/],
        properties => {
            'action_id' => { type => "string" },
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
        '/:id/actions/:action_id',
        { type => 'get' },
        \%request_params,
    );
}

sub get_actions ($self, %params) {
    my $spec   = {
        type       => "object",
        required   => [qw/id/],
        properties => {
            'id' => { type => "string" },
            'sort' => { type => "enum[string]" },
            'status' => { type => "enum[string]" },
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
        '/:id/actions',
        { type => 'get' },
        \%request_params,
    );
}

sub list ($self, %params) {
    my $spec   = {
        type       => "object",
        required   => [qw//],
        properties => {
            'label_selector' => { type => "string" },
            'name' => { type => "string" },
            'sort' => { type => "enum[string]" },
            'status' => { type => "enum[string]" },
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

sub metrics ($self, %params) {
    my $spec   = {
        type       => "object",
        required   => [qw/end id start type/],
        properties => {
            'end' => { type => "string" },
            'id' => { type => "string" },
            'start' => { type => "string" },
            'type' => { type => "string" },
            'step' => { type => "number" },
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
        '/:id/metrics',
        { type => 'get' },
        \%request_params,
    );
}

sub poweroff ($self, %params) {
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
        '/:id/actions/poweroff',
        { type => 'post' },
        \%request_params,
    );
}

sub poweron ($self, %params) {
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
        '/:id/actions/poweron',
        { type => 'post' },
        \%request_params,
    );
}

sub reboot ($self, %params) {
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
        '/:id/actions/reboot',
        { type => 'post' },
        \%request_params,
    );
}

sub rebuild ($self, %params) {
    my $spec   = {
        type       => "object",
        required   => [qw/id image/],
        properties => {
            'id' => { type => "string" },
            'image' => { type => "string" },
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
        '/:id/actions/rebuild',
        { type => 'post' },
        \%request_params,
    );
}

sub request_console ($self, %params) {
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
        '/:id/actions/request_console',
        { type => 'post' },
        \%request_params,
    );
}

sub reset ($self, %params) {
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
        '/:id/actions/reset',
        { type => 'post' },
        \%request_params,
    );
}

sub reset_password ($self, %params) {
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
        '/:id/actions/reset_password',
        { type => 'post' },
        \%request_params,
    );
}

sub shutdown ($self, %params) {
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
        '/:id/actions/shutdown',
        { type => 'post' },
        \%request_params,
    );
}

sub update ($self, %params) {
    my $spec   = {
        type       => "object",
        required   => [qw/id/],
        properties => {
            'id' => { type => "string" },
            'labels' => { type => "object" },
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
        '/:id',
        { type => 'put' },
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
        type       => "object",
        required   => [qw/id iso/],
        properties => {
            'id' => { type => "string" },
            'iso' => { type => "string" },
        },
    };
);


=head2 attach_to_network

Attach a Server to a Network

    $cloud->server->attach_to_network({
        type       => "object",
        required   => [qw/id network/],
        properties => {
            'id' => { type => "string" },
            'network' => { type => "number" },
            'alias_ips' => { type => "array" },
            'ip' => { type => "string" },
        },
    };
);


=head2 change_alias_ips

Change alias IPs of a Network

    $cloud->server->change_alias_ips({
        type       => "object",
        required   => [qw/alias_ips id network/],
        properties => {
            'alias_ips' => { type => "array" },
            'id' => { type => "string" },
            'network' => { type => "number" },
        },
    };
);


=head2 change_dns_ptr

Change reverse DNS entry for this Server

    $cloud->server->change_dns_ptr({
        type       => "object",
        required   => [qw/dns_ptr id ip/],
        properties => {
            'dns_ptr' => { type => "ARRAY(0x5654e64add88)" },
            'id' => { type => "string" },
            'ip' => { type => "string" },
        },
    };
);


=head2 change_protection

Change Server Protection

    $cloud->server->change_protection({
        type       => "object",
        required   => [qw/id/],
        properties => {
            'id' => { type => "string" },
            'delete' => { type => "boolean" },
            'rebuild' => { type => "boolean" },
        },
    };
);


=head2 change_type

Change the Type of a Server

    $cloud->server->change_type({
        type       => "object",
        required   => [qw/id server_type upgrade_disk/],
        properties => {
            'id' => { type => "string" },
            'server_type' => { type => "string" },
            'upgrade_disk' => { type => "boolean" },
        },
    };
);


=head2 create

Create a Server

    $cloud->server->create({
        type       => "object",
        required   => [qw/image name server_type/],
        properties => {
            'image' => { type => "string" },
            'name' => { type => "string" },
            'server_type' => { type => "string" },
            'automount' => { type => "boolean" },
            'datacenter' => { type => "string" },
            'labels' => { type => "object" },
            'location' => { type => "string" },
            'networks' => { type => "array" },
            'ssh_keys' => { type => "array" },
            'start_after_create' => { type => "boolean" },
            'user_data' => { type => "string" },
            'volumes' => { type => "array" },
        },
    };
);


=head2 create_image

Create Image from a Server

    $cloud->server->create_image({
        type       => "object",
        required   => [qw/id/],
        properties => {
            'id' => { type => "string" },
            'description' => { type => "string" },
            'labels' => { type => "object" },
            'type' => { type => "string" },
        },
    };
);


=head2 delete

Delete a Server

    $cloud->server->delete({
        type       => "object",
        required   => [qw/id/],
        properties => {
            'id' => { type => "string" },
        },
    };
);


=head2 detach_from_network

Detach a Server from a Network

    $cloud->server->detach_from_network({
        type       => "object",
        required   => [qw/id network/],
        properties => {
            'id' => { type => "string" },
            'network' => { type => "number" },
        },
    };
);


=head2 detach_iso

Detach an ISO from a Server

    $cloud->server->detach_iso({
        type       => "object",
        required   => [qw/id/],
        properties => {
            'id' => { type => "string" },
        },
    };
);


=head2 disable_backup

Disable Backups for a Server

    $cloud->server->disable_backup({
        type       => "object",
        required   => [qw/id/],
        properties => {
            'id' => { type => "string" },
        },
    };
);


=head2 disable_rescue

Disable Rescue Mode for a Server

    $cloud->server->disable_rescue({
        type       => "object",
        required   => [qw/id/],
        properties => {
            'id' => { type => "string" },
        },
    };
);


=head2 enable_backup

Enable and Configure Backups for a Server

    $cloud->server->enable_backup({
        type       => "object",
        required   => [qw/id/],
        properties => {
            'id' => { type => "string" },
        },
    };
);


=head2 enable_rescue

Enable Rescue Mode for a Server

    $cloud->server->enable_rescue({
        type       => "object",
        required   => [qw/id/],
        properties => {
            'id' => { type => "string" },
            'ssh_keys' => { type => "array" },
            'type' => { type => "string" },
        },
    };
);


=head2 get

Get a Server

    $cloud->server->get({
        type       => "object",
        required   => [qw/id/],
        properties => {
            'id' => { type => "string" },
        },
    };
);


=head2 get_action

Get an Action for a Server

    $cloud->server->get_action({
        type       => "object",
        required   => [qw/action_id id/],
        properties => {
            'action_id' => { type => "string" },
            'id' => { type => "string" },
        },
    };
);


=head2 get_actions

Get all Actions for a Server

    $cloud->server->get_actions({
        type       => "object",
        required   => [qw/id/],
        properties => {
            'id' => { type => "string" },
            'sort' => { type => "enum[string]" },
            'status' => { type => "enum[string]" },
        },
    };
);


=head2 list

Get all Servers

    $cloud->server->list({
        type       => "object",
        required   => [qw//],
        properties => {
            'label_selector' => { type => "string" },
            'name' => { type => "string" },
            'sort' => { type => "enum[string]" },
            'status' => { type => "enum[string]" },
        },
    };
);


=head2 metrics

Get Metrics for a Server

    $cloud->server->metrics({
        type       => "object",
        required   => [qw/end id start type/],
        properties => {
            'end' => { type => "string" },
            'id' => { type => "string" },
            'start' => { type => "string" },
            'type' => { type => "string" },
            'step' => { type => "number" },
        },
    };
);


=head2 poweroff

Power off a Server

    $cloud->server->poweroff({
        type       => "object",
        required   => [qw/id/],
        properties => {
            'id' => { type => "string" },
        },
    };
);


=head2 poweron

Power on a Server

    $cloud->server->poweron({
        type       => "object",
        required   => [qw/id/],
        properties => {
            'id' => { type => "string" },
        },
    };
);


=head2 reboot

Soft-reboot a Server

    $cloud->server->reboot({
        type       => "object",
        required   => [qw/id/],
        properties => {
            'id' => { type => "string" },
        },
    };
);


=head2 rebuild

Rebuild a Server from an Image

    $cloud->server->rebuild({
        type       => "object",
        required   => [qw/id image/],
        properties => {
            'id' => { type => "string" },
            'image' => { type => "string" },
        },
    };
);


=head2 request_console

Request Console for a Server

    $cloud->server->request_console({
        type       => "object",
        required   => [qw/id/],
        properties => {
            'id' => { type => "string" },
        },
    };
);


=head2 reset

Reset a Server

    $cloud->server->reset({
        type       => "object",
        required   => [qw/id/],
        properties => {
            'id' => { type => "string" },
        },
    };
);


=head2 reset_password

Reset root Password of a Server

    $cloud->server->reset_password({
        type       => "object",
        required   => [qw/id/],
        properties => {
            'id' => { type => "string" },
        },
    };
);


=head2 shutdown

Shutdown a Server

    $cloud->server->shutdown({
        type       => "object",
        required   => [qw/id/],
        properties => {
            'id' => { type => "string" },
        },
    };
);


=head2 update

Update a Server

    $cloud->server->update({
        type       => "object",
        required   => [qw/id/],
        properties => {
            'id' => { type => "string" },
            'labels' => { type => "object" },
            'name' => { type => "string" },
        },
    };
);


    