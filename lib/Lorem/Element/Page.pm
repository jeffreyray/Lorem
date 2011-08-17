package Lorem::Element::Page;

use Moose;
use MooseX::SemiAffordanceAccessor;
use MooseX::StrictConstructor;
use MooseX::Method::Signatures;


use Cairo;
use Pango;

use Lorem::Types qw(  );
use Lorem::Element::TableRow;
extends 'Lorem::Element::Box';
with 'Lorem::Role::HasHeaderFooter';
with 'Lorem::Role::ConstructsElement' => { class => 'Lorem::Element::Div'  };
with 'Lorem::Role::ConstructsElement' => { class => 'Lorem::Element::Spacer'  };
with 'Lorem::Role::ConstructsElement' => { class => 'Lorem::Element::Text'  };
with 'Lorem::Role::ConstructsElement' => { class => 'Lorem::Element::Table' };
with 'Lorem::Role::ConstructsElement' => {
    name  => 'hr',
    class => 'Lorem::Element::HRule',
};

method imprint ( $cr! )  {
    $self->size_request( $cr );
    $self->size_allocate( $cr, 0, 0, $self->parent->width, $self->parent->height );
    
    #$self->header->size_allocate( $cr, 0, 0, $self->parent->width, $self->parent->width );
    #$self->header->imprint( $cr ) if $self->header;
    $_->imprint( $cr ) for ( @{ $self->children } );
}

#method size_allocate ( $cr!, Num $x!, Num $y!, Num $width!, Num $height!) {
#
#    my %allocation = (width => $width, height => $height, x => $x, y => $y);
#    $self->set_size_allocation( \%allocation );
#    
#    my $xe = $x + $self->margin_left; 
#    my $ye = $y + $self->margin_top;
#    
#    for my $e ( @{$self->children }) {
#        my $rsize = $e->size_request( $cr );
#        $e->size_allocate( $cr, $xe, $ye, $rsize->{width}, $rsize->{height} );
#        $ye += $rsize->{height};
#    }
#    
#    if ( $self->header ) {
#        my $x = $x + $self->margin_left;
#        my $y = $y + $self->header_margin;
#        $self->header->size_allocate( $cr, $x, $y, $width, $height);
#    }
#    
#}



1;
