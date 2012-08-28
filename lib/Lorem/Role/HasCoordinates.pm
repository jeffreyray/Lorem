package Lorem::Role::HasCoordinates;

use Moose::Role;
use MooseX::SemiAffordanceAccessor;

has 'x' => (
    is => 'rw',
    isa => 'Maybe[Num]',
    default => undef,
);

has 'y' => (
    is => 'rw',
    isa => 'Maybe[Num]',
    default => undef,
);



1;
