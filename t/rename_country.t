#!/usr/bin/perl -w

require 5.002;

$runtests=shift(@ARGV);
if ( -f "t/test.pl" ) {
  require "t/test.pl";
  $dir="./lib";
  $tdir="t";
} elsif ( -f "test.pl" ) {
  require "test.pl";
  $dir="../lib";
  $tdir=".";
} else {
  die "ERROR: cannot find test.pl\n";
}

unshift(@INC,$dir);
use Locale::Country;

%type = ( "LOCALE_CODE_ALPHA_2" => LOCALE_CODE_ALPHA_2,
          "LOCALE_CODE_ALPHA_3" => LOCALE_CODE_ALPHA_3,
          "LOCALE_CODE_NUMERIC" => LOCALE_CODE_NUMERIC,
        );

sub test {
   my(@test) = @_;

   if ($test[0] eq "rename_country") {
      shift(@test);
      $test[2]  = $type{$test[2]}
        if (@test == 3  &&  $test[2]  &&  exists $type{$test[2]});
      return Locale::Country::rename_country(@test,"nowarn");

   } else {
      $test[1]  = $type{$test[1]}
        if (@test == 2  &&  $test[1]  &&  exists $type{$test[1]});
      return code2country(@test);
   }
}

$tests = "

gb
   ~
   United Kingdom

rename_country x1 NewName ~ 0

rename_country gb NewName LOCALE_CODE_FOO ~ 0

rename_country gb Macao ~ 0

rename_country gb NewName LOCALE_CODE_ALPHA_3 ~ 0

gb
   ~
   United Kingdom

rename_country gb NewName ~ 1

gb
   ~
   NewName

";

print "rename_country...\n";
test_Func(\&test,$tests,$runtests);

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
