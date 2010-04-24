package ViV::Script::createdb;
use Polocky::Class;
use ViV::Model;
use Data::Model::Driver::DBI;
use ViV::Utils;
      
extends 'Polocky::Script::Base';

sub execute {
    my $self = shift ;
    my $model= ViV::Model->new();

    my $driver = Data::Model::Driver::DBI->new(
            dsn => 'dbi:mysql:dbname=viv',
            username => 'root'
            );
    $model->set_base_driver($driver);

    for my $target ($model->schema_names) {
        my $dbh = $model->get_driver($target)->rw_handle;
        for my $sql ($model->as_sqls($target)) {
                $dbh->do( "DROP TABLE $target" );
                $dbh->do($sql);
        }
    }

    my $row 
        = $model->set(
            member => {
                login_name => 'admin',
                screen_name => '管理者',
                on_admin => 1,
                password => ViV::Utils::encript_password('helpme'),
            }
        );


}

1;
