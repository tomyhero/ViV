package ViV::Web::Controller::Auth;
use Polocky::Class;
use ViV::Container 'con';
use ViV::Utils;

BEGIN { extends 'Polocky::WAF::CatalystLike::Controller' };


sub login : Local {
    my ( $self, $c ) = @_;

    if( $c->req->method eq 'POST' ) {
        $c->forward( 'do_login' );
    }
}

sub do_login : Private {
    my ( $self , $c ) = @_;
    my $form = $c->form({
        required => [qw/login_name password/],
    });
    return if $form->has_error ;
    my $v = $form->valid;
    
    my $it = con('model')->get(
        member => {
            where => [
                login_name => $v->{login_name},
                password => ViV::Utils::encript_password( $v->{password} )
            ],
        }
    );
    my $member = $it->next;

    unless ( $member ) {
        return $form->custom_invalid('login_fail','Fail to login');
    }
    $c->login( $member );

    $c->redirect('/');

}


__POLOCKY__;
