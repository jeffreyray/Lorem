package Lorem::Constants;
use strict;
use warnings;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT_OK = qw(%GiDocStyleBorderWidth);

use Readonly;
Readonly::Hash our %GiDocStyleBorderWidth => ( qw/thin 1 medium 2 thick 3/ );

1;
