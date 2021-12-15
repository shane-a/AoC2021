#!/usr/bin/perl

use strict;
use warnings;

use Utils;

my @lines = readFile($0=~s/pl/txt/r); #no more forgetting to change to the correct days input file

my @heights =  map { my @outs; @outs = split(//, $_); \@outs } @lines;
my $arrLen = scalar(@heights);
my $arrWid = scalar(@{$heights[0]});

PART1: {
    my $risk = 0;

    for (my $i = 0; $i<$arrLen; $i++){
        for (my $j = 0; $j<$arrWid; $j++){
            my $up = $heights[$i-1 >= 0 ? $i-1 : 1000][$j] // 9;
            my $down = $heights[$i+1][$j] // 9;
            my $left = $heights[$i][$j-1 >= 0 ? $j-1 : 1000] // 9;
            my $right = $heights[$i][$j+1] // 9;

            my $curval = $heights[$i][$j];
            
            if ($curval < $up && $curval < $down && $curval < $left && $curval < $right){
                
                $risk = $risk + ($curval + 1);
            }
        }
    }
    print("Part 1: $risk\n");
}

PART2: {
    my @basinSizes = ();

    for (my $i = 0; $i<$arrLen; $i++){
        for (my $j = 0; $j<$arrWid; $j++){

            my $basinSize = findBasin($i, $j, \@heights);
            if ($basinSize > 0){
                push (@basinSizes, $basinSize);
            }
        }
    }

    @basinSizes = sort { $b <=> $a } @basinSizes;

    my $part2 = $basinSizes[0] * $basinSizes[1] * $basinSizes[2];

    

    print("Part 2: $part2\n");

    sub findBasin{
        my $currX = shift(@_);
        my $currY = shift(@_);
        my @map = @{shift(@_)}; #expect array as ref

        if ($currX < 0) { $currX = 1000000; }
        if ($currY < 0) { $currY = 1000000; }

        my $val = $map[$currX][$currY] // 9;

        if (($map[$currX][$currY] // 9) == 9){
            return 0;
        }

        $map[$currX][$currY] = 9;

        return 1 + findBasin($currX + 1, $currY, \@map) + findBasin($currX, $currY + 1, \@map) + findBasin($currX - 1, $currY, \@map) + findBasin($currX, $currY - 1, \@map);
    }
}