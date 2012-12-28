use Test::More tests => 10;

use warnings;
use strict;

use CSS;

use Lorem;



my $string = <<END_CSS;
table {
    border: thin solid black;
}
table {
    margin-top: thin solid black;
}
td {
    padding: 5;
}
END_CSS


my $css = CSS->new( { 'parser' => 'CSS::Parse::Lite' } );
$css->read_string( $string );

print $css->output, "\n";

print $css->get_style_by_selector( 'table' ), "\n";


