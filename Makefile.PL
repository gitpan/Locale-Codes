#
# Makefile.PL for locale-codes distribution:
#	Locale::Language
#	Locale::Country
#	Locale::Currency
#
# Filename:	Makefile.PL
# Author:	Neil Bowers
# Created:	6 May 1997
#

use ExtUtils::MakeMaker;


&WriteMakefile(
               NAME          => 'Locale',
               DISTNAME      => 'Locale-Codes',
               VERSION_FROM  => 'Locale/Language.pm',
               dist          => {COMPRESS => 'gzip', SUFFIX => 'gz'},
              );
 
