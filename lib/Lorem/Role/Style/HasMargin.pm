package Lorem::Role::Style::HasMargin;

use Moose::Role;
use MooseX::Method::Signatures;

use Lorem::Style::Util qw( parse_margin );
use Lorem::Types qw( GiDocStyleLength );

has [qw(margin_left margin_right margin_top margin_bottom)] => (
    is => 'rw',
    isa => GiDocStyleLength,
    default => 0,
);

around BUILDARGS => sub {
    my $orig  = shift;
    my $class = shift;
    
    my %args = @_;
    my %new_args;
    
    # delegate margin property
    if ( exists $args{margin} ) {
        my $parsed = parse_margin $args{margin};
        for my $s ( qw/left right top bottom/) {
            if ( defined $parsed->{$s} ) {
                $new_args{ 'margin_' . $s } = $parsed->{$s};
            }
        }
        delete $args{margin};
    }
    
    my %return = (%args, %new_args);
    return $class->$orig(%return);
};

method _parse_margin_input ( Str $input ) {
    my @input = $input =~ /^\s*(\d+)?\s*(\d+)?\s*(\d+)?\s*(\d+)?\s*$/;

    my %parsed;
    if ( defined $4 ) {
        @parsed{qw/top right bottom left/} = ($1, $2, $3, $4);
    }
    elsif ( defined $3 ) {
        @parsed{qw/top right bottom left/} = ($1, $2, $3, $2);
    }
    elsif ( defined $2 ) {
        @parsed{qw/top right bottom left/} = ($1, $2, $1, $2);
    }
    elsif ( defined $1 ) {
        @parsed{qw/top right bottom left/} = ($1, $1, $1, $1);
    }
    
    return \%parsed;
}


method set_margin ( Str $input ) {
    my $margin = $self->_parse_margin_input( $input );
    $self->set_margin_left( $margin->{left} );
    $self->set_margin_right( $margin->{right} );
    $self->set_margin_top( $margin->{top} );
    $self->set_margin_bottom( $margin->{bottom} );
}

1;
