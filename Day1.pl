#!/usr/bin/perl

use strict;
use warnings;

use Utils;

my @lines = readFile("Day1.txt");
my $length = @lines;

my $increases = 0;

for (my $i = 1; $i < $length; $i = $i + 1){
    if ($lines[$i] > $lines[$i-1]){
        $increases = $increases + 1;
    }
}

print ("Part 1: $increases \n");

# attempt 1 (no thinking)
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

print ("Part 2 (no thinking) $windowIncreases \n");

# attempt 2
$windowIncreases = 0;
for (my $i = 3; $i < $length; $i = $i + 1){
    my $first = $lines[$i-3] + $lines[$i-2] + $lines[$i-1];
    my $second = $lines[$i-2] + $lines[$i-1] + $lines[$i];
    if ($second > $first){
        $windowIncreases = $windowIncreases + 1;
    }
}

print ("Part 2 (thinking) $windowIncreases \n");