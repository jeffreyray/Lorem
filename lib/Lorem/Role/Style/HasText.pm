package Lorem::Role::Style::HasText;

use Moose::Role;
use MooseX::Method::Signatures;

use Lorem::Types qw(GiDocStyleFontFamily GiDocStyleFontStyle GiDocStyleFontSize
GiDocStyleFontWeight GiDocStyleFontVariant GiDocStyleTextAlign GiDocStyleTextAlign
GiDocStyleTextDecoration GiDocStyleTextUnderline);



has 'font_family' => (
    is => 'rw',
    isa => GiDocStyleFontFamily,
    traits  => [qw/Inherit/],
);

has 'font_style' => (
    is => 'rw',
    isa => GiDocStyleFontStyle,
    traits  => [qw/Inherit/],
);

has 'font_size' => (
    is => 'rw',
    isa => GiDocStyleFontSize,
    traits  => [qw/Inherit/],
);

has 'font_weight' => (
    is => 'rw',
    isa => GiDocStyleFontWeight,
    traits  => [qw/Inherit/],
);

has 'font_variant' => (
    is => 'rw',
    isa => GiDocStyleFontVariant,
    traits  => [qw/Inherit/],
);

has 'text_align' => (
    is => 'rw',
    isa => GiDocStyleTextAlign,
    traits  => [qw/Inherit/],
);

has 'text_decoration' => (
    is => 'rw',
    isa => GiDocStyleFontFamily,
    traits  => [qw/Inherit/],
);

has 'text_underline' => (
    is => 'rw',
    isa => GiDocStyleTextUnderline,
    traits  => [qw/Inherit/],
);

method attr_list ( ) {
    my $list = Pango::AttrList->new;
    #$list->insert( Pango::Color->parse( $self->color ) );
    
    my $fd = Pango::FontDescription->new();
    $fd->set_size( $self->font_size * Pango->scale ) if $self->font_size;
    $fd->set_family( $self->font_family ) if $self->font_family;
    $fd->set_weight( $self->font_weight ) if $self->font_weight;
    $fd->set_variant( $self->font_variant ) if $self->font_variant;
    $fd->set_style( $self->font_style ) if $self->font_style;
    
    my $attr = Pango::AttrFontDesc->new( $fd );
    $list->insert( $attr );
    
    $attr = Pango::AttrUnderline->new( $self->text_underline ) if $self->text_underline;
    $list->insert( $attr );
    
    return $list;
}







1;
