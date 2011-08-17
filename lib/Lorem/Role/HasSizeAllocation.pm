package Lorem::Role::HasSizeAllocation;
use Moose::Role;

has 'size_allocation' => (
    is => 'rw',
    isa => 'Maybe[HashRef]',
    default => undef,
    writer => 'set_size_allocation',
);



1;
