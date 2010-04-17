package ViV::Utils;
use warnings;
use strict;
use Digest::MD5;

sub encript_password {
    my $raw = shift;
    return Digest::MD5::md5_base64( $raw );
}



1;
