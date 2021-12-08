#!/usr/bin/perl

use strict;
use warnings;

use List::Util qw/sum/;
use Utils;

my @lines = readFile($0=~s/pl/txt/r); #no more forgetting to change to the correct days input file

#should only be one....
PART1: {
    my @fishies = $lines[0]=~ /(\d)/g;

    for (my $i = 0; $i < 80; $i++){
        my $currLen = @fishies;
        # print join(',', @fishies), "\n";
        for (my $f = 0; $f < $currLen; $f++) {
            if ($fishies[$f] == 0){
                push(@fishies, 8);
                $fishies[$f] = 6;
            }
            else{
                $fishies[$f]--;
            }
        }
    }

    my $length = @fishies;
    print "Part 1: $length \n";
}

PART2: {
    #needed some help from the spoiler thread
    my @fishies = $lines[0]=~ /(\d)/g;

    my @fishyDays = (0) x 9;
    foreach my $fishy (@fishies){
        $fishyDays[$fishy]++;
    }

    for (my $i = 0; $i < 256; $i++){
        my ($d0, $d1, $d2, $d3, $d4, $d5, $d6, $d7, $d8) =  @fishyDays;
        my $newFishies = $d0;
        $fishyDays[0] = $d1;
        $fishyDays[1] = $d2;
        $fishyDays[2] = $d3;
        $fishyDays[3] = $d4;
        $fishyDays[4] = $d5;
        $fishyDays[5] = $d6;
        $fishyDays[6] = $d7 + $newFishies;
        $fishyDays[7] = $d8;
        $fishyDays[8] = $newFishies;
    }

    my $numFishies = sum(@fishyDays);

    print "Part 2: $numFishies \n";
}