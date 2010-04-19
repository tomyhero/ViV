package ViV::Container;
use warnings;
use strict;
use Object::Container '-base';
use ViV::Model;
use Data::Model::Driver::DBI;

register model => sub { 
    my $model = ViV::Model->new();
    my $driver = Data::Model::Driver::DBI->new(
            dsn => 'dbi:mysql:dbname=viv',
            username => 'root',
            'connect_options' => {
                'mysql_enable_utf8' => '1'
            }
            );
    $model->set_base_driver($driver);

    $model;
};

register 'hoge' => sub { 'hoge' };
1;
