#!./perl
#
# all.t - tests for all_* routines in
#	Locale::Country
#	Locale::Language
#	Locale::Currency
#
# There are four tests. We get a list of all codes, convert to
# language/country/currency, # convert back to code,
# and check that they're the same. Then we do the same,
# starting with list of languages/countries/currencies.
#

use Locale::Country;
use Locale::Language;
use Locale::Currency;

print "1..6\n";

my $code;
my $language;
my $country;
my $ok;
my $reverse;
my $currency;


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

$ok = 1;
foreach $code (all_currency_codes())
{
    $currency = code2currency($code);
    if (!defined $currency)
    {
        $ok = 0;
        last;
    }
    $reverse = currency2code($currency);
    if (!defined $reverse)
    {
        $ok = 0;
        last;
    }
    #
    # three special cases:
    #	The Kwacha has two codes - used in Zambia and Malawi
    #	The Russian Ruble has two codes - rub and rur
    #	The Belarussian Ruble has two codes - byb and byr
    if ($reverse ne $code
	&& $code ne 'mwk' && $code ne 'zmk'
	&& $code ne 'byr' && $code ne 'byb'
	&& $code ne 'rub' && $code ne 'rur')
    {
        $ok = 0;
        last;
    }
}
print ($ok ? "ok 5\n" : "not ok 5\n");

$ok = 1;
foreach $currency (all_currency_names())
{
    $code = currency2code($currency);
    if (!defined $code)
    {
        $ok = 0;
        last;
    }
    $reverse = code2currency($code);
    if (!defined $reverse)
    {
        $ok = 0;
        last;
    }
    if ($reverse ne $currency)
    {
        $ok = 0;
        last;
    }
}
print ($ok ? "ok 6\n" : "not ok 6\n");
