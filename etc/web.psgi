use warnings;
use strict;
use FindBin;
use Path::Class;
use lib Path::Class::Dir->new($FindBin::Bin, '..', 'lib')->stringify;
use ViV::Web;
my $app = ViV::Web->new;
my $handler = $app->psgi_handler ;
