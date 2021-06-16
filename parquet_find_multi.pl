#!/usr/bin/perl

use strict;
use warnings;
use Data::Dumper;
use JSON;

# find those fields that have a nontrivial definition/repetition level

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
            $currentColumnDim->{origName} = $v;

        } elsif ($k =~ /physical_type/) {

            $currentColumnDim->{type} = $TYPES{$v};

        } elsif ($k =~ /max_definition_level/) {

            $currentColumnDim->{max_definition_level} = $v;

        } elsif ($k =~ /max_repetition_level/) {

            $currentColumnDim->{max_repetition_level} = $v;

        }
    }
}

for my $dim (@columnsDim) {

    if ($dim->{max_definition_level} > 1) {
        print $dim->{max_definition_level} . " " . $dim->{type} . " " . $dim->{origName} . "\n";
    }
}

