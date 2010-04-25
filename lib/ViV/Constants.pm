package ViV::Constants;

use strict;
use ViV;
use base qw(Exporter);
our @EXPORT_OK = qw(TRUE FALSE);
our %EXPORT_TAGS = (
    common => [qw/TRUE FALSE/],
);

use constant TRUE  => 1;
use constant FALSE => 0;

sub as_hashref {
    no strict 'refs';
    my %data;
    for my $key(@EXPORT_OK) {
    $data{$key} = $key->();
    }
    $data{version} = $ViV::VERSION;
    return \%data;
}


1;
