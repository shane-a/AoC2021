#!/usr/bin/perl

use strict;
use warnings;

use List::Util qw/sum/;
use Utils;

my @lines = readFile($0=~s/pl/txt/r); #no more forgetting to change to the correct days input file

PART1: {
    my @crabPos = $lines[0]=~ /(\d+)/g;
    @crabPos = sort {$a <=> $b} @crabPos;
    my $length = @crabPos;
    my $median = $crabPos[$length/2];

    my @fuel = map { abs($_ - $median) } @crabPos;
    my $totalFuel = sum(@fuel);

    print "Part 1: $totalFuel \n";
}

PART2: {
    my @crabPos = $lines[0]=~ /(\d+)/g;
    my $length = @crabPos;
    my $sum = sum(@crabPos);
    my $mean = int($sum/$length);

    my @fuel = map { sum(0..abs($_ - $mean)) } @crabPos;
    my $totalFuel = sum(@fuel);

    print "Part 2: $totalFuel \n";
}