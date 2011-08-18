package Lorem::Role::HasBorders;

use Moose::Role;
use MooseX::Method::Signatures;

use Lorem::Style::Element::Border;

use Lorem::Types qw( LoremStyleElementBorder );

has [qw(border_left border_right border_top border_bottom)] => (
    is => 'rw',
    isa => LoremStyleElementBorder,
    default => sub { Lorem::Style::Element::Border->new },
);

method _imprint_borders ( $cr! ) {
    $self->border_left->imprint ( $cr );
    $self->border_right->imprint ( $cr );
    $self->border_top->imprint ( $cr );
    $self->border_bottom->imprint ( $cr );
}



method _apply_border_style ( $style ) {
    $self->border_left->set_color( $style->border_left_color );
    $self->border_left->set_style( $style->border_left_style );
    $self->border_left->set_width( $style->border_left_width );
    $self->border_right->set_color( $style->border_right_color );
    $self->border_right->set_style( $style->border_right_style );
    $self->border_right->set_width( $style->border_right_width );
    $self->border_top->set_color( $style->border_top_color );
    $self->border_top->set_style( $style->border_top_style );
    $self->border_top->set_width( $style->border_top_width );
    $self->border_bottom->set_color( $style->border_bottom_color );
    $self->border_bottom->set_style( $style->border_bottom_style );
    $self->border_bottom->set_width( $style->border_bottom_width );
}

method _allocate_borders ( $cr!, Num $x!, Num $y!, Num $width!, Num $height! ) {
        
    my $x1 = $x + $self->margin_left;
    my $y1 = $y + $self->margin_top;
    my $x2 = $x + $width - $self->margin_left - $self->margin_right;
    my $y2 = $y1;
    my $x3 = $x2;
    my $y3 = $y1 + $height - $self->margin_top - $self->margin_bottom;
    my $x4 = $x1;
    my $y4 = $y3;
    
    
    $self->border_top->size_allocate ( $cr, $x1, $y1, $x2, $y2 );
    $self->border_right->size_allocate( $cr, $x2, $y2, $x3, $y3 );
    $self->border_bottom->size_allocate( $cr, $x4, $y4, $x3, $y3 );
    $self->border_left->size_allocate( $cr, $x1, $y1, $x4, $y4 );
}


1;
