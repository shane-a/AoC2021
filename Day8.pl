#!/usr/bin/perl

use strict;
use warnings;

use List::MoreUtils qw ( distinct );
use Array::Utils qw ( intersect array_minus );
use Utils;

my @lines = readFile($0=~s/pl/txt/r); #no more forgetting to change to the correct days input file

PART1: {
    my @parsed = map { my @outs; @outs = $_ =~ /^.*? \| (\w+) (\w+) (\w+) (\w+)/; \@outs } @lines;
    my @flat = map { @$_ } @parsed;

    my @lengths = map {length $_} @flat;
    my @matches = grep {$_ ~~ [2, 3, 4, 7]} @lengths;
    my $numMatch = @matches;

    print "Part 1: $numMatch \n";
}

PART2: {
    my @parsed = map { my @outs; @outs = $_ =~ /(\w+)/g; \@outs } @lines;
    my $ans = 0;
    # my @output = map { my @outs; @outs = splice(@{$_}, 10, 4); \@outs } @parsed;

    foreach my $lineRef (@parsed){
        my @lineArr = @{$lineRef};
        my %config;
        my @strByLen = ((), (), (), (), (), (), (), ());
        foreach my $item (@lineArr){
            $item = join ('', sort(split(//, $item)));
            my $length = length $item;
            push (@{$strByLen[$length]}, $item);
        }
        $config{$strByLen[2][0]} = 1;
        $config{$strByLen[3][0]} = 7;
        $config{$strByLen[4][0]} = 4;
        $config{$strByLen[7][0]} = 8;

        #4 intersect 9 should equal 4
        my @fourSplit = split(//, $strByLen[4][0]);
        foreach my $possible (@{$strByLen[6]}){
            my @possibleSplit = split(//, $possible);
            
            my @intersect = intersect(@possibleSplit, @fourSplit);
            if (scalar @fourSplit == scalar @intersect){
                $config{$possible} = "9";
                my @possibleArr = ($possible);
                my @remaining = array_minus(@{$strByLen[6]}, @possibleArr); 
                $strByLen[6] = \@remaining;
            }
        }

        #7 intersect 0 should equal 7 (assuming 9 is gone)
        my @sevenSplit = split(//, $strByLen[3][0]);
        foreach my $possible (@{$strByLen[6]}){
            my @possibleSplit = split(//, $possible);
            
            my @intersect = intersect(@possibleSplit, @sevenSplit);
            if (scalar @sevenSplit == scalar @intersect){
                $config{$possible} = "0";
                my @possibleArr = ($possible);
                my @remaining = array_minus(@{$strByLen[6]}, @possibleArr);
                $strByLen[6] = \@remaining;
            }
        }

        # shouldn't be any other 6 length items
        $config{$strByLen[6][0]} = "6";
        # we'll use this for 5
        my @sixSplit = split(//, $strByLen[6][0]);

        #1 intersect 3 should equal 1
        my @oneSplit = split(//, $strByLen[2][0]);
        foreach my $possible (@{$strByLen[5]}){
            my @possibleSplit = split(//, $possible);
            
            my @intersect = intersect(@possibleSplit, @oneSplit);
            if (scalar @oneSplit == scalar @intersect){
                $config{$possible} = "3";
                my @possibleArr = ($possible);
                my @remaining = array_minus(@{$strByLen[5]}, @possibleArr); 
                $strByLen[5] = \@remaining;
                last;
            }
        }

        # 5 intersect 6 should equal 5
        foreach my $possible(@{$strByLen[5]}){
            my @possibleSplit = split(//, $possible);

            my @intersect = intersect(@possibleSplit, @sixSplit);
            # this one is backwards, 5 and 2 are left, 2 intersect 6 does not give us 2
            # but 5 intersect 6 gives 5
            if (scalar @possibleSplit == scalar @intersect){
                $config{$possible} = "5";
                my @possibleArr = ($possible);
                my @remaining = array_minus(@{$strByLen[5]}, @possibleArr);
                $strByLen[5] = \@remaining;
                last;
            }
        }

        $config{$strByLen[5][0]} = "2";

        my $lineAns = getValue($lineArr[10], \%config) . getValue($lineArr[11], \%config) . getValue($lineArr[12], \%config) . getValue($lineArr[13], \%config);
        $ans = $ans + int($lineAns);
# exit;
        
    }

    print ("Part 2: $ans\n");
    exit;
}


sub getValue{
    
    my $item = shift @_;
    my %config = %{$_[0]};

    $item = join ('', sort(split(//, $item)));
    
    my $value = $config{$item};

    return $value;
}