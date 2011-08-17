package Lorem::Element::Spacer;

use Moose;
use MooseX::SemiAffordanceAccessor;
use MooseX::StrictConstructor;
use MooseX::Method::Signatures;

use Cairo;
use Pango;


extends 'Lorem::Element::Box';

method imprint (  $cr! )  {
    my $allocated = $self->size_allocation;
    
    die 'you must call size_allocate on this element before imprinting it'
        if ! $allocated;
    
    for my $c ( @{$self->children} ) {
        $c->imprint( $cr );
    }
}

method size_request (  $cr! )  {
    return { width => 1, height => $self->height };
}

method size_allocate ( $cr!, Num $x!, Num $y!, Num $width!, Num $height!) {
    my %allocation = (width => $width, height => $height, x => $x, y => $y);
    $self->set_size_allocation( \%allocation );
}



1;
