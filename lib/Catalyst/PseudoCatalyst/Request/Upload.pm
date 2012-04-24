package Catalyst::PseudoCatalyst::Request::Upload;

use strict;
use warnings;

use Catalyst::PseudoCatalyst;

sub new {
    my $proto = shift;
    my $class = ref($proto) || $proto;

    my $self  = {};
    bless ($self, $class);

    $self->Catalyst::PseudoCatalyst::populate( $_[0] );

    return $self;
}

sub filename {
    my ($self) = @_;

    return $self->{filename};
}

sub type {
    my ($self) = @_;

    return $self->{type};
}

sub size {
    my ($self) = @_;

    return $self->{size} || 777;
}

sub copy_to {
    my ($self, $dest) = @_;

    my $pseudocontent = $self->filename.';'.$self->type;

    my $DST;
    open( $DST, '>', $dest ) or die "Can't open $dest: $!\n";
    print $DST "$pseudocontent\n";
    close $DST;

    return 1;
}

1;
