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
    add_method 'id'
        => sub {
            my $row = shift;
            $row->member_id;
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

    column 'created_by'
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

    add_method 'created_by_obj'
        => sub {
            my $row = shift;
            $row->get_model->lookup( member => $row->created_by );
      };

    add_method 'id'
        => sub {
            my $row = shift;
            $row->project_id;
        };

    add_method 'tree'
        => sub {
            my $row = shift;
            my @visions = $row->get_model->get( vision => { where => [ project_id => $row->project_id ] } );
            my $a = {};
            my $b = {};
            for(@visions){
                $a->{$_->parent_vision_id} = [] unless $a->{$_->parent_vision_id};
                push @{$a->{$_->parent_vision_id}} , $_;
                $b->{$_->vision_id} = $_;
            }
            my $tree = {};
            &mktree(0,$a,$tree);
            return ($tree, $b);
      };
};

sub mktree {
    my $parent_vision_id = shift;
    my $a    = shift;
    my $tree = shift;
    if( my $s = $a->{$parent_vision_id}  ) {
        for( @$s ){
            my $t = $tree->{$_->vision_id}  = {};
            mktree( $_->vision_id, $a , $t );
        }
    }
}

install_model vision => schema {
    key 'vision_id';
    column 'vision_id'
      => 'int' => {
          required => 1,
          unsigned => 1,
          auto_increment => 1,
      };
    column 'project_id'
      => 'int' => {
          required => 1,
          unsigned => 1,
      };
    column 'parent_vision_id'
      => 'int' => {
          required => 1,
          unsigned => 1,
      };

    column 'vision_name'
      => 'varchar' => {
          required => 1,
          size     => 255,
      };

    column 'description'
      => 'text' => {
          required => 1,
      };

    column 'created_at'
      => 'datetime' => {
          required => 1,
      };
    column 'updated_at'
      => 'timestamp' => {
          required => 1,
      };
    column 'created_by'
      => 'int' => {
          required => 1,
          size     => 255,
      };
};

1;
