use Module::Package;
my $pack = Module::Package->new(
    name => 'Lorem',
    version_from => 'lib/Lorem.pm',
    prereq_pm => {
        'Cairo' => 0,
        'Pango' => 0,
	'Moose' => 0,
	'MooseX::SemiAffordanceAccessor' => 0,
        'MooseX::StrictConstructor' => 0,
	'MooseX::Types' => 0,
    },
    abstract_from => 'lib/Lorem.pm',
    author => 'Jeffrey Ray Hallock <jeffrey dot hallock at gmail dot com>',
    exclude => [ '*.komodoproject', '.komodotools', '.git' ],
);
$pack->package;


