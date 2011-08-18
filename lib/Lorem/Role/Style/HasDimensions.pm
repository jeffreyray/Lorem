package Lorem::Role::Style::HasDimensions;

use Moose::Role;
use MooseX::Method::Signatures;

use Lorem::Types qw( LoremStyleDimension );

has [qw(width height)] => (
    is => 'rw',
    isa => LoremStyleDimension,
);

has [qw(min_width min_height)] => (
    is => 'rw',
    isa => LoremStyleDimension,
);

has [qw(max_width max_height)] => (
    is => 'rw',
    isa => LoremStyleDimension,
);



1;
