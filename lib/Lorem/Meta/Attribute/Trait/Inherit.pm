package Lorem::Meta::Attribute::Trait::Inherit;
use Moose::Role;

package Moose::Meta::Attribute::Custom::Trait::Inherit;
sub register_implementation {'Lorem::Meta::Attribute::Trait::Inherit'}

1;
