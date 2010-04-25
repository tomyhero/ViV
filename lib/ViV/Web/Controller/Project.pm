package ViV::Web::Controller::Project;
use Polocky::Class;
use ViV::Container 'con';
use ViV::Constants qw(:common);

BEGIN { extends 'Polocky::WAF::CatalystLike::Controller' };

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

__POLOCKY__;
