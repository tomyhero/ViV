package ViV::Model;
use strict;
use warnings;
use base 'Data::Model';
use Data::Model::Schema sugar => 'viv';

install_model member => schema {
    key 'member_id';
    unique 'login_name';
    column 'member_id'
      => 'int' => {
          required => 1,
          unsigned => 1,
          auto_increment => 1,
      };

    column 'login_name'
      => 'varchar' => {
          required => 1,
          size     => 255,
      };
    column 'password'
      => 'varchar' => {
          required => 1,
          size     => 255,
      };
    column 'screen_name'
      => 'varchar' => {
          required => 1,
          size     => 255,
      };

    column 'on_admin'
      => 'tinyint' => {
          required => 1,
          unsigned => 1,
      };
    column 'created_at'
      => 'datetime' => {
          required => 1,
      };
    column 'updated_at'
      => 'timestamp' => {
          required => 1,
      };
};

install_model project => schema {
    key 'project_id';
    column 'project_id'
      => 'int' => {
          required => 1,
          unsigned => 1,
          auto_increment => 1,
      };

    column 'project_name'
      => 'varchar' => {
          required => 1,
          size     => 255,
      };

    column 'owner_id'
      => 'int' => {
          required => 1,
          size     => 255,
      };

    column 'created_at'
      => 'datetime' => {
          required => 1,
      };
    column 'updated_at'
      => 'timestamp' => {
          required => 1,
      };

    add_method 'owner_obj'
        => sub {
            my $row = shift;
            $row->get_model->lookup( member => $row->owner_id );
    };
};

1;
