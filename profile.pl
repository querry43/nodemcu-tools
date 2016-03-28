#!/usr/bin/perl

use strict;
use warnings;
use autodie;
use Data::Dumper;

sub pp {
    my ($time, $level, $name) = @_;
    printf("%0.3fs - %s %s\n", $time/1000000, ' ' x $level, $name);
}

my %enclosures;
my $level = 0;
my $start;
while (<>) {
    chomp;
    my @parts = split(/:/);

    next unless @parts;

    if ($parts[0] eq 'BEGIN') {
        $start //= $parts[2];
        $enclosures{$parts[1]} = $parts[2];
        pp($parts[2]-$start, $level, '>> ' . $parts[1]);
        $level++;
    } elsif ($parts[0] eq 'END') {
        $level--;
        pp($parts[2]-$start, $level, '<< ' . $parts[1]);
    } elsif ($parts[1] && $parts[1] =~ m/^[0-9]+$/) {
        pp($parts[1]-$start, $level, '   ' . $parts[0]);
    }
}
