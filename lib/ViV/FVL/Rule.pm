package ViV::FVL::Rule;
use warnings;
use strict;
use ViV::Container 'con';

sub unique_id {
    my $value = shift;
    my $args  = shift;
    die 'you must set table argument' unless exists $args->{table};
    die 'you must set field argument' unless exists $args->{field};
    my ($obj) = con('model')->get( $args->{table} => { index => { $args->{field} => $value } } );
    return $obj ? 0 : 1;
}

sub valid_id {
    my $value = shift;
    my $args  = shift;
    die 'you must set table argument' unless exists $args->{table};
    my ($obj) = con('model')->lookup( $args->{table} => $value );
    return $obj ? 1 : 0;
}



1;
