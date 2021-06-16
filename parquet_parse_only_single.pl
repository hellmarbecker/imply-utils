#!/usr/bin/perl

use strict;
use warnings;
use Data::Dumper;
use JSON;

# read output from parquet-tools (py) and generate a usable dimension spec
# don't keep the crazy level 3 nested things

my %TYPES = (
    BYTE_ARRAY => "string",
    DOUBLE     => "double",
    INT32      => "long"
);

my $numColumns = 0;
my @columnsDim;
my $currentColumnDim; # hashref

while (<>) {
    
    if ( /#{12}\s+Column\(([^\)]*)\)/ ) {

        # Start a new dimension entry
        $currentColumnDim = {};
        ++$numColumns;

    } elsif ( my($k, $v) = /^([^:]+):\s*(.*?$)/ ) {

        if ($k =~ /path/) {

            $currentColumnDim->{name} = $v;

        } elsif ($k =~ /physical_type/) {

            $currentColumnDim->{type} = $TYPES{$v};

        } elsif ($k =~ /max_definition_level/) {

            $v == 1 and push(@columnsDim, $currentColumnDim);

        }
    }
}

my $dimensionSpec = {
    dimensionsSpec => {
        dimensions => \@columnsDim
    }
};

print encode_json($dimensionSpec);
print "\n";
