package ViV::Web::View::TT;
use Polocky::Class;
extends 'Polocky::WAF::View::TT';
use Template::Filters::LazyLoader;
use ViV::Constants;

sub _build_filters {
    my $self = shift;
    my $lazy_loader = Template::Filters::LazyLoader->new();
    $lazy_loader->pkg('ViV::TTFilter');
    $lazy_loader->load();
}
sub fix_config { 
    my $self = shift;
    my $config = shift;
    $config->{CONSTANTS}  = ViV::Constants->as_hashref();
    $config->{PRE_CHOMP}  = 1;
    $config->{POST_CHOMP} = 1;
}


__POLOCKY__;
