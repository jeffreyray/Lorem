package Lorem::Role::HasMargin;

use Moose::Role;
use MooseX::Method::Signatures;


use Lorem::Types qw( GiDocStyleLength );

has [qw(margin_left margin_right margin_top margin_bottom)] => (
    is => 'rw',
    isa => GiDocStyleLength,
    default => 0,
);

method _apply_margin_style ( $style ) {
    $self->set_margin_left( $style->margin_left );
    $self->set_margin_right( $style->margin_right );
    $self->set_margin_top( $style->margin_top );
    $self->set_margin_bottom( $style->margin_bottom );
}

1;
