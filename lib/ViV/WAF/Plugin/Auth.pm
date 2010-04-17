package ViV::WAF::Plugin::Auth;
use Polocky::Role;
use ViV::Container 'con';

has '__auth_session_key' => ( is => 'rw' , default => 'viv_auth' );

sub login {
    my $c = shift;
    my $obj = shift;

    my $data = { 
        id => $obj->member_id,
        is_logging => 1,
    };

    $c->session->{ $c->__auth_session_key }  = $data ; 
}

sub is_login_member {
    my $c = shift;
    my $data = $c->session->{$c->__auth_session_key}; 
    return unless $data;
    return unless $c->member;
    return $data->{is_logging};
}

sub member {
    my $c = shift;

    if ( $c->stash->{member} ) {
        return $c->stash->{member};
    }

    my $data = $c->session->{ $c->__auth_session_key };
    if ($data) {
        my $member = con('model')->lookup( member => $data->{id} ); 
        return unless $member;
        $c->stash->{member} = $member;
        return $member;
    }
    return ;
}

sub logout {
    my $c = shift;
    delete $c->session->{$c->__auth_session_key };
}

1;

