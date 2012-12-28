package Lorem::Render::HTML;

use Moose;
use MooseX::SemiAffordanceAccessor;
use MooseX::StrictConstructor;

use XML::LibXML;



has 'dom' => (
    is => 'rw',
    isa => 'Object',
);


sub render {
    my ( $self, $surface ) = @_;
}



1;
