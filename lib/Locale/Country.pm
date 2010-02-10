package Locale::Country;
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
use Locale::CountryCodes;

#=======================================================================
#       Public Global Variables
#=======================================================================

use vars qw($VERSION @ISA @EXPORT @EXPORT_OK);

$VERSION   = 3.00;
@ISA       = qw(Exporter);
@EXPORT    = qw(code2country
                country2code
                all_country_codes
                all_country_names
                country_code2code
                LOCALE_CODE_ALPHA_2
                LOCALE_CODE_ALPHA_3
                LOCALE_CODE_FIPS
                LOCALE_CODE_NUMERIC
               );

#=======================================================================
#
# code2country ( CODE [, CODESET ] )
#
#=======================================================================

sub code2country {
   my $code    = shift;
   my $codeset = @_ > 0 ? shift : LOCALE_CODE_DEFAULT;

   return undef unless defined $code;

   #-------------------------------------------------------------------
   # Make sure the code is in the right form before we use it
   # to look up the corresponding country.
   # We have to sprintf because the codes are given as 3-digits,
   # with leading 0's. Eg 052 for Barbados.
   #-------------------------------------------------------------------

   return undef  if ($codeset !~ /^\d+$/);

   if      ($codeset == LOCALE_CODE_ALPHA_2) {
      $code    = lc($code);
      $codeset = "alpha2";

   } elsif ($codeset == LOCALE_CODE_ALPHA_3) {
      $code    = lc($code);
      $codeset = "alpha3";

   } elsif ($codeset == LOCALE_CODE_FIPS) {
      $code    = uc($code);
      $codeset = "fips";

   } elsif ($codeset == LOCALE_CODE_NUMERIC) {
      return undef if ($code =~ /\D/);
      $code    = sprintf("%.3d", $code);
      $codeset = "num";

   } else {
      return undef;
   }

   if (exists $Locale::CountryCodes::Code2CountryID{$codeset}{$code}) {
      my ($id,$i) = @{ $Locale::CountryCodes::Code2CountryID{$codeset}{$code} };
      return $Locale::CountryCodes::Country{$id}[$i];
   } else {
      #---------------------------------------------------------------
      # no such country code!
      #---------------------------------------------------------------
      return undef;
   }
}

#=======================================================================
#
# country2code ( NAME [, CODESET ] )
#
#=======================================================================

sub country2code {
   my $country = shift;
   my $codeset = @_ > 0 ? shift : LOCALE_CODE_DEFAULT;

   return undef  if ($codeset !~ /^\d+$/);

   if      ($codeset == LOCALE_CODE_ALPHA_2) {
      $codeset = "alpha2";
   } elsif ($codeset == LOCALE_CODE_ALPHA_3) {
      $codeset = "alpha3";
   } elsif ($codeset == LOCALE_CODE_FIPS) {
      $codeset = "fips";
   } elsif ($codeset == LOCALE_CODE_NUMERIC) {
      $codeset = "num";
   } else {
      return undef;
   }

   return undef unless defined $country;
   $country = lc($country);

   if (exists $Locale::CountryCodes::CountryAlias{$country}) {
      my $id = $Locale::CountryCodes::CountryAlias{$country};
      if (exists $Locale::CountryCodes::CountryID2Code{$codeset}{$id}) {
	 return $Locale::CountryCodes::CountryID2Code{$codeset}{$id};
      }
   }

   #---------------------------------------------------------------
   # no such country!
   #---------------------------------------------------------------
   return undef;
}

#=======================================================================
#
# country_code2code ( NAME [, CODESET ] )
#
#=======================================================================

sub country_code2code {
   (@_ == 3) or croak "country_code2code() takes 3 arguments!";

   my $code = shift;
   my $inset = shift;
   my $outset = shift;
   my $outcode;
   my $country;

   return undef if $inset == $outset;
   $country = code2country($code, $inset);
   return undef if not defined $country;
   $outcode = country2code($country, $outset);
   return $outcode;
}

#=======================================================================
#
# all_country_codes ( [ CODESET ] )
#
#=======================================================================

sub all_country_codes {
   my $codeset = @_ > 0 ? shift : LOCALE_CODE_DEFAULT;

   return undef  if ($codeset !~ /^\d+$/);

   if      ($codeset == LOCALE_CODE_ALPHA_2) {
      $codeset = "alpha2";
   } elsif ($codeset == LOCALE_CODE_ALPHA_3) {
      $codeset = "alpha3";
   } elsif ($codeset == LOCALE_CODE_FIPS) {
      $codeset = "fips";
   } elsif ($codeset == LOCALE_CODE_NUMERIC) {
      $codeset = "num";
   } else {
      return undef;
   }

   my @codes = keys %{ $Locale::CountryCodes::Code2CountryID{$codeset} };
   return (sort @codes);
}


#=======================================================================
#
# all_country_names ( [ CODESET ] )
#
#=======================================================================

sub all_country_names {
   my $codeset = @_ > 0 ? shift : LOCALE_CODE_DEFAULT;

   return undef  if ($codeset !~ /^\d+$/);

   if      ($codeset == LOCALE_CODE_ALPHA_2) {
      $codeset = "alpha2";
   } elsif ($codeset == LOCALE_CODE_ALPHA_3) {
      $codeset = "alpha3";
   } elsif ($codeset == LOCALE_CODE_FIPS) {
      $codeset = "fips";
   } elsif ($codeset == LOCALE_CODE_NUMERIC) {
      $codeset = "num";
   } else {
      return undef;
   }

   my @codes = keys %{ $Locale::CountryCodes::Code2CountryID{$codeset} };
   my @country;
   foreach my $code (@codes) {
      my($id,$i) = @{ $Locale::CountryCodes::Code2CountryID{$codeset}{$code} };
      push @country,$Locale::CountryCodes::Country{$id}[$i];
   }
   return (sort @country);
}

#=======================================================================
#
# alias_code ( ALIAS => CODE [ , CODESET ] )
#
# Add an alias for an existing code. If the CODESET isn't specified,
# then we use the default (currently the alpha-2 codeset).
#
#   Locale::Country::alias_code('uk' => 'gb');
#
#=======================================================================

sub alias_code {
   my $nowarn   = 0;
   $nowarn      = 1, pop  if ($_[$#_] eq "nowarn");
   my $alias    = shift;
   my $code     = shift;
   my $codeset  = @_ > 0 ? shift : LOCALE_CODE_DEFAULT;

   return 0  if ($codeset !~ /^\d+$/);

   if      ($codeset == LOCALE_CODE_ALPHA_2) {
      $codeset = "alpha2";
      $alias   = lc($alias);
   } elsif ($codeset == LOCALE_CODE_ALPHA_3) {
      $codeset = "alpha3";
      $alias   = lc($alias);
   } elsif ($codeset == LOCALE_CODE_FIPS) {
      $codeset = "fips";
      $alias   = uc($alias);
   } elsif ($codeset == LOCALE_CODE_NUMERIC) {
      $codeset = "num";
      return undef if ($alias =~ /\D/);
      $alias   = sprintf("%.3d", $alias);
   } else {
      carp "rename_country(): unknown codeset\n"  unless ($nowarn);
      return 0;
   }

   # Check that $code exists in the codeset.

   my ($countryID,$i);
   if (exists $Locale::CountryCodes::Code2CountryID{$codeset}{$code}) {
      ($countryID,$i) = @{ $Locale::CountryCodes::Code2CountryID{$codeset}{$code} };
   } else {
      carp "alias_code: attempt to alias \"$alias\" to unknown country code \"$code\"\n"
	unless ($nowarn);
      return 0;
   }

   # Cases:
   #   The alias already exists.
   #      Error
   #
   #   It's new
   #      Create a new entry in Code2CountryID
   #      Replace the entiry in CountryID2Code
   #      Regenerate %Codes

   if (exists $Locale::CountryCodes::Code2CountryID{$codeset}{$alias}) {
      carp "alias_code: attempt to alias \"$alias\" which is already in use\n"
	unless ($nowarn);
      return 0;
   }

   $Locale::CountryCodes::Code2CountryID{$codeset}{$alias} = [ $countryID, $i ];
   $Locale::CountryCodes::CountryID2Code{$codeset}{$countryID} = $alias;

   my @codes = keys %{ $Locale::CountryCodes::Code2CountryID{$codeset} };
   $Locale::CountryCodes::Codes{$codeset} = [ sort @codes ];

   return $alias;
}

#=======================================================================
#
# rename_country
#
# change the official name for a country, eg:
#       gb => 'Great Britain'
# rather than the standard 'United Kingdom'. The original is retained
# as an alias, but the new name will be returned if you lookup the
# name from code.
#
#=======================================================================

sub rename_country {
   my $nowarn   = 0;
   $nowarn      = 1, pop  if ($_[$#_] eq "nowarn");
   my $code     = shift;
   my $new_name = shift;
   my $codeset  = @_ > 0 ? shift : LOCALE_CODE_DEFAULT;

   return 0  if ($codeset !~ /^\d+$/);

   if      ($codeset == LOCALE_CODE_ALPHA_2) {
      $codeset = "alpha2";
      $code    = lc($code);
   } elsif ($codeset == LOCALE_CODE_ALPHA_3) {
      $codeset = "alpha3";
      $code    = lc($code);
   } elsif ($codeset == LOCALE_CODE_FIPS) {
      $codeset = "fips";
      $code    = uc($code);
   } elsif ($codeset == LOCALE_CODE_NUMERIC) {
      return undef if ($code =~ /\D/);
      $code    = sprintf("%.3d", $code);
      $codeset = "num";
   } else {
      carp "rename_country(): unknown codeset\n"  unless ($nowarn);
      return 0;
   }

   # Check that $code exists in the codeset.

   my $countryID;
   if (exists $Locale::CountryCodes::Code2CountryID{$codeset}{$code}) {
      $countryID = $Locale::CountryCodes::Code2CountryID{$codeset}{$code}[0];
   } else {
      carp "rename_country(): unknown code: $code\n"  unless ($nowarn);
      return 0;
   }

   # Cases:
   #   Renaming from one country to another with a different CountryID
   #      Error
   #
   #   Renaming from one country to another with the same CountryID
   #      Just change Code2CountryID
   #
   #   Renaming from one country to a new alias
   #      Create a new alias
   #      Change Code2CountryID
   #
   # Then regenerate the %Countries for this codeset.

   if (exists $Locale::CountryCodes::CountryAlias{lc($new_name)}) {
      # Changing to an existing alias.

      my$new_countryID = $Locale::CountryCodes::CountryAlias{lc($new_name)};
      if ($new_countryID != $countryID) {
	 carp "rename_country(): rename to an existing country not allowed\n"
	   unless ($nowarn);
	 return 0;
      }

      my $i = 0;
      for (my $j=0; $j<=$#{ $Locale::CountryCodes::Country{$countryID} }; $j++) {
         $i=$j, last
           if (lc($Locale::CountryCodes::Country{$countryID}[$j]) eq lc($new_name));
      }

      $Locale::CountryCodes::Code2CountryID{$codeset}{$code}[1] = $i;

   } else {

      push @{ $Locale::CountryCodes::Country{$countryID} },$new_name;
      my $i = $#{ $Locale::CountryCodes::Country{$countryID} };
      $Locale::CountryCodes::CountryAlias{lc($new_name)} = $countryID;
      $Locale::CountryCodes::Code2CountryID{$codeset}{$code}[1] = $i;
   }

   my @codes = keys %{ $Locale::CountryCodes::Code2CountryID{$codeset} };
   my @countries;
   foreach my $code (@codes) {
      my($cid,$i) = @{ $Locale::CountryCodes::Code2CountryID{$codeset}{$code} };
      push(@countries,$Locale::CountryCodes::Country{$cid}[$i]);
   }
   $Locale::CountryCodes::Countries{$codeset} = [ sort @countries ];

   return 1;
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
