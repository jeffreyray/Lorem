package Lorem::Render::Ipsum;

use Moose;
use MooseX::LazyRequire;
use MooseX::SemiAffordanceAccessor;
use MooseX::StrictConstructor;

use XML::LibXML;

use Lorem::Util qw( in2pt );
use MooseX::Types::Moose qw( Object Str );

has 'context' => (
    is => 'rw',
    isa => 'Object',
    weak_ref => 1,
);

has 'doc' => (
    is => 'rw',
    isa => 'Object',
);

has 'dom' => (
    is => 'rw',
    isa => 'Object',
    lazy_required => 1,
);

has 'paginate' => (
    is => 'rw',
    isa => 'Bool',
    default => 1,
);

sub render {
    my ( $self, $surface ) = @_;
    
    my $dom = $self->dom;
    
    my $root = $dom->documentElement;
    
    my $body = ($root->getChildrenByTagName( 'body' ))[0];
    
    my $document = Lorem::Document->new;
    $self->set_doc( $document );
    
    $document->build( sub {
        my ( $doc, $context ) = @_;
        
        $self->set_context( $context );
        
        for my $node ( $body->childNodes ) {
            
            $self->render_element( $doc, $node );
            
            $self->render_element( $doc, $node->textContent );
        }
        
    } );
    
    # print it
    my $s = Lorem::Surface::Pdf->new( file_name => 'sudoku2.pdf', width => in2pt(8.5), height => in2pt(11) );
    $s->print( $document );
}

sub render_element {
    my ( $self, $parent, $node ) = @_;
    
    my $e;
    
    if ( is_Str ( $node ) ) {
        $parent->new_text( content => $node );
    }
    elsif ( $node->nodeName eq 'table' ) {
        $e = $parent->new_table( style => 'width: 100%' );
    }
    elsif ( $node->nodeName eq 'tr' ) {
        $e = $parent->new_row( style => 'width: 100%' );
    }
    elsif ( $node->nodeName eq 'td' ) {
        $e = $parent->new_cell( style => 'width: 25%' );
    }
    
    if ( $e ) {
        
        for my $node ( $node->childNodes ) {
            
            $self->render_element( $e, $node );
            
        }
        
    }
    
    # recursion
    
    if ( is_Object ( $node ) ) {
        for my $node ( $node->childNodes ) {
            
            $self->render_element( $e, $node );
            
            $self->render_element( $e, $node->textContent );
            
        }
    }
    

    
    return $e;
}




1;
