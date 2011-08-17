package Lorem::Element::Header;

use Moose;
use MooseX::SemiAffordanceAccessor;
use MooseX::StrictConstructor;
use MooseX::Method::Signatures;

with 'MooseX::Clone';

use Cairo;
use Pango;

use Lorem::Element::Text;
use Lorem::Types qw( GiDocText );


extends 'Lorem::Element::Box';



has 'left' => (
    is => 'rw',
    isa => GiDocText,
    required => 1,
    traits => [qw(Clone)],
);

has 'center' => (
    is => 'rw',
    isa => GiDocText,
    required => 1,
    traits => [qw(Clone)],
);

has 'right' => (
    is => 'rw',
    isa => GiDocText,
    required => 1,
    traits => [qw(Clone)],
);

sub BUILD {
    my $self = shift;
    $_->set_parent( $self ) for $self->left, $self->right, $self->center;
}

sub BUILDARGS {
    my $class = shift;
    
    my %args = @_;
    
    for (qw/left center right/) {
        
        # if position not exist, create it
        if ( ! $args{$_} ) {
            $args{$_} = Lorem::Element::Text->new( content => '' );
        }
        # if position is not a text element, coerce
        elsif ( ! blessed $args{$_} || ! $args{$_}->isa('Lorem::Element::Text') ) {
            $args{$_} = Lorem::Element::Text->new( content => $args{$_} );
        }
        
        $args{$_}->style->set_text_align($_);
    }
    
    return \%args;
}



method size_allocate (  $cr!, Num $x!, Num $y!, Num $width!, Num $height!) {
    my %allocation = (width => $width, height => $height, x => $x, y => $y);
    $self->left->size_allocate( $cr, $x, $y, $width, $height);
    $self->center->size_allocate( $cr, $x, $y, $width, $height);
    $self->right->size_allocate( $cr, $x, $y, $width, $height);
    $self->set_size_allocation( \%allocation );
}


method imprint (  $cr! )  {
    my $parent = $self->parent;
    my ($te, $xpos, $ypos);
    
    $self->left->imprint( $cr );
    $self->center->imprint( $cr );
    $self->right->imprint( $cr );
}


1;
