package ViV::I18N;
use Polocky::Class;
use Polocky::Utils;

has data => ( is => 'rw');
has default_lang => (
    is => 'rw',
    default => 'ja',
);

sub load {
    my $self = shift;
    my $structure = Polocky::Utils::structure;
    my $dir = $structure->path_to('resource','i18n');
    my $handle = $dir->open;
    my $data = {};
    while (my $file = $handle->read) {
        $file = $dir->file($file);  # Turn into Path::Class::File object
        next unless $file->stringify =~ /pl$/;
        my ($lang) = $file->basename  =~ /([a-z]+)/;
        $data->{$lang} = $self->load_data( $file );
    }
    $self->data( $data );

    1;
}

sub load_data {
    my $self = shift;
    my $file = shift;
    my $data = do($file->stringify );

    $data;
}

sub get {
    my $self = shift;
    my $key = shift;
    my $lang = shift || $self->default_lang;
    my $data =  $self->data->{$lang};
    for(split(/\./,$key) ){
        $data = $data->{$_};
    }
    return $data;
}

__POLOCKY__;
