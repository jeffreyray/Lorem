package Lorem::Element::TableRow;

use Moose;
use MooseX::SemiAffordanceAccessor;
use MooseX::StrictConstructor;
use MooseX::Method::Signatures;

use Cairo;
use Pango;

use Lorem::Types qw(  );
use Lorem::Element::TableCell;
extends 'Lorem::Element::Box';

with 'Lorem::Role::ConstructsElement' => {
    name  => 'cell',
    class => 'Lorem::Element::TableCell',
};

after apply_style => sub {
    my $self = shift;
    $self->set_width( $self->parent->width ) if $self->parent->width;
};

#method size_request (  $cr! )  {
#        
#    $self->apply_style( $self->merged_style );
#    
#    my $child_req = $self->child_size_request( $cr );
#    
#    my ( $w, $h ) = ( $child_req->{width}, $child_req->{height} );
#    
#    $w = $self->parent->width if $self->parent->width;
#    
#    return { width => $w, height => $h };
#}

method child_size_request ( $cr! ) {
    my ( $w, $h ) = ( 0, 0 );
    
    for my $cell ( @{ $self->children } ) {
        my $size = $cell->size_request( $cr );
        $w += $cell->width ? $cell->width : $size->{width};
        $h = $size->{height} if $size->{height} > $h;
    }
    
    return { width => $w, height => $h };
}

#method size_allocate ( $cr!, Num $x!, Num $y!, Num $width!, Num $height!) {
#
#    my %allocation = (width => $width, height => $height, x => $x, y => $y);
#    $self->set_size_allocation( \%allocation );
#    
#    $self->_allocate_borders( $cr, $x, $y, $width, $height );
#    
#    for my $cell ( @{ $self->children } ) {
#        my $csize = $cell->size_request( $cr );
#        $cell->size_allocate( $cr, $x, $y, $csize->{width}, $height );
#        $x += $csize->{width};
#    }
#    
#    
#}

method child_size_allocate ( $cr, Num $x, Num $y, Num $width, Num $height ) {
    for my $cell ( @{ $self->children } ) {
        my $csize = $cell->size_request( $cr );
        $cell->size_allocate( $cr, $x, $y, $csize->{width}, $height );
        $x += $csize->{width};
    }
}

1;

