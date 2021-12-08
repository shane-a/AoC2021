#!/usr/bin/perl

use strict;
use warnings;

use Utils;

my $text = readFileAll($0=~s/pl/txt/r); #no more forgetting to change to the correct days input file

my @inputs = split(/\r\n\r\n/, $text);

my $calledNumbersStr = shift @inputs;
my @calledNumbers = split(/,/, $calledNumbersStr);

#@inputs now has just the boards
my @boards = ();
foreach (@inputs){
    my @lines = split(/\r\n/, $_);
    
    my @board = ();
    foreach my $line (@lines){
        my @lineItems = split (/\s+/, $line);
        push (@board, \@lineItems);
    }
    push(@boards, \@board);

}
my $resultOne;
PART1: {


    foreach my $num (@calledNumbers){
        markSpace($num, @boards);
        foreach my $board (@boards){
            if (hasBingo(@{$board})){
                $resultOne = $num * sumUnmarked(@{$board});

                last PART1;
            }
        }
    }
}

print "part one: $resultOne \n";

my $resultTwo = 0;

my $remainingBoards = @boards;
PART2: {
    foreach my $num (@calledNumbers){
        markSpace($num, @boards);
        my $numBoards = @boards;
        for (my $i = $numBoards -1; $i > 0; $i = $i - 1) {
            my $remainingFrArr = @boards;
            my @board = @{$boards[$i]};
            if (hasBingo(@board)){
                my $unMarked = sumUnmarked(@board);
                splice @boards, $i, 1;
                $remainingBoards = @boards;
                $resultTwo = $num * sumUnmarked(@board);
            }
        }
    }
}
print "part two: $resultTwo \n";

sub sumUnmarked {
    my $sum = 0;
    for (my $i = 0; $i<5; $i = $i + 1){
        for (my $j = 0; $j<5; $j = $j + 1){
            if ($_[$i][$j] ne '#' && $_[$i][$j] ne '') { 
                $sum = $sum + $_[$i][$j]; 
            }
        }
    }

    return $sum;
}

sub markSpace {
    my $num = shift @_;
    foreach my $board (@_){
        my @boardArr = @{$board};
        BOARD: {
            for (my $i = 0; $i<5; $i = $i + 1){
                for (my $j = 0; $j<5; $j = $j + 1){
                    if ($boardArr[$i][$j] eq $num) { 
                        $boardArr[$i][$j] = '#'; 
                        last BOARD; 
                    }
                }
            }
        }
    }
    
}

sub hasBingo {
    #expect array of arrays of arrays
    for (my $i = 0; $i<5; $i = $i + 1){
        for (my $j = 0; $j<5; $j = $j + 1){
            if ($_[$i][$j] ne '#') { last; }
            if ($j == 4) { return 1; }
        }
    }
    for (my $i = 0; $i<5; $i = $i + 1){
        for (my $j = 0; $j<5; $j = $j + 1){
            if ($_[$j][$i] ne '#') { last; }
            if ($j == 4) { return 1; }
        }
    }
    
    return 0;
}