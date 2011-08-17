package Lorem::Style::Element::Border;

use Moose;
use MooseX::SemiAffordanceAccessor;
use MooseX::StrictConstructor;
use MooseX::Method::Signatures;

use Cairo;
use Pango;

with 'Lorem::Role::HasSizeAllocation';

use Lorem::Constants qw( %GiDocStyleBorderWidth );
use Lorem::Types qw( GiDocStyleBorderWidth GiDocStyleBorderStyle GiDocStyleColor );

has 'parent' => (
    is => 'rw',
);

has 'width' => (
    is => 'rw',
    isa =>  GiDocStyleBorderWidth,
);

has 'style' => (
    is => 'rw',
    isa => GiDocStyleBorderStyle,
);

has 'color' => (
    is => 'rw',
    isa => GiDocStyleColor,
);

method imprint ( $cr! ) {
    my $coords = $self->size_allocation;
   
    if ( $self->style ne 'none' ) {
        $cr->set_line_width( $self->_cairo_width );
        $cr->move_to( 0, 0 );
        $cr->move_to( $coords->{x1}, $coords->{y1} );
        $cr->line_to( $coords->{x2} , $coords->{y2} );
        $cr->stroke;
    }
}

method size_allocate ( $cr!, Num $x1!, Num $y1!, Num $x2!, Num $y2!) {
    my %allocation = ( x1 => $x1, y1 => $y1, x2 => $x2, y2 => $y2 );
    $self->set_size_allocation( \%allocation );
}

method _cairo_width ( ) {
    return $GiDocStyleBorderWidth{ $self->width };
}



#method imprint (  $cr! )  {
#    my $allocated = $self->size_allocation;
#    
#    die 'you must call size_allocate on this element before imprinting it'
#        if ! $allocated;
#    
#    $cr->set_line_width( $allocated->{height} );
#    $cr->move_to( $allocated->{x}, $allocated->{y} );
#    $cr->line_to( $allocated->{x} + $allocated->{width}, $allocated->{y} );
#    $cr->stroke;
#}
#
#method size_request (  $cr! )  {
#    my $w  = defined $self->width  ? $self->width  : 100 ;
#    my $h  = defined $self->height ? $self->height : 1 ;
#    return { width => $w, height => $h };
#}
#
#method size_allocate ( $cr!, Num $x!, Num $y!, Num $width!, Num $height!) {
#    my %allocation = (width => $width, height => $height, x => $x, y => $y);
#    $self->set_size_allocation( \%allocation );
#}


1;
