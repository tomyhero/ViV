package ViV::Web::Controller::Member;
use Polocky::Class;
use ViV::Container 'con';
use ViV::Constants qw(:common);

BEGIN { extends 'Polocky::WAF::CatalystLike::Controller' };

sub index : Path : Args(0) {
    my ( $self, $c ) = @_;
    my @member_objs = con('model')->get( member => { } );
    $c->stash->{member_objs} = \@member_objs;
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
        required => [qw/member_name password screen_name on_admin/],
        defaults => {
            on_admin => TRUE ,
        }
    });

    my $v = $form->valid;
    if( $v->{password} ) {
        if ( $v->{password} ne $c->req->param('password_confirm') ){
            $form->custom_invalid( 'password_confirm' , 'password confirm fail');
        }
    }
    return if $form->has_error;
    con('model')->set( member => $v );
    $c->redirect('/member/');

}

__POLOCKY__;
