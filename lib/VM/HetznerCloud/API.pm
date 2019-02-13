package VM::HetznerCloud::API;

use Moo::Role;

use Mojo::Base -strict, -signatures;
use Mojo::File;
use Mojo::Util qw(decamelize);

use Module::Runtime qw(require_module);

sub load_namespace ($package) {
    my $files = Mojo::File->new(
        __FILE__
    )->dirname->child('API')->list->each( sub {
        my $base = $_->basename;
        return if '.pm' ne substr $base, -3;

        $base =~ s{\.pm\z}{};
        my $module = $package . '::API::' . $base;

        require_module $module;

        no strict 'refs';
        *{ $package . '::' . decamelize( $base ) } = sub ($cloud) {
            $module->instance(
            );
        };
    });
}

1;
