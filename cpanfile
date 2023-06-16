# This file is generated by Dist::Zilla::Plugin::SyncCPANfile v0.02
# Do not edit this file directly. To change prereqs, edit the `dist.ini` file.

requires "Carp" => "0";
requires "Module::Runtime" => "0";
requires "Mojolicious" => "8";
requires "Moo" => "1.003001";
requires "MooX::Singleton" => "0";
requires "Types::Mojo" => "0.04";
requires "URI::Escape" => "0";
requires "perl" => "5.020";

on 'test' => sub {
    requires "File::Copy" => "0";
    requires "File::Path" => "0";
    requires "FindBin" => "0";
    requires "Pod::Coverage::TrustPod" => "0";
    requires "Test::LongString" => "0.16";
};

on 'configure' => sub {
    requires "ExtUtils::MakeMaker" => "0";
};

on 'develop' => sub {
    requires "JSON::XS" => "0";
    requires "Pod::Coverage::TrustPod" => "0";
    requires "Test::BOM" => "0";
    requires "Test::More" => "0.88";
    requires "Test::NoTabs" => "0";
    requires "Test::Perl::Critic" => "0";
    requires "Test::Pod" => "1.41";
    requires "Test::Pod::Coverage" => "1.08";
};
