#!/usr/bin/perl

use strict;
use warnings;

use Utils;

my @lines = readFile($0=~s/pl/txt/r); #no more forgetting to change to the correct days input file
my $length = @lines;

my $depth = 0;
my $horiz = 0;

foreach (@lines){
    my @parts = split(/ /);
    if ($parts[0] eq "forward") { $horiz = $horiz + $parts[1]; }
    elsif ($parts[0] eq "up") { $depth = $depth - $parts[1]; }
    elsif ($parts[0] eq "down") { $depth = $depth + $parts[1]; }
}

print("Part 1: " . $depth * $horiz . "\n");

my $aim = 0;
$depth = 0;
$horiz = 0;

foreach (@lines){
    my @parts = split(/ /);
    if ($parts[0] eq "forward") { 
        $horiz = $horiz + $parts[1]; 
        $depth = $depth + ($aim * $parts[1]);
    }
    elsif ($parts[0] eq "up") { $aim = $aim - $parts[1]; }
    elsif ($parts[0] eq "down") { $aim = $aim + $parts[1]; }
}

print("Part 2: " . $depth * $horiz . "\n");