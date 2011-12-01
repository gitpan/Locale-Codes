use Module::Build;
use strict;
use warnings;

my %requires = (
                 'perl'                     => '5.002',
                 'Carp'                     => '0',
                 'Exporter'                 => '0',
               );
my %build_mods = (
                 'Test::More'               => '0',
               );


my $build = Module::Build->new(
        license            => 'perl',
        dist_version       => '3.20',
        dist_author        => 'Sullivan Beck <sbeck@cpan.org>',
        module_name        => 'Locale::Codes',
        dist_abstract      => 'a distribution of modules to handle locale codes',
        requires           => \%requires,
        build_requires     => \%build_mods,
        sign               => 1,
        installdirs        => 'core',
);

$build->create_build_script;
