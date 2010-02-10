package Locale::Currency;
# Copyright (C) 2001      Canon Research Centre Europe (CRE).
# Copyright (c) 2001      Michael Hennecke
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
use Locale::CurrencyCodes;

#=======================================================================
#       Public Global Variables
#=======================================================================

use vars qw($VERSION @ISA @EXPORT @EXPORT_OK);

$VERSION   = 3.00;
@ISA       = qw(Exporter);
@EXPORT    = qw(code2currency
                currency2code
                all_currency_codes
                all_currency_names
                currency_code2code
                LOCALE_CURR_ALPHA
                LOCALE_CURR_NUMERIC
               );

#=======================================================================
#
# code2currency ( CODE [,CODESET] )
#
#=======================================================================

sub code2currency {
   my $code    = shift;
   my $codeset = @_ > 0 ? shift : LOCALE_CURR_DEFAULT;

   return undef unless defined $code;
   return undef  if ($codeset !~ /^\d+$/);

   if      ($codeset == LOCALE_CURR_ALPHA) {
      $code    = uc($code);
      $codeset = "alpha";

   } elsif ($codeset == LOCALE_CURR_NUMERIC) {
      $codeset = "num";

   } else {
      return undef;
   }

   if (exists $Locale::CurrencyCodes::Code2CurrencyID{$codeset}{$code}) {
      my ($id,$i) = @{ $Locale::CurrencyCodes::Code2CurrencyID{$codeset}{$code} };
      return $Locale::CurrencyCodes::Currency{$id}[$i];
   } else {
      #---------------------------------------------------------------
      # no such currency code!
      #---------------------------------------------------------------
      return undef;
   }
}

#=======================================================================
#
# currency2code ( CURRENCY [,CODESET] )
#
#=======================================================================

sub currency2code {
   my $currency = shift;
   my $codeset = @_ > 0 ? shift : LOCALE_CURR_DEFAULT;

   return undef  if ($codeset !~ /^\d+$/);

   if      ($codeset == LOCALE_CURR_ALPHA) {
      $codeset = "alpha";
   } elsif ($codeset == LOCALE_CURR_NUMERIC) {
      $codeset = "num";
   } else {
      return undef;
   }

   return undef unless defined $currency;
   $currency = lc($currency);

   if (exists $Locale::CurrencyCodes::CurrencyAlias{$currency}) {
      my $id = $Locale::CurrencyCodes::CurrencyAlias{$currency};
      if (exists $Locale::CurrencyCodes::CurrencyID2Code{$codeset}{$id}) {
	 return $Locale::CurrencyCodes::CurrencyID2Code{$codeset}{$id};
      }
   }

   #---------------------------------------------------------------
   # no such currency!
   #---------------------------------------------------------------
   return undef;
  }

#=======================================================================
#
# currency_code2code ( NAME [, CODESET ] )
#
#=======================================================================

sub currency_code2code {
   (@_ == 3) or croak "currency_code2code() takes 3 arguments!";

   my $code = shift;
   my $inset = shift;
   my $outset = shift;
   my $outcode;
   my $currency;

   return undef if $inset == $outset;
   $currency = code2currency($code, $inset);
   return undef if not defined $currency;
   $outcode = currency2code($currency, $outset);
   return $outcode;
}

#=======================================================================
#
# all_currency_codes ( [ CODESET ] )
#
#=======================================================================

sub all_currency_codes {
   my $codeset = @_ > 0 ? shift : LOCALE_CURR_DEFAULT;

   return undef  if ($codeset !~ /^\d+$/);

   if      ($codeset == LOCALE_CURR_ALPHA) {
      $codeset = "alpha";
   } elsif ($codeset == LOCALE_CURR_NUMERIC) {
      $codeset = "num";
   } else {
      return undef;
   }

   my @codes = keys %{ $Locale::CurrencyCodes::Code2CurrencyID{$codeset} };
   return (sort @codes);
}


#=======================================================================
#
# all_currency_names ( [ CODESET ] )
#
#=======================================================================

sub all_currency_names {
   my $codeset = @_ > 0 ? shift : LOCALE_CURR_DEFAULT;

   return undef  if ($codeset !~ /^\d+$/);

   if      ($codeset == LOCALE_CURR_ALPHA) {
      $codeset = "alpha";
   } elsif ($codeset == LOCALE_CURR_NUMERIC) {
      $codeset = "num";
   } else {
      return undef;
   }

   my @codes = keys %{ $Locale::CurrencyCodes::Code2CurrencyID{$codeset} };
   my @currency;
   foreach my $code (@codes) {
      my($id,$i) = @{ $Locale::CurrencyCodes::Code2CurrencyID{$codeset}{$code} };
      push @currency,$Locale::CurrencyCodes::Currency{$id}[$i];
   }
   return (sort @currency);
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
