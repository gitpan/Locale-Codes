#!./perl
#
# language.t - tests for Locale::Language
#
use Locale::Language;

#-----------------------------------------------------------------------
# This is an array of tests. Each test is eval'd as an expression.
# If it evaluates to FALSE, then "not ok N" is printed for the test,
# otherwise "ok N".
#-----------------------------------------------------------------------
@TESTS =
(
	#================================================
	# TESTS FOR code2language
	#================================================

 #---- selection of examples which should all result in undef -----------
 '!defined code2language()',                 # no argument => undef returned
 '!defined code2language(undef)',            # undef arg   => undef returned
 '!defined code2language("zz")',             # illegal code => undef
 '!defined code2language("jp")',             # ja for lang, jp for country

 #---- some successful examples -----------------------------------------
 'code2language("DA") eq "Danish"',
 'code2language("eo") eq "Esperanto"',
 'code2language("fi") eq "Finnish"',
 'code2language("en") eq "English"',
 'code2language("aa") eq "Afar"',            # first in DATA segment
 'code2language("zu") eq "Zulu"',            # last in DATA segment

	#================================================
	# TESTS FOR language2code
	#================================================

 #---- selection of examples which should all result in undef -----------
 '!defined language2code()',                 # no argument => undef returned
 '!defined language2code(undef)',            # undef arg   => undef returned
 '!defined language2code("Banana")',         # illegal lang name => undef

 #---- some successful examples -----------------------------------------
 'language2code("Japanese")  eq "ja"',
 'language2code("japanese")  eq "ja"',
 'language2code("japanese")  ne "jp"',
 'language2code("French")    eq "fr"',
 'language2code("Greek")     eq "el"',
 'language2code("english")   eq "en"',
 'language2code("ESTONIAN")  eq "et"',
 'language2code("Afar")      eq "aa"',       # first in DATA segment
 'language2code("Zulu")      eq "zu"',       # last in DATA segment
);

print "1..", int(@TESTS), "\n";

$testid = 1;
foreach $test (@TESTS)
{
    eval "print (($test) ? \"ok $testid\\n\" : \"not ok $testid\\n\" )";
    print "not ok $testid\n" if $@;
    ++$testid;
}

exit 0;
