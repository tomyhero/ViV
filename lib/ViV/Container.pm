package ViV::Container;
use warnings;
use strict;
use Object::Container '-base';
use ViV::Model;
use Data::Model::Driver::DBI;
use ViV::I18N;

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

register i18n => sub {
    my $i18n = ViV::I18N->new();
    $i18n->load();
    return $i18n;
};

1;
