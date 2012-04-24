package Catalyst::PseudoCatalyst::Request;

use strict;
use warnings;

our $AUTOLOAD;

sub new {
    my $proto = shift;
    my $class = ref($proto) || $proto;

    my $self  = {};
    bless ($self, $class);

    $self->populate( $_[0] );
    $self->{_c} = $_[1];

    return $self;
} 

sub params {
    my ($self) = @_;
    
    return $self->{_c}->{p};
}

# Переписать данные из srchash в desthash (или в качестве собственных полей, если это объект)
# STATIC (desthash, srchash); INSTANCE (srchash)
sub populate {
    my ($self, $hash) = @_;

    return unless ref $self && ref $hash && ref $hash eq 'HASH';

    @{$self}{ keys %$hash } = ( values %$hash );

    return 1;
}

sub address {
    my ($self, $address) = @_;

    if ( $address ) {
        $self->{address} = $address;
    }
    return $self->{address} || $self->_default_address;
}

sub path {
    my ($self, $path) = @_;

    if ( $path ) {
        $self->{path} = $path;
    }
    return $self->{path} || 'test';
}

sub AUTOLOAD {
    (my $subname = $AUTOLOAD) =~ s/.*:://;
    
    return if $subname eq uc $subname;

    my $self = shift;
    
    return $self->{$subname};
}

1;
