package ViV::Web::Controller::Project::Vision;
use Polocky::Class;
use ViV::Container 'con';
use ViV::Constants qw(:common);
BEGIN { extends 'Polocky::WAF::CatalystLike::Controller' };

sub endpoint :Chained('/project/endpoint') :PathPart('vision') :CaptureArgs(1) {
    my ($self, $c, $id ) = @_;
    my $vision_obj = con('model')->lookup( vision => $id ) => or return $c->redirect('/');
    $c->stash->{vision_obj} = $vision_obj;
    return 1;
}

sub add :Chained('/project/endpoint') :PathPart('vision') {
    my ($self, $c ) = @_;

    if( $c->req->method eq 'POST' ) {
        $c->forward('do_add');
    }
}

sub do_add : Private {
    my ($self, $c ) = @_;
    my $project_obj = $c->stash->{project_obj} ;

    my $form = $c->form({
        required => [qw/vision_name description/],
    });

    my $v = $form->valid;
    return if $form->has_error;
    my %data = ( %$v, created_by => $c->member->member_id , project_id => $project_obj->id );
    con('model')->set( vision => \%data );
    $c->redirect('/project/' . $project_obj->id . '/' );

}

__POLOCKY__;
