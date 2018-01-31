package VM::HetznerCloud::Utils;

use v5.10;
use strict;
use warnings;

use Data::Dumper;
use JSON;
use Moo;
use URI::Escape;

sub _build {
    my $package = shift;
    my $part    = shift;
    my $mapping = $self->mapping;

    no strict 'refs';
    for my $name ( keys %{ $mapping }  ) {
        my $rules = $mapping->{$name};
        my $type  = delete $rules->{type};
        say Dumper( $rules );

        *{ $package . '::' . $name } = sub {
            my ($self, %params) = @_;
            my $data = $self->get_params(\%params, $rules);

            return $self->_request(
                $type,
                $part . $data->{path},
                $data->{body},
            );
        }
    }
}

sub get_params {
    my ($self, $params, $rules ) = @_;

    my %errors;

    my $path = $rules->{path} // '';
    my %req_params;

    my $man_rules = $rules->{mandatory} || {};

    MANDATORY:
    for my $mandatory ( sort keys %{ $man_rules } ) {
        my $format = $man_rules->{$mandatory};

        if ( !exists $params->{$mandatory} ) {
            $errors{$mandatory} = 'This field is mandatory!';
        }
        elsif ( ! $self->_check_type( $params->{$mandatory}, $format ) ) {
            $errors{$mandatory} = 'Wrong format. Expected format: ' . $format;
        }

        next MANDATORY if $errors{$mandatory};

        $path =~ s{:(\w+)\b}{ delete $params->{$mandatory} }xmsge;

        if ( exists $params->{$mandatory} ) {
            $req_params{$mandatory} = $params->{$mandatory};
        }
    }

    my $opt_rules = $rules->{optional} || {};

    OPTIONAL:
    for my $optional ( sort keys %{ $opt_rules } ) {
        my $format = $opt_rules->{$optional};

        if ( ! $self->_check_type( $params->{$optional}, $format ) ) {
            $errors{$optional} = 'Wrong format. Expected format: ' . $format;
        }

        next OPTIONAL if $errors{$optional};

        if ( exists $params->{$optional} ) {
            $req_params{$optional} = $params->{$optional};
        }
    }

    my $body  = JSON->new->utf8(1)->encode( \%req_params );
    my $query = join '&', map{ $_ . '=' . uri_escape($req_params{$_}) }sort keys %req_params;

    $path .= '?' . $query if $query;

    return +{
        errors => \%errors,
        body   => $body,
        query  => $query,
        path   => $path,
    }
}

sub _check_type {
    my ($self, $value, $required) = @_;

    return 1 if $required eq 'string' && length $value;
    return 1 if $required eq 'number' && $value =~ m{\A[0-9]+\z};

    return 0;
}

sub _request {
    my ($self, $partial_uri, %opts) = @_;

    return $self->request(
        $uri,
        %opts,
    );
}


1;

