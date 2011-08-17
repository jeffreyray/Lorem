package Lorem::Surface::Pdf;

use Moose;
use MooseX::SemiAffordanceAccessor;
use MooseX::StrictConstructor;
use MooseX::Method::Signatures;
extends 'Lorem::Surface';

use Gtk2;

has 'width' => (
    is => 'rw',
    isa => 'Num',
    required => 1,
);

has 'height' => (
    is => 'rw',
    isa => 'Num',
    required => 1,
);

has 'file_name' => (
    is => 'rw',
    isa => 'Str',
);


method print ( $doc ) {
    my $surface = Cairo::PdfSurface->create ( $self->file_name, $self->width, $self->height );
    $doc->set_width( $self->width );
    $doc->set_height( $self->height );
    my $cr = Cairo::Context->create( $surface );

    #&{$doc->builder_func}( $doc, $cr );
    
    my @pages = @{$doc->children};

    for ( @pages ) {
        $_->imprint( $cr );
        $cr->show_page;
    }
}


1;
