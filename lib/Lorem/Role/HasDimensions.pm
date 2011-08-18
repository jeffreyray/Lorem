package Lorem::Role::HasDimensions;

use Moose::Role;
use MooseX::Method::Signatures;

use Lorem::Util qw(percent_of);
use Lorem::Types qw(LoremStyleDimension LoremStyleLength LoremStyleRelativeLength);

has [qw(width height)] => (
    is => 'rw',
    isa => 'Maybe[Num]',
    default => undef,
);

has [qw(min_width min_height)] => (
    is => 'rw',
    isa => 'Maybe[Num]',
    default => undef,
);

has [qw(max_width max_height)] => (
    is => 'rw',
    isa => 'Maybe[Num]',
    default => undef,
);

method _apply_dimension_style ( $style ) {
    
    my ( $w, $h );
    
    #    if ( $style->width ) {
    #    if ( is_LoremStyleRelativeLength( $style->width ) ) {
    #        $self->set_width( percent_of $style->width, $self->parent->inner_width ) if $self->parent->inner_width;
    #    }
    #    else {
    #        $self->set_width( $style->width );
    #    }
    #}
    #
    #if ( $style->height ) {
    #    if ( is_LoremStyleRelativeLength( $style->height ) ) {
    #        $self->set_height( percent_of $style->height, $self->parent->inner_height ) if $self->parent->inner_height;
    #    }
    #    else {
    #        $self->set_height( $style->height );
    #    }
    #}
    
    if ( $style->width ) {
        is_LoremStyleRelativeLength( $style->width ) ?
        $self->set_width( percent_of $style->width, $self->parent->inner_width ) :
        $self->set_width( $style->width );
    }

    if ( $style->height ) {
        is_LoremStyleRelativeLength( $style->height ) ?
        $self->set_height( percent_of $style->height, $self->parent->inner_height ) :
        $self->set_height( $style->height );
    }

    if ( $style->min_width ) {
        is_LoremStyleRelativeLength( $style->min_width ) ?
        $self->set_min_width( percent_of $style->min_width, $self->parent->inner_width ):
        $self->set_min_width( $style->min_width );
    }    
    if ( $style->min_height ) {
        is_LoremStyleRelativeLength( $style->min_height ) ?
        $self->set_min_height( percent_of $style->min_height, $self->parent->inner_height ):
        $self->set_min_height( $style->min_height );
    }

    if ( $style->max_width ) {
        is_LoremStyleRelativeLength( $style->max_width ) ?
        $self->set_max_width( percent_of $style->max_width, $self->parent->inner_width ):
        $self->set_max_width( $style->max_width );
    }    
    if ( $style->max_height ) {
        is_LoremStyleRelativeLength( $style->max_height ) ?
        $self->set_max_height( percent_of $style->max_height, $self->parent->inner_height ):
        $self->set_max_height( $style->max_height );
    }
}

1;
