[![Kwalitee status](https://cpants.cpanauthors.org/dist/VM-HetznerCloud.png)](https://cpants.cpanauthors.org/dist/VM-HetznerCloud)
[![GitHub issues](https://img.shields.io/github/issues/reneeb/VM-HetznerCloud.svg)](https://github.com/reneeb/VM-HetznerCloud/issues)
[![CPAN Cover Status](https://cpancoverbadge.perl-services.de/VM-HetznerCloud-0.0.3)](https://cpancoverbadge.perl-services.de/VM-HetznerCloud-0.0.3)
[![Cpan license](https://img.shields.io/cpan/l/VM-HetznerCloud.svg)](https://metacpan.org/release/VM-HetznerCloud)

# NAME

VM::HetznerCloud - Perl library to work with the API for the Hetzner Cloud

# VERSION

version 0.0.3

# SYNOPSIS

```perl
use VM::HetznerCloud;

my $cloud = VM::HetznerCloud->new(
    token => 'ABCDEFG1234567',    # your api token
);

my $server_client = $cloud->server;
my $server_list   = $server_client->list;
```

# ATTRIBUTES

- base\_uri

    _(optional)_ Default: v1

- client 

    _(optional)_ A `Mojo::UserAgent` compatible user agent. By default a new object of `Mojo::UserAgent`
    is created.

- host

    _(optional)_ This is the URL to Hetzner's Cloud-API. Defaults to `https://api.hetzner.cloud`

- token

    **_(required)_** Your API token.

# METHODS

## actions

## certificates

## datacenters

## firewalls

## floating\_ips

## images

## isos

## load\_balancer\_types

## load\_balancers

## locations

## networks

## placement\_groups

## pricing

## primary\_ips

## server\_types

## servers

## ssh\_keys

## volumes



# Development

The distribution is contained in a Git repository, so simply clone the
repository

```
$ git clone git://github.com/reneeb/VM-HetznerCloud.git
```

and change into the newly-created directory.

```
$ cd VM-HetznerCloud
```

The project uses [`Dist::Zilla`](https://metacpan.org/pod/Dist::Zilla) to
build the distribution, hence this will need to be installed before
continuing:

```
$ cpanm Dist::Zilla
```

To install the required prequisite packages, run the following set of
commands:

```
$ dzil authordeps --missing | cpanm
$ dzil listdeps --author --missing | cpanm
```

The distribution can be tested like so:

```
$ dzil test
```

To run the full set of tests (including author and release-process tests),
add the `--author` and `--release` options:

```
$ dzil test --author --release
```

# AUTHOR

Renee Baecker <reneeb@cpan.org>

# COPYRIGHT AND LICENSE

This software is Copyright (c) 2018 by Renee Baecker.

This is free software, licensed under:

```
The Artistic License 2.0 (GPL Compatible)
```
