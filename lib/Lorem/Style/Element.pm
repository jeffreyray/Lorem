package Lorem::Style::Element;

use Moose;
use MooseX::SemiAffordanceAccessor;
use MooseX::StrictConstructor;
use MooseX::Method::Signatures;

use Scalar::Util qw( refaddr );

use Lorem::Types qw( GiDocDocumentObject );

with 'Lorem::Role::HasSizeAllocation';

has 'doc' => (
    is => 'rw',
    isa => 'Maybe[Lorem]',
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

sub _on_set_parent {
    
}

sub _on_set_doc {
    
}


1;
