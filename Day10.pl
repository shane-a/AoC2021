#!/usr/bin/perl

use strict;
use warnings;

use Utils;

my @lines = readFile($0=~s/pl/txt/r); #no more forgetting to change to the correct days input file

PART1: {
    my @errorChars = ();
    foreach my $line (@lines){
        my @stack = ();
        my @chars = split(//, $line);
        foreach my $char (@chars){
            if ($char ~~ ['(', '[', '{', '<']){
                push @stack, $char;
            }
            else{
                my $popChar = pop @stack;
                if ($char eq ')' && $popChar ne '('){
                    push (@errorChars, $char);
                    last;
                }
                if ($char eq ']' && $popChar ne '['){
                    push (@errorChars, $char);
                    last;
                }
                if ($char eq '}' && $popChar ne '{'){
                    push (@errorChars, $char);
                    last;
                }
                if ($char eq '>' && $popChar ne '<'){
                    push (@errorChars, $char);
                    last;
                }
            }
        }
    }

    my $errorScore = 0;
    foreach my $char (@errorChars){
        if ($char eq ')') { $errorScore = $errorScore + 3; }
        elsif ($char eq ']') { $errorScore = $errorScore + 57; }
        elsif ($char eq '}') { $errorScore = $errorScore + 1197; }
        elsif ($char eq '>') { $errorScore = $errorScore + 25137; }
    }

    print "Part1: $errorScore\n";
}

PART2: {
    my @autoComplete = ();
    LINE: foreach my $line (@lines){ 
        my @stack = ();
        my @chars = split(//, $line);
        foreach my $char (@chars){
            if ($char ~~ ['(', '[', '{', '<']){
                push @stack, $char;
            }
            else{
                my $popChar = pop @stack;
                if ($char eq ')' && $popChar ne '('){
                    next LINE;
                }
                if ($char eq ']' && $popChar ne '['){
                    next LINE;
                }
                if ($char eq '}' && $popChar ne '{'){
                    next LINE;
                }
                if ($char eq '>' && $popChar ne '<'){
                    next LINE;
                }
            }
        }
        #process stack
        my $fixScore = 0;
        foreach my $unfinished (reverse @stack){
            if ($unfinished eq '(') {$fixScore = ($fixScore * 5) + 1; }
            if ($unfinished eq '[') {$fixScore = ($fixScore * 5) + 2; }
            if ($unfinished eq '{') {$fixScore = ($fixScore * 5) + 3; }
            if ($unfinished eq '<') {$fixScore = ($fixScore * 5) + 4; }
        }

        push (@autoComplete, $fixScore);
    }

    @autoComplete = sort { $a <=> $b } @autoComplete;
    my $idx = int(scalar @autoComplete / 2);
    my $score = $autoComplete[$idx];

    print "Part 2: $score\n";
}