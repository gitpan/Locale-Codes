use Module::Build;
use strict;
use warnings;

my %requires = (
                 'perl'                     => '5.002',
                 'Carp'                     => '0',
                 'constant'                 => '0',
               );
my %build_mods = (
                 'Storable'                 => '0',
                 'Test::More'               => '0',
                 'Test::Pod'                => '0',
                 'Test::Pod::Coverage'      => '0',
               );


my $build = Module::Build->new(
        license            => 'perl',
        dist_version       => '3.11',
        dist_author        => 'Sullivan Beck <sbeck@cpan.org>',
        module_name        => 'Locale::Codes',
        dist_abstract      => 'a distribution of modules to handle locale codes',
        requires           => \%requires,
        build_requires     => {},
        build_recommends   => \%build_mods,
        sign               => 1,
        installdirs        => 'core',
);

$build->create_build_script;
