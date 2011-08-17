package Lorem::Role::Style::HasPadding;

use Moose::Role;
use MooseX::Method::Signatures;

use Lorem::Style::Util qw( parse_padding );
use Lorem::Types qw( GiDocStyleLength );

has [qw(padding_left padding_right padding_top padding_bottom)] => (
    is => 'rw',
    isa => GiDocStyleLength,
    default => 0,
);

around BUILDARGS => sub {
    my $orig  = shift;
    my $class = shift;
    
    my %args = @_;
    my %new_args;
    
    # delegate padding property
    if ( exists $args{padding} ) {
        my $parsed = parse_padding $args{padding};
        for my $s ( qw/left right top bottom/) {
            if ( defined $parsed->{$s} ) {
                $new_args{ 'padding_' . $s } = $parsed->{$s};
            }
        }
        delete $args{padding};
    }
    
    my %return = (%args, %new_args);    
    return $class->$orig(%return);
};


method set_padding ( Str $input ) {
    my $padding = parse_padding $input;
    $self->set_padding_left( $padding->{left} );
    $self->set_padding_right( $padding->{right} );
    $self->set_padding_top( $padding->{top} );
    $self->set_padding_bottom( $padding->{bottom} );
}

1;
