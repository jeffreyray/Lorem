package Lorem::Role::HasCoordinates;
use Moose::Role;

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
