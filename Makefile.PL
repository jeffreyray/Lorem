use 5.010000;
use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    NAME              => 'Lorem',
    VERSION_FROM      => 'lib/Gi/Doc.pm', # finds $VERSION
    PREREQ_PM         => {
        'Cairo' => 0,
        'Pango' => 0,
	'Moose' => 0,
	'MooseX::Clone' => 0,
	'MooseX::Role::Parameterized' => 0,
	'MooseX::SemiAffordanceAccessor' => 0,
	'MooseX::StrictConstructor' => 0,
	'TryCatch' => 0,
    }, 
    ($] >= 5.005 ?     ## Add these new keywords supported since 5.005
      (ABSTRACT_FROM  => 'lib/Gi/Doc.pm', # retrieve abstract from module
       AUTHOR         => 'Jeffrey Ray Hallock <jeffrey at jeffrey.ray dot info>') : ()),
);
