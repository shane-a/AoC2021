#!/usr/bin/perl

use strict;
use warnings;

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

my $oxVal = oct("0b" . $newArr[0]);

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

my $coVal = oct("0b" . $newArr[0]);

print ("Part 2: " . $oxVal * $coVal);
print ("\n");

exit;