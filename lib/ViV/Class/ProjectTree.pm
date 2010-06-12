package ViV::Class::ProjectTree;
use Polocky::Class;
use JSON::Syck;

has tree => ( is => 'rw' );
has data => ( is => 'rw' );

sub get_json {
    my $self = shift;
    my @data = ();
    $self->mkjson( $self->tree , \@data );
    local $JSON::Syck::ImplicitUnicode = 1;
    my $json = JSON::Syck::Dump(\@data);
    return $json;
}

sub mkjson {
    my $self = shift;
    my $tree = shift;
    my $data = shift;
    foreach my $id ( keys %$tree ) {
        my $item = {
            type => 'text',
            label => $self->data->{$id}->vision_name,
        };

        my $project_id = $self->data->{$id}->project_id;
        if( $tree->{$id} ){
            $item->{expanded} = 'true',
            $item->{children} = [];
        }
        push @$data , $item;
        $self->mkjson( $tree->{$id} ,$item->{children} );
        push @{$item->{children}} , {
            type => "text",
            href =>  "/project/$project_id/vision/add/?parent_vision_id=$id",
            label => 'new vision',
        };
    }
    1;
}

__POLOCKY__;

=head1 NAME

ViV::Class::ProjectTree - Project Tree Class.

=head1 SYNOPSIS

 my $tree =ViV::Class::ProjectTree->new( tree => $tree, data = $data );
 my $json = $tree->get_json;

=cut
