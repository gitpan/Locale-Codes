#!./perl
#
# all.t - tests for all_* routines in Locale::Country and Locale::Language
#
# There are four tests. We get a list of all codes, convert to language/country
# convert back to code, and check that they're the same. Then we do the same,
# starting with list of languages/countries.
#

use Locale::Country;
use Locale::Language;

print "1..4\n";

my $code;
my $language;
my $country;
my $ok;
my $reverse;


$ok = 1;
foreach $code (all_country_codes())
{
    $country = code2country($code);
    if (!defined $country)
    {
        $ok = 0;
        last;
    }
    $reverse = country2code($country);
    if (!defined $reverse)
    {
        $ok = 0;
        last;
    }
    if ($reverse ne $code)
    {
        $ok = 0;
        last;
    }
}
print ($ok ? "ok 1\n" : "not ok 1\n");


$ok = 1;
foreach $country (all_country_names())
{
    $code = country2code($country);
    if (!defined $code)
    {
        $ok = 0;
        last;
    }
    $reverse = code2country($code);
    if (!defined $reverse)
    {
        $ok = 0;
        last;
    }
    if ($reverse ne $country)
    {
        $ok = 0;
        last;
    }
}
print ($ok ? "ok 2\n" : "not ok 2\n");


$ok = 1;
foreach $code (all_language_codes())
{
    $language = code2language($code);
    if (!defined $language)
    {
        $ok = 0;
        last;
    }
    $reverse = language2code($language);
    if (!defined $reverse)
    {
        $ok = 0;
        last;
    }
    if ($reverse ne $code)
    {
        $ok = 0;
        last;
    }
}
print ($ok ? "ok 3\n" : "not ok 3\n");


$ok = 1;
foreach $language (all_language_names())
{
    $code = language2code($language);
    if (!defined $code)
    {
        $ok = 0;
        last;
    }
    $reverse = code2language($code);
    if (!defined $reverse)
    {
        $ok = 0;
        last;
    }
    if ($reverse ne $language)
    {
        $ok = 0;
        last;
    }
}
print ($ok ? "ok 4\n" : "not ok 4\n");

