#!/usr/bin/perl

use warnings;
use strict;
use FindBin;
use Path::Class;
use lib Path::Class::Dir->new($FindBin::Bin, '../..', 'lib')->stringify;
use Data::Dumper;
use ViV::Container 'con';
my $project_obj = con('model')->lookup(project => 1);

my $tree = $project_obj->tree;


warn Dumper $tree->get_json;




