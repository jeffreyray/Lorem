package Lorem::Types;

use MooseX::Types
    -declare => [ qw(
GiDocAttrTextAlign
GiDocElement
GiDocText
GiDocDoesStamp
MaybeGiDocDoesStamp
GiDocDocumentObject
GiDocStyle
GiDocStyleElementBorder
GiDocStyleFontFamily
GiDocStyleFontSize
GiDocStyleFontStyle
GiDocStyleFontWeight
GiDocStyleFontVariant
GiDocStyleBorderWidth
GiDocStyleBorderStyle
GiDocStyleColor
GiDocStyleDimension
GiDocStyleLength
GiDocStyleRelativeLength
GiDocStyleTextAlign
GiDocStyleTextDecoration
GiDocStyleTextUnderline
GiDocStyleVerticalAlign
)];

use MooseX::Types::Moose qw( Int Num Str );

type GiDocDoesStamp,
    where { $_ && $_->does('Lorem::Role::Stamp') };

type MaybeGiDocDoesStamp,
    where { ! defined $_ || $_->does('Lorem::Role::Stamp') };

type GiDocDocumentObject,
    where { $_ &&  $_->isa('Lorem::Element') || $_->isa('Lorem') };


# elements
class_type GiDocElement,
    { class => 'Lorem::Element' };
    
class_type GiDocText,
    { class => 'Lorem::Element::Text' };

coerce GiDocText,
    from Str,
    via {  Lorem::Element::Text->new( content => $_ ) };
    
# element attributes
subtype GiDocAttrTextAlign,
    as Str,
    where { $_ =~ /left|right|center/ };
 

# style values
class_type GiDocStyle,
    { class => 'Lorem::Style' };

coerce GiDocStyle,
    from Str,
    via { 'Lorem::Style'->new( $_ ) };

subtype GiDocStyleBorderWidth,
    as Str,
    where { $_ =~ /thin|medium|thick/ };

subtype GiDocStyleBorderStyle,
    as Str,
    where { $_ =~ /none|hidden|dotted|dashed|solid|double|groove|ridge|inset|outset/ };
    
type GiDocStyleDimension,
    where { is_GiDocStyleLength($_) || is_GiDocStyleRelativeLength($_) };
  
subtype GiDocStyleColor,
    as Str;  

class_type GiDocStyleElementBorder,
    { class => 'Lorem::Style::Element::Border' };   

subtype GiDocStyleFontFamily,
    as Str;

subtype GiDocStyleFontSize,
    as Num;
    
subtype GiDocStyleFontWeight,
    as Str,
    where { $_ =~ /normal|bold|bolder|lighter/ };

subtype GiDocStyleFontStyle,
    as Str,
    where  { $_ =~ /normal|italic|oblique|inherit/ };
    
type GiDocStyleLength,
    where { is_Num($_) || is_Str($_) && $_ =~ /\d+%/ };

type GiDocStyleRelativeLength,
    where { is_Str($_) && $_ =~ /\d+%/ };
    
subtype GiDocStyleFontVariant,
    as Str,
    where  { $_ =~ /normal|small-caps|inherit/ };

subtype GiDocStyleTextAlign,
    as Str,
    where { $_ =~ /left|right|center|inherit/ };

subtype GiDocStyleTextDecoration,
    as Str,
    where { $_ =~ /overline|line-through|underline|blink/ };
    
subtype GiDocStyleTextUnderline,
    as Str,
    where  { $_ =~ /normal|small-caps|inherit/ };
    
subtype GiDocStyleVerticalAlign,
    as Str,
    where { $_ =~ /baseline|sub|super|top|text-top|middle|bottom|text-bottom|inherit/ };

    
1;
