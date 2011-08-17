#!/usr/bin/perl -w
use warnings;
use strict;

use Test::More qw(no_plan);

use Gtk2 '-init';


use Lorem::Document;
use Lorem::Surface::Pdf;
use Lorem::Util qw( in2pt pt2in );


my $doc = Lorem::Document->new;

$doc->set_margin_top( in2pt(.5) );
$doc->set_margin_left( in2pt(.5) );

$doc->set_header_margin( in2pt(.125) );
$doc->new_header( left => 'left', center => 'middle', right => 'right' );


my @list = (
    [qw[5044 Jeffrey Ray Hallock 01/01/2001]],
    [qw[5045 Homer J Simpson 01/02/2010]],
    [qw[5046 Marge S Simpson 02/05/2009]],
);


#$doc->build(sub {
#    my ($doc, $context) = @_;
    
    for my $entry (@list) {
        my $page = $doc->new_page;
        my $text = $page->new_text( content => join ' | ', @$entry );
    }
#});

my $surface = Lorem::Surface::Pdf->new(file_name => 't/output/pdf_surface.pdf', width => in2pt(8.5), height => in2pt(11) );
ok $surface, 'surface ok';

$surface->print( $doc );



