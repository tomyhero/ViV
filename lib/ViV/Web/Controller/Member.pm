package ViV::Web::Controller::Member;
use Polocky::Class;
use ViV::Container 'con';
use ViV::Constants qw(:common);


# member is login user. member_obj is target member.

BEGIN { extends 'Polocky::WAF::CatalystLike::Controller' };

sub endpoint :Chained('/') :PathPart('member') :CaptureArgs(1) {
    my ($self, $c, $member_id ) = @_;
    my $member_obj = con('model')->lookup( member => $member_id ) or return $c->redirect('/');
    $c->stash->{member_obj} = $member_obj;
    1;
}

sub edit : Chained('endpoint')  {
    my ($self, $c ) = @_;
    my $member_obj = $c->stash->{member_obj};
    $c->set_fillform( $member_obj->get_columns );
}

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
        required => [qw/login_name password screen_name on_admin/],
        defaults => {
            on_admin => TRUE ,
        },
        level => {
            login_name => 'update',
        },
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
