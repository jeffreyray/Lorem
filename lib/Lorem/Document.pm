package Lorem::Document;
our $VERSION = '0.01';


use Moose;
use MooseX::SemiAffordanceAccessor;
use MooseX::StrictConstructor;
use MooseX::Method::Signatures;

use Cairo;
use Pango;

use Lorem::Meta::Attribute::Trait::Inherit;

use Lorem::Element::Div;
use Lorem::Element::Page;
use Lorem::Element::Header;
use Lorem::Element::HRule;
use Lorem::Element::Spacer;
use Lorem::Stamp;
use Lorem::Element::Table;
use Lorem::Element::Text;
use Lorem::Types qw( MaybeGiDocDoesStamp );
use Lorem::Util;


extends 'Lorem::Element::Box';
with 'Lorem::Role::HasHeaderFooter';

with 'Lorem::Role::ConstructsElement' => { 
    name => 'header',
    function => sub {
        my $self = shift;
        my $header = Lorem::Element::Header->new( parent => $self, @_ );
        $self->set_header( $header );
        return $header;
    }
};

with 'Lorem::Role::ConstructsElement' => {
    name => 'page',
    function => sub {
        my $self = shift;
        my $new  = Lorem::Element::Page->new( parent => $self, width => $self->width, height => $self->height, style => $self->style->clone );
        #$new->set_margin_top( $self->margin_top );
        #$new->set_margin_left( $self->margin_left );
        #$new->set_margin_right( $self->margin_right );
        #$new->set_margin_bottom( $self->margin_bottom );
        $new->set_header_margin( $self->header_margin );
        $new->set_footer_margin( $self->footer_margin );
        $new->set_header( $self->header->clone ) if $self->header;
        $self->append_element( $new );
        return $new;
    }
};

has '+parent' => (
    required => 0,
);

has 'builder_func' => (
    is => 'rw',
    isa => 'CodeRef',
    writer => 'build',
    reader => 'builder_func',
);



#sub new_ps {
#    my ($class, $w, $h) = @_;
#    
#    die 'usage: ' . __PACKAGE__ . '->new_pdf($width, $height) '
#        if ! defined $w || ! defined $h;
#    
#    my $surface = Cairo::PsSurface->create ( 'output.pdf', $w, $h);
#    my $self = $class->new( surface => $surface, width => $w, height => $h );
#    return $self;
#}

method doc {
    $self;
}

method inner_width {
    $self->width - $self->margin_left - $self->margin_right;
}

method inner_height {
    $self->height - $self->margin_top - $self->margin_bottom;
}

method margin_left_pos {
    $self->margin_left;
}

method margin_right_pos {
    $self->width - $self->margin_right;
}

method margin_top_pos {
    $self->margin_top;
}

method margin_bottom_pos {
    $self->height - $self->margin_bottom;
}

method margin_center_pos {
    $self->margin_left_pos + ( $self->inner_width / 2 );
}

method imprint_header ( @args ) {
    $self->header->imprint( $self, @args ) if $self->header;
}

method imprint_footer {
    $self->footer->imprint( $self ) if $self->footer;
}

method draw_page ( $cr, Int $i ) {
    $self->children->[$i]->imprint( $cr );
}

1;


__END__

=pod

=head1 NAME

Lorem::Document - Document root class

=head1 SYNOPSIS

  use Lorem;

  $doc = Lorem->new_document;

  $page = $doc->new_page;

  $page->new_text( content => 'Lorem Ipsum' );


=head1 DESCRIPTION

L<Lorem::Document> is the root element of a document.

=head1 METHODS

=over 4

=item new_page

Returns a new L<Lorem::Element::Page> object.

=back

=head1 AUTHOR

Jeffrey Ray Hallock E<lt>jeffrey.hallock at gmail dot comE<gt>

=head1 COPYRIGHT

    Copyright (c) 2010 Jeffrey Ray Hallock. All rights reserved.
    This program is free software; you can redistribute it and/or
    modify it under the same terms as Perl itself.

=cut

