require "data.country.pl";
%D = %{  $Data{'country'}{'iso'}{'orig'}{'name'} };
foreach my $key (sort keys %D) {
   $val = $D{$key};
   if ($val ne ucfirst(lc($key))) {
      print "$key\n";
   }
}
