#
# Makefile.PL for locale-codes distribution:
#	Locale::Language
#	Locale::Country
#	Locale::Currency
#	Locale::Script
#
# Filename:	Makefile.PL
# Author:	Neil Bowers
# Created:	6 May 1997
#

use ExtUtils::MakeMaker;


&WriteMakefile(
		NAME		=> 'Locale-Codes',
		DISTNAME	=> 'Locale-Codes',
		VERSION		=> '2.04',
		AUTHOR		=> 'Neil Bowers <neil@bowers.com>',
		ABSTRACT	=> 'modules for ISO codes identifying countries, languages, currencies, and scripts',
		dist		=> {COMPRESS => 'gzip', SUFFIX => 'gz'},
              );
 
