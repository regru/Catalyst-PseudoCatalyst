#!/usr/bin/perl

use strict;
use warnings;

use Module::Build;

my $build = Module::Build->new(
    module_name => 'Catalyst::PseudoCatalyst',
    license  => 'perl',
    requires => {
    },
    create_makefile_pl => 'traditional',
    dist_abstract => 'Simple testing of Catalyst controllers',
);

$build->create_build_script;

