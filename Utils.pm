package Utils;

use strict;
use warnings;

use Exporter 5.57 'import';

our $VERSION = '1.00';
our @EXPORT = qw(readFile);

sub readFile {
    my $n = scalar(@_);
    if (!$n) { 
        print("No params\n");
        return; 
    }
    else {
        open my $handle, '<', $_[0];
        chomp(my @lines = <$handle>);
        close $handle;

        return @lines;
    }
}

1;