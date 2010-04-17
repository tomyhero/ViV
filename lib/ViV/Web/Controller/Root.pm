package ViV::Web::Controller::Root;
use Polocky::Class;
BEGIN { extends 'Polocky::WAF::CatalystLike::Controller' };
__PACKAGE__->namespace('');

sub auto : Private {
    my ( $self, $c ) = @_;

    # do nothing for auth controller
    return 1 if $c->req->path_info =~ /^\/auth\//;

    # if the viewr is not member then go to login page
    unless ( $c->is_login_member() ) {
        $c->res->redirect('/auth/login/');     
        return ;
    }

    1;
}

sub index : Path : Args(0) {
    my ( $self, $c ) = @_;
}

sub end  :ActionClass('RenderView') {}

__POLOCKY__;
