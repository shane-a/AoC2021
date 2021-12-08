#!/usr/bin/perl

use strict;
use warnings;

use List::MoreUtils qw(pairwise);
use Utils;

my @lines = readFile($0=~s/pl/txt/r); #no more forgetting to change to the correct days input file
PART1: {
    my %danger;
    foreach my $line (@lines){
        my ($x1, $y1, $x2, $y2) = $line =~/(\d+),(\d+) -> (\d+),(\d+)/;
        if ($x1 != $x2 && $y1 != $y2) { next; }
        my @keys;
        if ($x1 == $x2){
            my @sortedY = sort { $a <=> $b } ($y1, $y2);
            my @range = ($sortedY[0]..$sortedY[1]);
            @keys = map { $x1.",".$_} @range;
        }
        elsif ($y1 == $y2){
            my @sortedX = sort { $a <=> $b } ($x1, $x2);
            my @range = ($sortedX[0]..$sortedX[1]);
            @keys = map { $_.",".$y1} @range;
        }

        foreach my $key (@keys){
            if (!(defined $danger{$key})){
                $danger{$key} = 0;
            }
            $danger{$key}++;
        }
    }

    my $count = 0;
    foreach my $value (values %danger){
        if ($value > 1) {
            $count++;
        }
    }

    print "Part 1: $count \n";
}

PART2: {
    my %danger;
    foreach my $line (@lines){
        my ($x1, $y1, $x2, $y2) = $line =~/(\d+),(\d+) -> (\d+),(\d+)/;
        my @keys;
        if ($x1 == $x2){
            my @sortedY = sort { $a <=> $b } ($y1, $y2);
            my @range = ($sortedY[0]..$sortedY[1]);
            @keys = map { $x1.",".$_} @range;
        }
        elsif ($y1 == $y2){
            my @sortedX = sort { $a <=> $b } ($x1, $x2);
            my @range = ($sortedX[0]..$sortedX[1]);
            @keys = map { $_.",".$y1} @range;
        }
        else { #blindly assuming that all others are proper diagonals
            my @sortedX = sort { $a <=> $b } ($x1, $x2);
            my @rangeX = ($sortedX[0]..$sortedX[1]);
            my @sortedY = sort { $a <=> $b } ($y1, $y2);
            my @rangeY = ($sortedY[0]..$sortedY[1]);
            if ($x1 > $x2){
                @rangeX = reverse @rangeX;
            }
            if ($y1 > $y2){
                @rangeY = reverse @rangeY;
            }
            @keys = pairwise {$a.",".$b} @rangeX, @rangeY;
        }

        foreach my $key (@keys){
            if (!(defined $danger{$key})){
                $danger{$key} = 0;
            }
            $danger{$key}++;
        }
    }

    my $count = 0;
    foreach my $value (values %danger){
        if ($value > 1) {
            $count++;
        }
    }

    print "Part 2: $count \n";
}
