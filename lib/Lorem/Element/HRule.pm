package Lorem::Element::HRule;

use Moose;
use MooseX::SemiAffordanceAccessor;
use MooseX::StrictConstructor;
use MooseX::Method::Signatures;

use Cairo;
use Pango;

use Lorem::Types qw(  );

extends 'Lorem::Element::Box';


method imprint (  $cr! )  {
    my $allocated = $self->size_allocation;
    
    die 'you must call size_allocate on this element before imprinting it'
        if ! $allocated;
    
    $cr->set_line_width( $allocated->{height} );
    $cr->move_to( $allocated->{x}, $allocated->{y} );
    $cr->line_to( $allocated->{x} + $allocated->{width}, $allocated->{y} );
    $cr->stroke;
}

method size_request (  $cr! )  {
    my $w  = defined $self->width  ? $self->width  : 100 ;
    my $h  = defined $self->height ? $self->height : 1 ;
    return { width => $w, height => $h };
}

method size_allocate ( $cr!, Num $x!, Num $y!, Num $width!, Num $height!) {
    my %allocation = (width => $width, height => $height, x => $x, y => $y);
    $self->set_size_allocation( \%allocation );
}


1;
