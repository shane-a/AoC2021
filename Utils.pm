package Utils;

use strict;
use warnings;

use Exporter 5.57 'import';

our $VERSION = '1.00';
our @EXPORT = qw(readFile readFileAll);

sub readFile {
    my $n = scalar(@_);
    if (!$n) { 
        print("No params\n");
        return; 
    }
    else {
        local $/ = "\r\n";
        open my $handle, '<', $_[0];
        chomp(my @lines = <$handle>);
        close $handle;

        return @lines;
    }
}

sub readFileAll {
    my $n = scalar(@_);
    if (!$n) { 
        print("No params\n");
        return; 
    }
    else {
        undef $/;
        open my $handle, '<', $_[0];
        my $text = <$handle>;
        close $handle;
        $/ = "\n";

        return $text;
    }
}

1;