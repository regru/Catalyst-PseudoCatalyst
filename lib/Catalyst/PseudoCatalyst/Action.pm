package Catalyst::PseudoCatalyst::Action;

use strict;
use warnings;

use Data::Dumper;

sub new {
    my $class = shift;
    my $self  = shift  || { attributes => { } };

    return bless $self, $class;
}

sub attributes {
    my $self = shift;

    return $self->{attributes};
}

sub name {
    my $self = shift;

    return 'some_action_name';
}

sub namespace {
    my $self = shift;

    return '';
}

1;
