package VM::HetznerCloud::Utils;


use Moo::Role;
use Mojo::Base -strict, -signatures;

use Carp;

sub _check_params ($self, $rules, %params ) {
    my %req_params;

    my $man_rules = $rules->{required} || {};

    MANDATORY:
    for my $mandatory ( sort keys %{ $man_rules } ) {
        my $format = $man_rules->{$mandatory};

        if ( !exists $params{$mandatory} ) {
            croak sprintf 'The field %s is mandatory!', $mandatory;
        }
        elsif ( ! $self->_check_type( $params{$mandatory}, $format ) ) {
            croak sprintf 'Wrong format for %s. Expected format: %s',
                $mandatory, $format;
        }

        $req_params{$mandatory} = $params{$mandatory};
    }

    my $opt_rules = $rules->{optional} || {};
    my %errors;

    OPTIONAL:
    for my $optional ( sort keys %{ $opt_rules } ) {
        my $format = $opt_rules->{$optional};

        if ( !exists $params{$optional} ) {
            next OPTIONAL;
        }
        elsif ( ! $self->_check_type( $params{$optional}, $format ) ) {
            $errors{$optional} = 'Wrong format. Expected format: ' . $format;
            next OPTIONAL;
        }

        $req_params{$optional} = $params{$optional};
    }

    return \%req_params;
}

sub _check_type ($self, $value, $required) {
    return 1 if $required eq 'string' && length $value;
    return 1 if $required eq 'number' && $value =~ m{\A[0-9]+\z};

    return 0;
}

1;

=head1 SYNOPSIS

