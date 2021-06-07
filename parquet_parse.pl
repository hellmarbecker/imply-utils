#!/usr/bin/perl

use strict;
use warnings;
use Data::Dumper;
use JSON;

# read output from parquet-tools (py) and generate a usable dimension spec

my %TYPES = (
    BYTE_ARRAY => "string",
    DOUBLE     => "double",
    INT32      => "long"
);

my $numColumns = 0;
my @columnsFlatten;
my $currentColumnFlatten; # hashref
my @columnsDim;
my $currentColumnDim; # hashref

while (<>) {
    
    if ( /#{12}\s+Column\(([^\)]*)\)/ ) {

        # Start a new dimension entry
        $currentColumnFlatten = {};
        push @columnsFlatten, $currentColumnFlatten;
        $currentColumnDim = {};
        push @columnsDim, $currentColumnDim;
        ++$numColumns;

    } elsif ( my($k, $v) = /^([^:]+):\s*(.*?$)/ ) {

        if ($k =~ /path/) {

            my $dimName = $v;
            my $nested = $dimName =~ s/\./_/g and $currentColumnFlatten->{expr} = '$.'.$v;
            $currentColumnFlatten->{type} = $nested ? "path" : "root";
            $currentColumnFlatten->{name} = $dimName;
            $currentColumnDim->{name} = $dimName;

        } elsif ($k =~ /physical_type/) {

            $currentColumnDim->{type} = $TYPES{$v};

        }
    }
}

print encode_json(\@columnsFlatten);
