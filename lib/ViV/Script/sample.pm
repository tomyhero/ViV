package ViV::Script::sample;
use Polocky::Class;
extends 'Polocky::Script::Base';

has 'name' =>(
    is => 'rw',
    default => 'polocky',
    isa => 'Str',
);

sub execute {
    my $self = shift ;
    print "Hi," . $self->name ."!\n";
}

__POLOCKY__;
