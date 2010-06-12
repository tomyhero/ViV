package ViV::Web::Controller::Project;
use Polocky::Class;
use ViV::Container 'con';
use ViV::Constants qw(:common);

BEGIN { extends 'Polocky::WAF::CatalystLike::Controller' };


sub endpoint :Chained('/') :PathPart('project') :CaptureArgs(1) {
    my ($self, $c, $id ) = @_;
    my $project_obj = con('model')->lookup( project => $id ) => or return $c->redirect('/');
    $c->stash->{project_obj} = $project_obj;
    return 1;
}

sub index : Path : Args(0) {
    my ( $self, $c ) = @_;
    my @project_objs = con('model')->get( project => { } );
    $c->stash->{project_objs} = \@project_objs;
}

sub add : Local {
    my ( $self, $c ) = @_;
    if( $c->req->method eq 'POST' ){
        $c->detach('do_add');
    }
}

sub do_add : Private {
    my ( $self, $c ) = @_;

    my $form = $c->form({
        required => [qw/project_name/],
    });

    my $v = $form->valid;
    return if $form->has_error;

    my %data = ( %$v, created_by => $c->member->member_id );
    con('model')->set( project => \%data );
    $c->redirect('/project/');

}

sub view : Chained('endpoint')  {
    my ( $self, $c ) = @_;
    my $project_obj = $c->stash->{project_obj};
    my $tree = $project_obj->tree;

    use Data::Dumper;
    warn Dumper $tree;

}

__POLOCKY__;
