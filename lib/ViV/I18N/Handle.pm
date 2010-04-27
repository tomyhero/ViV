package ViV::I18N::Handle;
use Polocky::Class;

has lang => ( is => 'rw' );
has data => ( is => 'rw' );

sub get {
    my $self = shift;
    my $key  = shift;
    my $data =  $self->data->{$self->lang};
    for(split(/\./,$key) ){
        $data = $data->{$_};
    }
    return $data;
}
__POLOCKY__;
