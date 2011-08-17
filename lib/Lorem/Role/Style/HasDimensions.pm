package Lorem::Role::Style::HasDimensions;

use Moose::Role;
use MooseX::Method::Signatures;

use Lorem::Types qw( GiDocStyleDimension );

has [qw(width height)] => (
    is => 'rw',
    isa => GiDocStyleDimension,
);

has [qw(min_width min_height)] => (
    is => 'rw',
    isa => GiDocStyleDimension,
);

has [qw(max_width max_height)] => (
    is => 'rw',
    isa => GiDocStyleDimension,
);



1;
