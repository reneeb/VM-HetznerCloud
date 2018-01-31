#!/usr/bin/env perl

use v5.20;

use strict;
use warnings;

use Mojo::UserAgent;
use Data::Dumper;
use File::Basename;
use File::Spec;

my $ua   = Mojo::UserAgent->new;
my $url  = 'https://docs.hetzner.cloud';
my $base = 'https://api.hetzner.cloud/v1/';

my $tx  = $ua->get( $url );
my $dom = $tx->res->dom;

my %resources;
my %action_mapping = _get_action_mapping();

$dom->find('div.action')->each( sub {
    my $resource_name = $_->attr('id')    =~ s{resources-}{}r;
    my $classes       = $_->attr('class') =~ s{action }{}r;
    my $description   = $_->find('a.name')->first->text;

    my $uri_text         = $_->find('code.uri')->first->text;
    my ($endpoint, $uri) = $uri_text =~ m{[A-Z]+ \s+ \Q$base\E /? (\w+) (.*) \s* \z}xms;
    $uri =~ s/\{\?.*\}\z//;
    $uri =~ s/\{ (\w+) \}/:$1/xg;

    my $perl_class = join "", map { ucfirst lc $_ } split /_/, $endpoint;
    $perl_class =~ s{s\z}{};

    my %params;
    $_->find( 'div.title' )->each( sub {
        my $text = $_->at('strong')->text;

        return if $text eq 'Reply';
        return if $text eq 'HTTP Request';

        $_->next->find( 'tbody tr' )->each( sub {
            my $infos = $_->find('td')->slice( 0, 1 )->to_array;

            my $name          = $infos->[0]->at('strong')->text;
            my ($type_string) = $infos->[1]->text =~ m{\A([\w,]+)}xms;
            my @types         = split /,/, $type_string;

            my $type = @types > 1 ? [ @types ] : $types[0];

            if ( $infos->[1]->find('span.required')->size > 0 ) {
                $params{mandatory}->{$name} = $type;
            }
            else {
                $params{optional}->{$name} = $type;
            }
        });
    });

    my $key    = join '###', $classes, $endpoint, $uri;
    my $method = delete $action_mapping{$key};

    if ( !$method ) {
        warn "Didn't find an action for $key";
        $method = $resource_name;
    }

    $resources{$perl_class}->{$method} = {
        type        => $classes,
        uri         => $uri,
        endpoint    => $endpoint,
        description => $description,
        %params,
    };
});


#say Dumper( \%resources );
for my $class ( keys %resources ) {
    my $def = $resources{$class};

    my $code = _get_code( $class, $def );
    my $path = File::Spec->catfile(
        dirname( __FILE__ ),
        qw/.. lib VM HetznerCloud/,
        "$class.pm"
    );

    my $fh = IO::File->new( $path, 'w' );
    $fh->print( $code );
    $fh->close;
}

sub _get_action_mapping {
    return (
        'get###datacenters###/:id'                          => 'get',
        'get###datacenters###'                              => 'list',
        'post###ssh_keys###'                                => 'add',
        'delete###ssh_keys###/:id'                          => 'delete',
        'get###ssh_keys###'                                 => 'list',
        'get###ssh_keys###/:id'                             => 'get',
        'put###ssh_keys###/:id'                             => 'update',
        'delete###images###/:id'                            => 'delete',
        'get###images###/:id'                               => 'get',
        'get###images###'                                   => 'list',
        'put###images###/:id'                               => 'update',
        'get###actions###'                                  => 'list',
        'get###actions###/:id'                              => 'get',
        'put###actions###/:id'                              => 'update',
        'get###isos###'                                     => 'list',
        'get###isos###/:id'                                 => 'get',
        'post###floating_ips###'                            => 'add',
        'delete###floating_ips###/:id'                      => 'delete',
        'get###floating_ips###/:id'                         => 'get',
        'put###floating_ips###/:id'                         => 'update',
        'get###floating_ips###'                             => 'list',
        'post###floating_ips###/:id/actions/assign'         => 'assign',
        'get###floating_ips###/:id/actions/:action_id'      => 'get_action',
        'post###floating_ips###/:id/actions/unassign'       => 'unassign',
        'post###floating_ips###/:id/actions/change_dns_ptr' => 'change_dns_ptr',
        'get###floating_ips###/:id/actions'                 => 'action_list',
        'post###servers###'                                 => 'create',
        'get###servers###'                                  => 'list',
        'get###servers###/:id'                              => 'get',
        'put###servers###/:id'                              => 'update',
        'delete###servers###/:id'                           => 'delete',
        'get###servers###/:id/actions'                      => 'action_list',
        'get###servers###/:id/actions/:action_id'           => 'get_action',
        'post###servers###/:id/actions/rebuild'             => 'rebuild',
        'post###servers###/:id/actions/change_type'         => 'change_type',
        'post###servers###/:id/actions/poweron'             => 'poweron',
        'post###servers###/:id/actions/poweroff'            => 'poweroff',
        'post###servers###/:id/actions/reboot'              => 'reboot',
        'post###servers###/:id/actions/create_image'        => 'create_image',
        'post###servers###/:id/actions/shutdown'            => 'shutdown',
        'post###servers###/:id/actions/change_dns_ptr'      => 'change_dns_ptr',
        'post###servers###/:id/actions/disable_backup'      => 'disable_backup',
        'post###servers###/:id/actions/reset_password'      => 'reset_password',
        'post###servers###/:id/actions/enable_backup'       => 'enable_backup',
        'post###servers###/:id/actions/enable_rescue'       => 'enable_rescue',
        'post###servers###/:id/actions/disable_rescue'      => 'disable_rescue',
        'post###servers###/:id/actions/detach_iso'          => 'detach_iso',
        'post###servers###/:id/actions/attach_iso'          => 'attach_iso',
        'post###servers###/:id/actions/reset'               => 'reset',
        'get###servers###/:id/metrics'                      => 'metrics',
        'get###locations###'                                => 'list',
        'get###locations###/:id'                            => 'get',
        'get###server_types###'                             => 'list',
        'get###server_types###/:id'                         => 'get',
        'get###pricing###'                                  => 'list',
    );
}

sub _get_code {
    my ($class, $definitions) = @_;

    my $methods_pod = '';
    my $endpoint    = '';
    my $method_name = '';
    my $obj_method  = '';

    for my $method ( sort keys %{ $definitions } ) {
        $endpoint       = delete $definitions->{$method}->{endpoint};
        my $description = delete $definitions->{$method}->{description};
        $obj_method     = $endpoint =~ s{s\z}{}r;
        $method_name  ||= $method;

        my $params = '';
        for my $type ( qw/mandatory optional/ ) {
            my $type_param = $definitions->{$method}->{$type} || {};
            for my $param ( sort keys %{ $type_param } ) {
                $params .= sprintf "\n        %s => %s,     # %s", $param, $type_param->{$param}, $type;
            }
        }

        $params .= "\n    " if $params;

        $methods_pod .= sprintf q~

=head2 %s

%s

    $cloud->%s->%s(%s);
~,
        $method, $description, $obj_method, $method, $params;
    }

    my $pod = sprintf q~

=head1 SYNOPSIS

    use VM::HetznerCloud;

    my $api_key = '1234abc';
    my $cloud   = VM::HetznerCloud->new(
        api_key => $api_key,
    );

    $cloud->%s->%s(
    );

=head1 METHODS

%s
~,
    $obj_method, $method_name, $methods_pod;

    local $Data::Dumper::Sortkeys = 1;
    local $Data::Dumper::Indent   = 1;

    my $dump = Dumper( $definitions );
    $dump    =~ s{\$VAR1 \s+ = \s+}{+}xms;


    my $code = sprintf q~package VM::HetznerCloud::%s;

# ABSTRACT:

use v5.10;

use strict;
use warnings;

use Moo;

use parent 'VM::HetznerCloud::Utils';

has base   => ( is => 'ro', required => 1, isa => sub {} );
has mapping => ( is => 'ro', default => sub {
%s;
});

around new => sub {
    my $orig  = shift;
    my $class = shift;

    my $self = $orig->( @_ );
    $self->_build(
        __PACKAGE__,
        '%s',
    );

    return $self;
};

1;

__END__

=pod

%s
    ~,
    $class, $dump, $endpoint, $pod;

    return $code;
}
