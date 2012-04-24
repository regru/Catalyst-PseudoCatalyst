package Catalyst::PseudoCatalyst::Response;

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

sub status {
    my $self = shift;

    return 200;
}

1;
