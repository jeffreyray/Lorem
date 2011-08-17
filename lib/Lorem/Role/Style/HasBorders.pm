package Lorem::Role::Style::HasBorders;

use Moose::Role;
use MooseX::Method::Signatures;

use Lorem::Style::Util qw( parse_border );

has [qw(border_bottom_color border_left_color border_right_color border_top_color)] => (
    is => 'rw',
    isa => 'Str',
    default => '#000000',
);

has [qw(border_bottom_style border_left_style border_right_style border_top_style)] => (
    is => 'rw',
    isa => 'Str',
    default => 'none',
);

has [qw(border_bottom_width border_left_width border_right_width border_top_width)] => (
    is => 'rw',
    isa => 'Str',
    default => 'thin',
);

around BUILDARGS => sub {
    my $orig  = shift;
    my $class = shift;
    
    my %args = @_;
    my %new_args;

    # border
    if ( exists $args{border} ) {
        my $parsed = parse_border $args{border};
        for my $a (qw/width style color/) {
            next if ! defined $parsed->{$a};
            if ( defined $parsed->{$a} ) {
                for my $s (qw/bottom left right top/) {
                    $new_args{ 'border_' . $s . '_' . $a } = $parsed->{$a};
                }
            }
        }
        delete $args{border};
    }
    # border-left border-right border-top border-bottom
    for my $s ( qw/bottom left right top/ ) {
        my $att = 'border_' . $s;
        if ( exists $args{$att} ) {
            my $parsed = parse_border $args{$att};
            for my $a ( qw/width style color/ ) {
                next if ! defined $parsed->{$a};
                if ( defined $parsed->{$a} ) {
                    $new_args{ 'border_' . $s . '_' . $a } = $parsed->{$a};
                }
            }
            delete $args{$att};
        }
    }
    # border-color border-style border-width
    for my $a (qw/color style width/) {
        my $att = 'border_' . $a;
        if ( exists $args{$att} ) {
            for my $s ( qw/bottom left right top/ ) {
                $new_args{ 'border_' . $s . '_' . $a } = $args{$att};
            }
            delete $args{$att};
        }
    }
    
    my %return = (%args, %new_args);
    return $class->$orig(%return);
};

method set_border ( Str $input ) {
    my $parsed = parse_border $input;
    
    if ( defined $parsed->{width} ) {
        $self->set_border_bottom_width( $parsed->{width} );
        $self->set_border_left_width( $parsed->{width} );
        $self->set_border_right_width( $parsed->{width} );
        $self->set_border_top_width( $parsed->{width} );
    }
    if ( defined $parsed->{style} ) {
        $self->set_border_bottom_style( $parsed->{style} );
        $self->set_border_left_style( $parsed->{style} );
        $self->set_border_right_style( $parsed->{style} );
        $self->set_border_top_style( $parsed->{style} );
    }
    if ( defined $parsed->{color} ) {
        $self->set_border_bottom_color( defined $parsed->{color} );
        $self->set_border_left_color( defined $parsed->{color} );
        $self->set_border_right_color( defined $parsed->{color} );
        $self->set_border_top_color( defined $parsed->{color} );
    }    
}

method set_border_bottom ( Str $input ) {
    my ($width, $border_style, $color) = $self->_parse_border_input( $input );
    defined $width && $self->set_border_bottom_width( $width );
    defined $border_style && $self->set_border_bottom_style( $border_style );
    defined $color &&  $self->set_border_bottom_color( $color );   
}


method set_border_left ( Str $input ) {
    my ($width, $border_style, $color) = $self->_parse_border_input( $input );
    defined $width && $self->set_border_left_width( $width );
    defined $border_style && $self->set_border_left_style( $border_style );
    defined $color &&  $self->set_border_left_color( $color );   
}

method set_border_right ( Str $input ) {
    my ($width, $border_style, $color) = $self->_parse_border_input( $input );
    defined $width && $self->set_border_right_width( $width );
    defined $border_style && $self->set_border_right_style( $border_style );
    defined $color &&  $self->set_border_right_color( $color ); 
}

method set_border_top ( Str $input ) {
    my ($width, $border_style, $color) = $self->_parse_border_input( $input );
    defined $width && $self->set_border_top_width( $width );
    defined $border_style && $self->set_border_top_style( $border_style );
    defined $color &&  $self->set_border_top_color( $color ); 
}

method set_border_color ( Str $color ) {
    $self->set_border_bottom_color( $color );
    $self->set_border_left_color( $color );
    $self->set_border_right_color( $color );
    $self->set_border_top_color( $color );
}

method set_border_style ( Str $border_style ) {
    $self->set_border_bottom_style( $border_style );
    $self->set_border_left_style( $border_style );
    $self->set_border_right_style( $border_style );
    $self->set_border_top_style( $border_style );
}


method set_border_width( Str $width ) {
    $self->set_border_bottom_width( $width );
    $self->set_border_left_width( $width );
    $self->set_border_right_width( $width );
    $self->set_border_top_width( $width );
}







1;
