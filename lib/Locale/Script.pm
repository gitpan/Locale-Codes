package Locale::Script;
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
use Locale::ScriptCodes;

#=======================================================================
#       Public Global Variables
#=======================================================================

use vars qw($VERSION @ISA @EXPORT @EXPORT_OK);

$VERSION   = 3.00;
@ISA       = qw(Exporter);
@EXPORT    = qw(code2script
                script2code
                all_script_codes
                all_script_names
                script_code2code
                LOCALE_SCRIPT_ALPHA
                LOCALE_SCRIPT_NUMERIC
               );

#=======================================================================
#
# code2script ( CODE [,CODESET] )
#
#=======================================================================

sub code2script {
   my $code    = shift;
   my $codeset = @_ > 0 ? shift : LOCALE_SCRIPT_DEFAULT;

   return undef unless defined $code;
   return undef  if ($codeset !~ /^\d+$/);

   if      ($codeset == LOCALE_SCRIPT_ALPHA) {
      $code    = ucfirst(lc($code));
      $codeset = "alpha";

   } elsif ($codeset == LOCALE_SCRIPT_NUMERIC) {
      $codeset = "num";

   } else {
      return undef;
   }

   if (exists $Locale::ScriptCodes::Code2ScriptID{$codeset}{$code}) {
      my ($id,$i) = @{ $Locale::ScriptCodes::Code2ScriptID{$codeset}{$code} };
      return $Locale::ScriptCodes::Script{$id}[$i];
   } else {
      #---------------------------------------------------------------
      # no such script code!
      #---------------------------------------------------------------
      return undef;
   }
}

#=======================================================================
#
# script2code ( SCRIPT [,CODESET] )
#
#=======================================================================

sub script2code {
   my $script = shift;
   my $codeset = @_ > 0 ? shift : LOCALE_SCRIPT_DEFAULT;

   return undef  if ($codeset !~ /^\d+$/);

   if      ($codeset == LOCALE_SCRIPT_ALPHA) {
      $codeset = "alpha";
   } elsif ($codeset == LOCALE_SCRIPT_NUMERIC) {
      $codeset = "num";
   } else {
      return undef;
   }

   return undef unless defined $script;
   $script = lc($script);

   if (exists $Locale::ScriptCodes::ScriptAlias{$script}) {
      my $id = $Locale::ScriptCodes::ScriptAlias{$script};
      if (exists $Locale::ScriptCodes::ScriptID2Code{$codeset}{$id}) {
	 return $Locale::ScriptCodes::ScriptID2Code{$codeset}{$id};
      }
   }

   #---------------------------------------------------------------
   # no such script!
   #---------------------------------------------------------------
   return undef;
  }

#=======================================================================
#
# script_code2code ( NAME [, CODESET ] )
#
#=======================================================================

sub script_code2code {
   (@_ == 3) or croak "script_code2code() takes 3 arguments!";

   my $code = shift;
   my $inset = shift;
   my $outset = shift;
   my $outcode;
   my $script;

   return undef if $inset == $outset;
   $script = code2script($code, $inset);
   return undef if not defined $script;
   $outcode = script2code($script, $outset);
   return $outcode;
}

#=======================================================================
#
# all_script_codes ( [ CODESET ] )
#
#=======================================================================

sub all_script_codes {
   my $codeset = @_ > 0 ? shift : LOCALE_SCRIPT_DEFAULT;

   return undef  if ($codeset !~ /^\d+$/);

   if      ($codeset == LOCALE_SCRIPT_ALPHA) {
      $codeset = "alpha";
   } elsif ($codeset == LOCALE_SCRIPT_NUMERIC) {
      $codeset = "num";
   } else {
      return undef;
   }

   my @codes = keys %{ $Locale::ScriptCodes::Code2ScriptID{$codeset} };
   return (sort @codes);
}


#=======================================================================
#
# all_script_names ( [ CODESET ] )
#
#=======================================================================

sub all_script_names {
   my $codeset = @_ > 0 ? shift : LOCALE_SCRIPT_DEFAULT;

   return undef  if ($codeset !~ /^\d+$/);

   if      ($codeset == LOCALE_SCRIPT_ALPHA) {
      $codeset = "alpha";
   } elsif ($codeset == LOCALE_SCRIPT_NUMERIC) {
      $codeset = "num";
   } else {
      return undef;
   }

   my @codes = keys %{ $Locale::ScriptCodes::Code2ScriptID{$codeset} };
   my @script;
   foreach my $code (@codes) {
      my($id,$i) = @{ $Locale::ScriptCodes::Code2ScriptID{$codeset}{$code} };
      push @script,$Locale::ScriptCodes::Script{$id}[$i];
   }
   return (sort @script);
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
