package Catalyst::PseudoCatalyst;

use strict;
use warnings;

use Data::Dumper;

use Catalyst::PseudoCatalyst::Request;
use Catalyst::PseudoCatalyst::Response;
use Catalyst::PseudoCatalyst::Action;

our $VERSION = 0.04;

our $AUTOLOAD;
our $DEBUG;


sub new {
    my $proto = shift;
    my $class = ref($proto) || $proto;

    my $self  = { attributes => { ApiAuth => [  ] } }; # ApiAuth => [ 'reseller' ] 
    bless ($self, $class);

    my $par = $_[0];

    $self->populate( $par );

    return $self;
} 

# Переписать данные из srchash в desthash (или в качестве собственных полей, если это объект)
# STATIC (desthash, srchash); INSTANCE (srchash)
sub populate {
    my ($self, $hash) = @_;

    return unless ref $self && ref $hash && ref $hash eq 'HASH';

    @{$self}{ keys %$hash } = ( values %$hash );

    return 1;
}

sub req {
    my ($self) = @_;

    return new Catalyst::PseudoCatalyst::Request( $self->{req}, $self );
}

sub request {
    req(@_);
}

sub session {
    my ($self) = @_;

    return $self->{s};
}

sub action {
    my ($self) = @_;

    return new Catalyst::PseudoCatalyst::Action( { attributes => $self->{attributes} } );
}

sub response {
    my ($self) = @_;

    return new Catalyst::PseudoCatalyst::Response( { attributes => $self->{attributes} } );
}

sub view {
    my ($self) = @_;

}

sub model {
    my ($self) = @_;

}

sub error {
    my ($self) = @_;

    return {};
}

sub detach {
    my ($self, $action, @arguments) = @_;

    print "[detach => $action]\n" if $DEBUG;
    $self->forward( $action, @arguments );
}

sub forward {
    my ($self, $action, @arguments) = @_;

    # Отладочные сообщения, проверки...

    my $args = scalar @arguments ? ' ('.join(',', @arguments).')' : '';
    print "# [forward => $action$args]\n" if $DEBUG;

    if ($action =~ tr|/.|/.|) {
        warn "# Complex forwards are not supported." if $DEBUG;
    }

    my @args = get_caller_args(1);
    # my $package = $args[0]; 
    my $package = (caller)[0]; # nrgs

    {
        no strict 'refs';

        my $method_ref = \&{ "${package}::${action}" };

        if ($method_ref)  {
            return $method_ref->( { %$self }, @arguments );
        } else {
            die "Method $package::$action not found!";
        }
    }
}

sub AUTOLOAD {
    my $subname = $AUTOLOAD;
    $subname =~ s/.*:://;

    return if $subname eq uc $subname;

    my $self = shift;

    return $self->{$subname};
}

sub get_caller_args {
    package DB;
    (undef) = caller($_[0] + 1);
    return @DB::args;
}

1;
