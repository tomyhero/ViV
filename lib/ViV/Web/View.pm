package ViV::Web::View;
use Polocky::Class;
use ViV::Container 'con';
extends qw(Polocky::WAF::View);


sub _build_stash {
    my ( $self, $c, $type ) = @_;
    $c->stash->{c} = $c;
    $c->stash->{config} = $c->config;
    $c->stash->{i18n} = con('i18n')->get_handle;
}
__POLOCKY__;
