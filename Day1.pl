#!/usr/bin/perl

use strict;
use warnings;

use Utils;

my @lines = readFile("Day1.txt");
my $length = @lines;

# foreach (@lines) {
#     print "$_\n";
# }

my $increases = 0;

for (my $i = 1; $i < $length; $i = $i + 1){
    if ($lines[$i] > $lines[$i-1]){
        $increases = $increases + 1;
    }
}

print ("$increases \n");

my $windowIncreases = 0;
my @windowMeasurements = ();
for (my $i = 2; $i < $length; $i = $i + 1){
    my $calc = $lines[$i] + $lines[$i-1] + $lines[$i-2];
    push(@windowMeasurements, $calc);
}

for (my $i = 1; $i < @windowMeasurements; $i = $i + 1){
    if ($windowMeasurements[$i] > $windowMeasurements[$i -1]){
        $windowIncreases = $windowIncreases + 1;
    }
}

print ("$windowIncreases \n");