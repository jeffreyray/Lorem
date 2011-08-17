package Lorem::Element;

use Moose;
use MooseX::SemiAffordanceAccessor;
use MooseX::StrictConstructor;
use MooseX::Method::Signatures;

use Scalar::Util qw( refaddr );

use Lorem::Types qw( GiDocDocumentObject );

with 'Lorem::Role::HasSizeAllocation';
with 'Lorem::Role::HasStyle';

has 'doc' => (
    is => 'rw',
    isa => 'Maybe[Lorem::Document]',
    weak_ref => 1,
    trigger => sub {
        my $self = shift;
        $self->_on_set_doc( @_ );
    }
);

has 'parent' => (
    is => 'rw',
    isa => GiDocDocumentObject,
    trigger => sub {
        my $self = shift;
        $self->set_doc( $_[0] ? $_[0]->doc : undef );
        $self->_on_set_parent( @_ );
    },
    weak_ref => 1,
    required => 0,
);

has 'children' => (
    is  => 'ro',
    isa => 'ArrayRef',
    traits => [qw/Array/],
    default => sub { [ ] },
    handles => {
        'get_child'  => 'get',
        'delete_child' => 'delete',
        '_add_child' => 'push',
        'pop_child' => 'pop',
    }
);

method append_element ( Lorem::Element $element ) {
    $element->set_parent( $self );
    $self->_add_child( $element );
    return $element;
}

sub _on_set_parent {
    
}

sub _on_set_doc {
    
}


1;
