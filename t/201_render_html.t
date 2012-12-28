use Test::More tests => 1;

use warnings;
use strict;

use CSS;

use Lorem;

use XML::LibXML;

use_ok 'Lorem::Render::Ipsum';

my $r = Lorem::Render::Ipsum->new;
ok $r, 'Created Ipsum Renderer';

my $xml = XML::LibXML->load_xml( location => 't/input/ipsum.xml' );
ok $xml, 'Loaded XML File';

$r->set_dom( $xml );
$r->render;


