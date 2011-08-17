package Lorem::Element::Table;

use Moose;
use MooseX::SemiAffordanceAccessor;
use MooseX::StrictConstructor;
use MooseX::Method::Signatures;

use Cairo;
use Pango;

use Lorem::Types qw(  );
use Lorem::Element::TableRow;
extends 'Lorem::Element::Box';

with 'Lorem::Role::ConstructsElement' => {
    name => 'row',
    class => 'Lorem::Element::TableRow'
};

method append_row ( Lorem::Element::TableRow :$row? ) {
    $row ||= Lorem::Element::TableRow->new;
    $self->append_element( $row );
    return $row;
}




1;



#with 'Lorem::Role::Stamp';

#has 'macro' => (
#    is => 'rw',
#    isa => 'Maybe[CodeRef]',
#    default => sub { },
#);
#
#sub imprint {
#    my ($self, $doc) = @_;    
#    &{$self->macro}(@_);
#}


1;
