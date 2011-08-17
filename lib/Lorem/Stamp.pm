package Lorem::Stamp;

use Moose;
use MooseX::SemiAffordanceAccessor;
use MooseX::StrictConstructor;
use MooseX::Method::Signatures;

use Cairo;
use Pango;

with 'Lorem::Role::Stamp';

has 'macro' => (
    is => 'rw',
    isa => 'Maybe[CodeRef]',
    default => sub { },
);

sub imprint {
    my ($self, $doc) = @_;    
    &{$self->macro}(@_);
}


1;
