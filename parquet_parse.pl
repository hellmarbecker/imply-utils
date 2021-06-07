#!/usr/bin/perl

use strict;
use warnings;
use Data::Dumper;

# read output from parquet-tools (py) and generate a usable dimension spec

my %TYPES = (
    BYTE_ARRAY => "string",
    DOUBLE     => "double",
    INT32      => "long"
);

my $numColumns = 0;
my @columns;
my $currentColumn; # hashref

while (<>) {
    
    if (/#{12}\s+Column\(([^\)]*)\)/) {
        $currentColumn = {};
        push @columns, $currentColumn;
        ++$numColumns;
    } elsif (/^([^:]+):\s*(.*?$)/) {
        my ($k, $v) = ($1, $2);
        ($k =~ /path/) and $currentColumn->{name} = $v;
        ($k =~ /physical_type/) and $currentColumn->{type} = $TYPES{$v};
    }
}

print Dumper \@columns;
