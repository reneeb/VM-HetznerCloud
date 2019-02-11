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

my $current_resource;
$dom->find('section.method')->each( sub {
    my $description_div = $_->find('div.method__description')->first;
    my $tmp_resource    = $description_div->find('h2')->first;

    if ( $tmp_resource ) {   
        $current_resource = $tmp_resource->attr('id');
        return;
    }

    if ( !$current_resource || $current_resource eq 'overview' ) {
        return;
    }

    my $description = $description_div->find('h3')->first->text;

    my $uri_text                  = $description_div->children('code')->first->text;
    my ($method, $endpoint, $uri) = $uri_text =~ m{([A-Z]+) \s+ \Q$base\E /? (\w+) (.*) \s* \z}xms;

    $uri //= '';
    $uri =~ s/\{\?.*\}\z//;
    $uri =~ s/\{ (\w+) \}/:$1/xg;

    $endpoint =~ s{s\z}{};
    my $perl_class = join "", map { ucfirst lc $_ } split /_/, $endpoint;

    my $verb = lc $method;
    $verb    = 'create' if $verb eq 'post';
    $verb    = 'update' if $verb eq 'put';

    my @parts = split /\//, $uri;

    my $action_name = $verb;

    my $action = pop @parts;
    if ( !$action ) {
        $action_name = 'list' if $method eq 'GET';
    }
    elsif ( $action eq 'actions' ) {
        $action_name = 'get_actions';
    }
    elsif ( ':' ne substr $action, 0, 1 ) {
        $action_name = $action;
    }
    elsif ( $action eq ':action_id' ) {
        $action_name = 'get_action';
    }


    my %params;
    $_->find( 'table.table--parameters tbody tr' )->each( sub {
         my ($name, $type, $desc) = map{ $_->text }@{ $_->find('td')->to_array };
         
         my ($type_name, $type_required) = split / /, $type;
         my $man_opt = $type_required =~ m{required} ? 'required' : 'optional';
         $params{$man_opt}->{$name} = $type_name;
    });

    $resources{$perl_class}->{$action_name} = {
        type        => lc $method,
        uri         => $uri,
        endpoint    => $endpoint,
        description => $description,
        %params,
    };
});

#say Dumper( \%resources );

for my $class ( keys %resources ) {
    say "Build class $class.pm";
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
        token => $api_key,
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

# ABSTRACT: %s

use v5.10;

use strict;
use warnings;

use Moo;
use Types::Mojo qw(MojoURL);

use parent 'VM::HetznerCloud::Utils';

has base   => ( is => 'ro', required => 1, isa => MojoURL["https?"] );
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
    $class, $class, $dump, $endpoint, $pod;

    return $code;
}
