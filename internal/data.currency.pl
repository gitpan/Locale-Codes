#!/usr/bin/perl -w
# Copyright (c) 2010-2011 Sullivan Beck.  All rights reserved.
# This program is free software; you can redistribute it and/or modify it
# under the same terms as Perl itself.

%currency_alias =
  (
  );

%currency_iso_orig =
  (
   "CFA Franc BCEAO "      => "CFA Franc BCEAO",
   "CFA Franc BEAC "       => "CFA Franc BEAC",
   "Ngultrum "             => "Ngultrum",
   "Unidades de fomento "  => "Unidades de fomento",
   "Pa’anga"               => "Pa'anga",
   "US Dollar (Next day) " => "US Dollar (Next day)",
   "US Dollar (Same day) " => "US Dollar (Same day)",
  );

%currency_iso_ignore =
  (
    "XFU"  => 1,
    "XTS"  => 1,
    "XXX"  => 1,
  );

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

