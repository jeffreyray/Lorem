package Lorem::Util;
use strict;
use warnings;
use Carp 'confess';

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT_OK = qw(in2pt pt2in escape_ampersand percent_of escape_entities escape_entity);

sub in2pt {
    my $inches = shift;
    $inches * 72;
}

sub pt2in {
    my $points = shift;
    $points / 72;
}

sub percent_of {
    my ($percent, $of) = @_;
    $percent =~ s/%//;
    
    confess 'invalid args' if ! defined $percent || ! defined $of;
    
    return ($percent / 100) * $of;
}

sub escape_ampersand {
    my $string = shift;
    confess 'usage is escape_ampersand( $string )' if ! defined $string;
    $string =~ s/&/&amp;/g;
    return $string;
}

sub escape_entity {
    my $string = shift;
    
    warn 'Lore::Util::escape_entity is deprecated, use Lorem::Util::escape_entities instead';
    
    confess 'usage is escape_ampersand( $string )' if ! defined $string;
    $string =~ s/&/&amp;/g;
    return $string;
}

sub escape_entities {
    my $string = shift;
    confess 'usage is escape_ampersand( $string )' if ! defined $string;
    $string =~ s/&/&amp;/g;
    return $string;
}

1;
