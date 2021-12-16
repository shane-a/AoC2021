#!/usr/bin/perl

use strict;
use warnings;

use Utils;

my @lines = readFile($0=~s/pl/txt/r); #no more forgetting to change to the correct days input file
my @octos =  map { my @outs; @outs = split(//, $_); \@outs } @lines;
my $length = scalar @lines; #assuming square

PART1AND2 :{
    my $flashes = 0;
    my $allFlashNum;
    my $runNo = 1;
    while(!defined($allFlashNum)) {
        # energy increase
        for (my $i = 0; $i < $length; $i++){
            for (my $j = 0; $j < $length; $j++){
                if ($octos[$i][$j] == 9) { $octos[$i][$j] = 'X'; }
                else { $octos[$i][$j] = $octos[$i][$j] + 1; }
            }
        }

        # light flash
        for (my $i = 0; $i < $length; $i++){
            for (my $j = 0; $j < $length; $j++){
                if ($octos[$i][$j] eq 'X') {
                    increaseSurrounding($i, $j, \@octos);
                }
                
            }
        }

        #reset
        my $allFlash = 1;
        for (my $i = 0; $i < $length; $i++){
            for (my $j = 0; $j < $length; $j++){
                if ($octos[$i][$j] eq '#') { 
                    $octos[$i][$j] = '0'; 
                    if ($runNo <= 100){
                        $flashes++;
                    }
                    
                }
                else{
                    $allFlash = 0;
                }
            }
        }
        if ($allFlash && !defined($allFlashNum)){
            $allFlashNum = $runNo;
        }
        $runNo++;
    }

    print "Part 1: $flashes\n";
    print "Part 2: $allFlashNum\n";

    sub increaseSurrounding{
        my $i = shift(@_);
        my $j = shift(@_);
        my @octos = @{shift @_};

        my $val = $octos[$i][$j];
        if ($val eq 'X') { $octos[$i][$j] = '#'; }
        elsif ($val eq '#') { return; }

        my $iLessOne = $i > 0 ? $i - 1: 1000000; #hack to allow indexing but getting undefined
        my $jLessOne = $j > 0 ? $j - 1: 1000000; #hack to allow indexing but getting undefined

        my $iIdx = $iLessOne;
        my $jIdx = $jLessOne;

        #idx = i-1,j-1
        if (!defined($octos[$iIdx][$jIdx]) || $octos[$iIdx][$jIdx] eq 'X' || $octos[$iIdx][$jIdx] eq '#') { }
        elsif ($octos[$iIdx][$jIdx] == 9) { 
            $octos[$iIdx][$jIdx] = 'X';
            increaseSurrounding($iIdx, $jIdx, \@octos);
        }
        elsif ($octos[$iIdx][$jIdx] ~~ [0,1,2,3,4,5,6,7,8]){
            $octos[$iIdx][$jIdx] = $octos[$iIdx][$jIdx] + 1;
        }

        #idx = i-1, j
        $jIdx = $j;
        if (!defined($octos[$iIdx][$jIdx]) || $octos[$iIdx][$jIdx] eq 'X' || $octos[$iIdx][$jIdx] eq '#') { }
        elsif ($octos[$iIdx][$jIdx] == 9) { 
            $octos[$iIdx][$jIdx] = 'X';
            increaseSurrounding($iIdx, $jIdx, \@octos);
        }
        elsif ($octos[$iIdx][$jIdx] ~~ [0,1,2,3,4,5,6,7,8]){
            $octos[$iIdx][$jIdx] = $octos[$iIdx][$jIdx] + 1;
        }

        #idx = i-1, j+1
        $jIdx = $j + 1;
        if (!defined($octos[$iIdx][$jIdx]) || $octos[$iIdx][$jIdx] eq 'X' || $octos[$iIdx][$jIdx] eq '#') { }
        elsif ($octos[$iIdx][$jIdx] == 9) { 
            $octos[$iIdx][$jIdx] = 'X';
            increaseSurrounding($iIdx, $jIdx, \@octos);
        }
        elsif ($octos[$iIdx][$jIdx] ~~ [0,1,2,3,4,5,6,7,8]){
            $octos[$iIdx][$jIdx] = $octos[$iIdx][$jIdx] + 1;
        }

        #idx = i,j-1
        $iIdx = $i;
        $jIdx = $jLessOne;
        if (!defined($octos[$iIdx][$jIdx]) || $octos[$iIdx][$jIdx] eq 'X' || $octos[$iIdx][$jIdx] eq '#') { }
        elsif ($octos[$iIdx][$jIdx] == 9) { 
            $octos[$iIdx][$jIdx] = 'X';
            increaseSurrounding($iIdx, $jIdx, \@octos);
        }
        elsif ($octos[$iIdx][$jIdx] ~~ [0,1,2,3,4,5,6,7,8]){
            $octos[$iIdx][$jIdx] = $octos[$iIdx][$jIdx] + 1;
        }

        #idx = i,j # skip
        
        #idx = i, j+1
        $jIdx = $j + 1;
        if (!defined($octos[$iIdx][$jIdx]) || $octos[$iIdx][$jIdx] eq 'X' || $octos[$iIdx][$jIdx] eq '#') { }
        elsif ($octos[$iIdx][$jIdx] == 9) { 
            $octos[$iIdx][$jIdx] = 'X';
            increaseSurrounding($iIdx, $jIdx, \@octos);
        }
        elsif ($octos[$iIdx][$jIdx] ~~ [0,1,2,3,4,5,6,7,8]){
            $octos[$iIdx][$jIdx] = $octos[$iIdx][$jIdx] + 1;
        }


        #idx = i+1,j-1
        $iIdx = $i +1;
        $jIdx = $jLessOne;
        if (!defined($octos[$iIdx][$jIdx]) || $octos[$iIdx][$jIdx] eq 'X' || $octos[$iIdx][$jIdx] eq '#') { }
        elsif ($octos[$iIdx][$jIdx] == 9) { 
            $octos[$iIdx][$jIdx] = 'X';
            increaseSurrounding($iIdx, $jIdx, \@octos);
        }
        elsif ($octos[$iIdx][$jIdx] ~~ [0,1,2,3,4,5,6,7,8]){
            $octos[$iIdx][$jIdx] = $octos[$iIdx][$jIdx] + 1;
        }

        #idx = i+1, j
        $jIdx = $j;
        if (!defined($octos[$iIdx][$jIdx]) || $octos[$iIdx][$jIdx] eq 'X' || $octos[$iIdx][$jIdx] eq '#') { }
        elsif ($octos[$iIdx][$jIdx] == 9) { 
            $octos[$iIdx][$jIdx] = 'X';
            increaseSurrounding($iIdx, $jIdx, \@octos);
        }
        elsif ($octos[$iIdx][$jIdx] ~~ [0,1,2,3,4,5,6,7,8]){
            $octos[$iIdx][$jIdx] = $octos[$iIdx][$jIdx] + 1;
        }

        #idx = i+1, j+1
        $jIdx = $j + 1;
        if (!defined($octos[$iIdx][$jIdx]) || $octos[$iIdx][$jIdx] eq 'X' || $octos[$iIdx][$jIdx] eq '#') { }
        elsif ($octos[$iIdx][$jIdx] == 9) { 
            $octos[$iIdx][$jIdx] = 'X';
            increaseSurrounding($iIdx, $jIdx, \@octos);
        }
        elsif ($octos[$iIdx][$jIdx] ~~ [0,1,2,3,4,5,6,7,8]){
            $octos[$iIdx][$jIdx] = $octos[$iIdx][$jIdx] + 1;
        }
    }
}