package Locale::Language;
# Copyright (C) 2001      Canon Research Centre Europe (CRE).
# Copyright (C) 2002-2009 Neil Bowers
# Copyright (c) 2010-2010 Sullivan Beck
# This program is free software; you can redistribute it and/or modify it
# under the same terms as Perl itself.

use strict;
use warnings;
require 5.002;

require Exporter;
use Carp;
use Locale::Constants;
use Locale::LanguageCodes;

#=======================================================================
#       Public Global Variables
#=======================================================================

use vars qw($VERSION @ISA @EXPORT @EXPORT_OK);

$VERSION   = 3.00;
@ISA       = qw(Exporter);
@EXPORT    = qw(code2language
                language2code
                all_language_codes
                all_language_names
                language_code2code
                LOCALE_LANG_ALPHA_2
                LOCALE_LANG_ALPHA_3
                LOCALE_LANG_TERM
               );

#=======================================================================
#
# code2language ( CODE [,CODESET] )
#
#=======================================================================

sub code2language {
   my $code    = shift;
   my $codeset = @_ > 0 ? shift : LOCALE_LANG_DEFAULT;

   return undef unless defined $code;
   return undef  if ($codeset !~ /^\d+$/);

   if      ($codeset == LOCALE_LANG_ALPHA_2) {
      $code    = lc($code);
      $codeset = "alpha2";

   } elsif ($codeset == LOCALE_LANG_ALPHA_3) {
      $code    = lc($code);
      $codeset = "alpha3";

   } elsif ($codeset == LOCALE_LANG_TERM) {
      $code    = lc($code);
      $codeset = "term";

   } else {
      return undef;
   }

   if (exists $Locale::LanguageCodes::Code2LanguageID{$codeset}{$code}) {
      my ($id,$i) = @{ $Locale::LanguageCodes::Code2LanguageID{$codeset}{$code} };
      return $Locale::LanguageCodes::Language{$id}[$i];
   } else {
      #---------------------------------------------------------------
      # no such language code!
      #---------------------------------------------------------------
      return undef;
   }
}

#=======================================================================
#
# language2code ( LANGUAGE [,CODESET] )
#
#=======================================================================

sub language2code {
   my $language = shift;
   my $codeset = @_ > 0 ? shift : LOCALE_LANG_DEFAULT;

   return undef  if ($codeset !~ /^\d+$/);

   if      ($codeset == LOCALE_LANG_ALPHA_2) {
      $codeset = "alpha2";
   } elsif ($codeset == LOCALE_LANG_ALPHA_3) {
      $codeset = "alpha3";
   } elsif ($codeset == LOCALE_LANG_TERM) {
      $codeset = "term";
   } else {
      return undef;
   }

   return undef unless defined $language;
   $language = lc($language);

   if (exists $Locale::LanguageCodes::LanguageAlias{$language}) {
      my $id = $Locale::LanguageCodes::LanguageAlias{$language};
      if (exists $Locale::LanguageCodes::LanguageID2Code{$codeset}{$id}) {
	 return $Locale::LanguageCodes::LanguageID2Code{$codeset}{$id};
      }
   }

   #---------------------------------------------------------------
   # no such language!
   #---------------------------------------------------------------
   return undef;
  }

#=======================================================================
#
# language_code2code ( NAME [, CODESET ] )
#
#=======================================================================

sub language_code2code {
   (@_ == 3) or croak "language_code2code() takes 3 arguments!";

   my $code = shift;
   my $inset = shift;
   my $outset = shift;
   my $outcode;
   my $language;

   return undef if $inset == $outset;
   $language = code2language($code, $inset);
   return undef if not defined $language;
   $outcode = language2code($language, $outset);
   return $outcode;
}

#=======================================================================
#
# all_language_codes ( [ CODESET ] )
#
#=======================================================================

sub all_language_codes {
   my $codeset = @_ > 0 ? shift : LOCALE_LANG_DEFAULT;

   return undef  if ($codeset !~ /^\d+$/);

   if      ($codeset == LOCALE_LANG_ALPHA_2) {
      $codeset = "alpha2";
   } elsif ($codeset == LOCALE_LANG_ALPHA_3) {
      $codeset = "alpha3";
   } elsif ($codeset == LOCALE_LANG_TERM) {
      $codeset = "term";
   } else {
      return undef;
   }

   my @codes = keys %{ $Locale::LanguageCodes::Code2LanguageID{$codeset} };
   return (sort @codes);
}


#=======================================================================
#
# all_language_names ( [ CODESET ] )
#
#=======================================================================

sub all_language_names {
   my $codeset = @_ > 0 ? shift : LOCALE_LANG_DEFAULT;

   return undef  if ($codeset !~ /^\d+$/);

   if      ($codeset == LOCALE_LANG_ALPHA_2) {
      $codeset = "alpha2";
   } elsif ($codeset == LOCALE_LANG_ALPHA_3) {
      $codeset = "alpha3";
   } elsif ($codeset == LOCALE_LANG_TERM) {
      $codeset = "term";
   } else {
      return undef;
   }

   my @codes = keys %{ $Locale::LanguageCodes::Code2LanguageID{$codeset} };
   my @language;
   foreach my $code (@codes) {
      my($id,$i) = @{ $Locale::LanguageCodes::Code2LanguageID{$codeset}{$code} };
      push @language,$Locale::LanguageCodes::Language{$id}[$i];
   }
   return (sort @language);
}

1;
# Local Variables:
# mode: cperl
# indent-tabs-mode: nil
# cperl-indent-level: 3
# cperl-continued-statement-offset: 2
# cperl-continued-brace-offset: 0
# cperl-brace-offset: 0
# cperl-brace-imaginary-offset: 0
# cperl-label-offset: -2
# End:
