
use ExtUtils::MakeMaker;
use 5.006;
use strict;
use warnings;
my %requires = (
                 'Carp'                     => '0',
                 'utf8'                     => '0',
                 'Storable'                 => '0',
                 'Test::More'               => '0',
               );


WriteMakefile(
        NAME             => 'Locale::Codes',
        VERSION          => '3.26',
        ($] >= 5.006
        ? (ABSTRACT=>'a distribution of modules to handle locale codes',
           AUTHOR  =>'Sullivan Beck (sbeck@cpan.org)')
        : ()),
        'dist' => {COMPRESS=>'gzip',SUFFIX=>'gz'},
        PL_FILES  => {},
        PREREQ_PM => \%requires,
        INSTALLDIRS => (($] >= 5.007003) ? 'perl' : 'site'),
);
