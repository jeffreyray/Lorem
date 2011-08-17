package Lorem::Role::HasHeaderFooter;
use Moose::Role;

use Lorem::Types qw( MaybeGiDocDoesStamp );

has 'header' => (
    is => 'rw',
    isa => 'Maybe[Lorem::Element::Box]',
    default => undef,
);

has 'header_margin' => (
    is => 'rw',
    isa => 'Num',
    default => 0,
);

has 'footer' => (
    is => 'rw',
    isa => 'Maybe[Lorem::Element::Box]',
    default => undef,
);

has 'footer_margin' => (
    is => 'rw',
    isa => 'Num',
    default => 0,
);



1;
