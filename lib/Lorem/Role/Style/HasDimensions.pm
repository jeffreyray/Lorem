package Lorem::Role::Style::HasDimensions;

use Moose::Role;

use Lorem::Types qw( LoremStyleDimension );
use MooseX::Types::Moose qw( Undef );

has [qw(width height)] => (
    is => 'rw',
    isa => LoremStyleDimension|Undef,
);

has [qw(min_width min_height)] => (
    is => 'rw',
    isa => LoremStyleDimension|Undef,
);

has [qw(max_width max_height)] => (
    is => 'rw',
    isa => LoremStyleDimension|Undef,
);



1;
