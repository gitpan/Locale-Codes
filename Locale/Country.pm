#-----------------------------------------------------------------------

=head1 NAME

Locale::Country - ISO two letter codes for country identification (ISO 3166)

=head1 SYNOPSIS

    use Locale::Country;
    
    $country = code2country('jp');         # $country gets 'Japan'
    $code    = country2code('Norway');     # $code gets 'no'
    
    @codes   = all_country_codes();
    @names   = all_country_names();

=cut

#-----------------------------------------------------------------------

package Locale::Country;
use strict;
require 5.002;

#-----------------------------------------------------------------------

=head1 DESCRIPTION

The C<Locale::Country> module provides access to the ISO two-letter
codes for identifying countries, as defined in ISO 3166. You can either
access the codes via the L<conversion routines> (described below),
or with the two functions which return lists of all country codes or
all country names.

=cut

#-----------------------------------------------------------------------

require Exporter;

#-----------------------------------------------------------------------
#	Public Global Variables
#-----------------------------------------------------------------------
use vars qw($VERSION @ISA @EXPORT);
$VERSION   = '0.003';
@ISA       = qw(Exporter);
@EXPORT    = qw(&code2country &country2code
                &all_country_codes &all_country_names);

#-----------------------------------------------------------------------
#	Private Global Variables
#-----------------------------------------------------------------------
my %CODES     = ();
my %COUNTRIES = ();


#=======================================================================

=head1 CONVERSION ROUTINES

There are two conversion routines: C<code2country()> and C<country2code()>.

=over 8

=item code2country()

This function takes a two letter country code and returns a string
which contains the name of the country identified. If the code is
not a valid country code, as defined by ISO 3166, then C<undef>
will be returned:

    $country = code2country('fi');

=item country2code()

This function takes a country name and returns the corresponding
two letter country code, if such exists.
If the argument could not be identified as a country name,
then C<undef> will be returned:

    $code = country2code('Norway');

The case of the country name is not important.
See the section L<KNOWN BUGS AND LIMITATIONS> below.

=back

=cut

#=======================================================================
sub code2country
{
    my $code = shift;


    return undef unless defined $code;
    $code = lc($code);
    if (exists $CODES{$code})
    {
        return $CODES{$code};
    }
    else
    {
        #---------------------------------------------------------------
        # no such country code!
        #---------------------------------------------------------------
        return undef;
    }
}

sub country2code
{
    my $country = shift;


    return undef unless defined $country;
    $country = lc($country);
    if (exists $COUNTRIES{$country})
    {
        return $COUNTRIES{$country};
    }
    else
    {
        #---------------------------------------------------------------
        # no such country!
        #---------------------------------------------------------------
        return undef;
    }
}

#=======================================================================

=head1 QUERY ROUTINES

There are two function which can be used to obtain a list of all codes,
or all country names:

=over 8

=item C<all_country_codes()>

Returns a list of all two-letter country codes.
The codes are guaranteed to be all lower-case,
and not in any particular order.

=item C<all_country_names()>

Returns a list of all country names for which there is a corresponding
two-letter country code. The names are capitalised, and not returned
in any particular order.

=back

=cut

#=======================================================================
sub all_country_codes
{
    return keys %CODES;
}

sub all_country_names
{
    return values %CODES;
}

#-----------------------------------------------------------------------

=head1 EXAMPLES

The following example illustrates use of the C<code2country()> function.
The user is prompted for a country code, and then told the corresponding
country name:

    $| = 1;   # turn off buffering
    
    print "Enter country code: ";
    chop($code = <STDIN>);
    $country = code2country($code);
    if (defined $country)
    {
        print "$code = $country\n";
    }
    else
    {
        print "'$code' is not a valid country code!\n";
    }

=head1 DOMAIN NAMES

Most top-level domain names are based on these codes,
but there are certain codes which aren't.
If you are using this module to identify country from hostname,
your best bet is to preprocess the country code.

For example, B<edu>, B<com>, B<gov> and friends would map to B<us>;
B<uk> would map to B<gb>. Any others?

=head1 KNOWN BUGS AND LIMITATIONS

=over 4

=item *

When using C<country2code()>, the country name must currently appear
exactly as it does in the source of the module. For example,

    country2code('United States')

will return B<us>, as expected. But the following will all return C<undef>:

    country2code('United States of America')
    country2code('Great Britain')
    country2code('U.S.A.')

If there's need for it, a future version could have variants
for country names.

=item *

In the current implementation, all data is read in when the
module is loaded, and then held in memory.
A lazy implementation would be more memory friendly.

=back

=head1 SEE ALSO

=over 4

=item Locale::Language

ISO two letter codes for identification of language (ISO 639).

=item ISO 3166

The ISO standard which defines these codes.

=item ftp://info.ripe.net/iso3166-countrycodes

Online file with the two-letter codes, three-letter codes,
and country code numbers.
Maintained by the RIPE Network Coordination Centre.

=back


=head1 AUTHOR

Neil Bowers E<lt>neilb@cre.canon.co.ukE<gt>

=head1 COPYRIGHT

Copyright (c) 1997 Canon Research Centre Europe (CRE).

This module is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.

=cut

#-----------------------------------------------------------------------

#=======================================================================
# initialisation code - stuff the DATA into the CODES hash
#=======================================================================
{
    my $code;
    my $country;


    while (<DATA>)
    {
        next unless /\S/;
        chop;
        ($code, $country) = split(/:/, $_, 2);
        $CODES{$code} = $country;
        $COUNTRIES{"\L$country"} = $code;
    }
}

1;

__DATA__
ad:Andorra
ae:United Arab Emirates
af:Afghanistan
ag:Antigua and Barbuda
ai:Anguilla
al:Albania
am:Armenia
an:Netherlands Antilles
ao:Angola
aq:Antarctica
ar:Argentina
as:American Samoa
at:Austria
au:Australia
aw:Aruba
az:Azerbaijan
ba:Bosnia and Herzegowina
bb:Barbados
bd:Bangladesh
be:Belgium
bf:Burkina Faso
bg:Bulgaria
bh:Bahrain
bi:Burundi
bj:Benin
bm:Bermuda
bn:Brunei Darussalam
bo:Bolivia
br:Brazil
bs:Bahamas
bt:Bhutan
bv:Bouvet Island
bw:Botswana
by:Belarus
bz:Belize
ca:Canada
cc:Cocos (Keeling) Islands
cf:Central African Republic
cg:Congo
ch:Switzerland
ci:Cote D'Ivoire
ck:Cook Islands
cl:Chile
cm:Cameroon
cn:China
co:Colombia
cr:Costa Rica
cu:Cuba
cv:Cape Verde
cx:Christmas Island
cy:Cyprus
cz:Czech Republic
de:Germany
dj:Djibouti
dk:Denmark
dm:Dominica
do:Dominican Republic
dz:Algeria
ec:Ecuador
ee:Estonia
eg:Egypt
eh:Western Sahara
er:Eritrea
es:Spain
et:Ethiopia
fi:Finland
fj:Fiji
fk:Falkland Islands (Malvinas)
fm:Micronesia (Federated States of)
fo:Faroe Islands
fr:France
fx:France, Metropolitan
ga:Gabon
gb:United Kingdom
gd:Grenada
ge:Georgia
gf:French Guiana
gh:Ghana
gi:Gibraltar
gl:Greenland
gm:Gambia
gn:Guinea
gp:Guadeloupe
gq:Equatorial Guinea
gr:Greece
gs:South Georgia and the South Sandwich Islands
gt:Guatemala
gu:Guam
gw:Guinea-Bissau
gy:Guyana
hk:Hong Kong
hm:Heard and Mc Donald Islands
hn:Honduras
hr:Croatia
ht:Haiti
hu:Hungary
id:Indonesia
ie:Ireland
il:Israel
in:India
io:British Indian Ocean Territory
iq:Iraq
ir:Iran (Islamic Republic of)
is:Iceland
it:Italy
jm:Jamaica
jo:Jordan
jp:Japan
ke:Kenya
kg:Kyrgyzstan
kh:Cambodia
ki:Kiribati
km:Comoros
kn:Saint Kitts and Nevis
kp:Korea, Democratic People's Republic of
kr:Korea, Republic of
kw:Kuwait
ky:Cayman Islands
kz:Kazakhstan
la:Lao People's Democratic Republic
lb:Lebanon
lc:Saint Lucia
li:Liechtenstein
lk:Sri Lanka
lr:Liberia
ls:Lesotho
lt:Lithuania
lu:Luxembourg
lv:Latvia
ly:Libyan Arab Jamahiriya
ma:Morocco
mc:Monaco
md:Moldova, Republic of
mg:Madagascar
mh:Marshall Islands
mk:Macedonia, the Former Yugoslav Republic of
ml:Mali
mm:Myanmar
mn:Mongolia
mo:Macau
mp:Northern Mariana Islands
mq:Martinique
mr:Mauritania
ms:Montserrat
mt:Malta
mu:Mauritius
mv:Maldives
mw:Malawi
mx:Mexico
my:Malaysia
mz:Mozambique
na:Namibia
nc:New Caledonia
ne:Niger
nf:Norfolk Island
ng:Nigeria
ni:Nicaragua
nl:Netherlands
no:Norway
np:Nepal
nr:Nauru
nu:Niue
nz:New Zealand
om:Oman
pa:Panama
pe:Peru
pf:French Polynesia
pg:Papua New Guinea
ph:Philippines
pk:Pakistan
pl:Poland
pm:St. Pierre and Miquelon
pn:Pitcairn
pr:Puerto Rico
pt:Portugal
pw:Palau
py:Paraguay
qa:Qatar
re:Reunion
ro:Romania
ru:Russian Federation
rw:Rwanda
sa:Saudi Arabia
sb:Solomon Islands
sc:Seychelles
sd:Sudan
se:Sweden
sg:Singapore
sh:St. Helena
si:Slovenia
sj:Svalbard and Jan Mayen Islands
sk:Slovakia
sl:Sierra Leone
sm:San Marino
sn:Senegal
so:Somalia
sr:Suriname
st:Sao Tome and Principe
sv:El Salvador
sy:Syrian Arab Republic
sz:Swaziland
tc:Turks and Caicos Islands
td:Chad
tf:French Southern Territories
tg:Togo
th:Thailand
tj:Tajikistan
tk:Tokelau
tm:Turkmenistan
tn:Tunisia
to:Tonga
tp:East Timor
tr:Turkey
tt:Trinidad and Tobago
tv:Tuvalu
tw:Taiwan, Province of China
tz:Tanzania, United Republic of
ua:Ukraine
ug:Uganda
um:United States Minor Outlying Islands
us:United States
uy:Uruguay
uz:Uzbekistan
va:Vatican City State (Holy See)
vc:Saint Vincent and the Grenadines
ve:Venezuela
vg:Virgin Islands (British)
vi:Virgin Islands (U.S.)
vn:Viet Nam
vu:Vanuatu
wf:Wallis and Futuna Islands
ws:Samoa
ye:Yemen
yt:Mayotte
yu:Yugoslavia
za:South Africa
zm:Zambia
zr:Zaire
zw:Zimbabwe
