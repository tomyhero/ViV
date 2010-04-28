package ViV::Utils;
use warnings;
use strict;
use Digest::MD5;

sub encript_password {
    my $raw = shift;
    return Digest::MD5::md5_base64( $raw );
}


sub generate_password {
    my $password;
    my $_rand;
    my $password_length = 8;
    my @chars = qw/a b c d e f g h i j k l m n o
            p q r s t u v w x y z - _ |
            0 1 2 3 4 5 6 7 8 9/;
    srand;
    for (my $i=0; $i <= $password_length ;$i++) {
        $_rand = int(rand (scalar @chars -1 ) );
        $password .= $chars[$_rand];
    }
    return $password;
}


1;
