#!/usr/bin/perl

use strict;
use warnings;
use List::Util qw(reduce);
use List::MoreUtils qw(pairwise);


use Utils;

my @lines = readFile($0=~s/pl/txt/r); #no more forgetting to change to the correct days input file

sub calcSumForCol {
    my $colSums = 0;
    my $i = shift @_;
    
    my @lines = @_;
    foreach (@lines){
        my $input = $_;
        my $char = substr($input, $i, 1);
        if ($char eq '1' || $char eq '0'){
            $colSums= $colSums + $char;
        }
    }

    return $colSums;
}

# part 1 - first run through
{
    my $length = @lines;
    my $width = length $lines[0]=~s/[^01]//r;
    my @colSums = (0) x $width;

    for (my $i = 0; $i < $width; $i = $i + 1){
        $colSums[$i] = calcSumForCol($i, @lines);
    }

    my $gamma = 0;
    my $epsilon = 0;
    for (my $i = 0; $i < $width; $i = $i + 1){
        my $colSum = $colSums[$i];
        $gamma = $gamma << 1;
        $epsilon = $epsilon << 1;
        if ($colSums[$i] > ($length / 2)) {
            $gamma = ($gamma | 1);
        } else {
            $epsilon = ($epsilon | 1);
        }
    }

    print ("Part 1: " . $gamma * $epsilon . "\n");
}
# end part 1 - first run through

# part 1 - round 2

{
    my $length = @lines;
    my $width = length $lines[0]=~s/[^01]//r;
    my @colSums = (0) x $width;

    foreach (@lines){
        my @charArray = split(//, $_=~s/[^01]//r);
        @colSums = pairwise { $a + $b } @colSums, @charArray;
    }

    my $gamma = oct('0b' . join('',map { $_ > ($length / 2) ? '1' : '0' } @colSums));
    my $epsilon = 0x0fff ^ $gamma;
    
    print ("Part 1 rework: " . $gamma * $epsilon . "\n");
}

# end part 1 - round 2


# part 2 - round 1
{
    my $length = @lines;
    my $width = length $lines[0]=~s/[^01]//r;
    my $numResults = $length;
    my $regexLen = 0;
    my @newArr = @lines;
    my $ox = "^";
    while ($numResults > 1 && $regexLen < $width){
        my $currLen = @newArr;
        
        my $colSum = calcSumForCol($regexLen, @newArr);

        if ($colSum >= ($currLen / 2)){
            $ox = $ox . "1";
        } else {
            $ox = $ox . "0";
        }

        @newArr = grep {/$ox/} @newArr;
        $numResults = @newArr;
        $regexLen = $regexLen + 1;
    }

    my $oxVal = oct("0b" . $newArr[0]=~s/[^01]//r);

    $numResults = $length;
    $regexLen = 0;
    @newArr = @lines;
    my $co = "^";
    while ($numResults > 1 && $regexLen < $width){
        my $currLen = @newArr;
        
        my $colSum = calcSumForCol($regexLen, @newArr);

        if ($colSum >= ($currLen / 2)){
            $co = $co . "0";
        } else {
            $co = $co . "1";
        }

        @newArr = grep {/$co/} @newArr;
        $numResults = @newArr;
        $regexLen = $regexLen + 1;
    }

    my $coVal = oct("0b" . $newArr[0]=~s/[^01]//r);

    print ("Part 2: " . $oxVal * $coVal);
    print ("\n");
}
# end part 2 - round 1

# part 2 - round 2
{
    sub recurseFilter {
        my $str = shift @_;
        my $filterNum = shift @_;
        my $arrayLen = @_;

        if ($arrayLen == 1) { return @_[0]; }
        my $currLen = length $str;
        
        my $colSum = calcSumForCol($currLen, @_);

        if ($colSum >= ($arrayLen / 2)) { 
            $str = $str . "$filterNum"; 
            }
        else { 
            $str = $str . ($filterNum ^ 1) ;
        }

        my @newList = grep {/^$str/} @_;

        return recurseFilter($str, $filterNum, @newList);
    }

    my $o2Val = recurseFilter ("", 1, @lines);
    my $co2Val = recurseFilter ("", 0, @lines);

    print ("Part 2 rework: " . (oct("0b".$o2Val=~s/[^01]//r) * oct("0b".$co2Val=~s/[^01]//r)) . "\n");
}
# end part 2 - round 2
exit;