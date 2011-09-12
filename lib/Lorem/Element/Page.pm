package Lorem::Element::Page;

use Moose;
use MooseX::SemiAffordanceAccessor;
use MooseX::StrictConstructor;


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

sub imprint {
    my ( $self, $cr ) = @_;
    
    die 'you did not supply a context, usage: $page->imprint( $cr )' if ! $cr;
    
    
    $self->size_request( $cr );
    $self->size_allocate( $cr, 0, 0, $self->parent->width, $self->parent->height );
    $self->_imprint_borders ( $cr );
    
    $self->header->size_allocate( $cr, 0, 0, $self->parent->width, $self->parent->height );
    $self->header->imprint( $cr ) if $self->header;
    
    $_->imprint( $cr ) for ( @{ $self->children } );
    
}




1;
