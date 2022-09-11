#!/usr/bin/perl
# create data sets for groupby join pushdown test

use v5.10;
use strict;
use warnings;

use Getopt::Std;
use DateTime;

my @brands = qw( AMOK GEMLR GLDRL LCKYJ MTGLD RFLCN SPNRO UNLMT );

my $start = DateTime->new(
    day   => 1,
    month => 1,
    year  => 2022,
);

my $stop = DateTime->new(
    day   => 1,
    month => 9,
    year  => 2022,
);

my $usage = "usage: $0 -m <measureName>";
my %opts;
getopts('m:', \%opts);
my $measureName = $opts{m} or die $usage;

say "ts,brand,$measureName";

for ( my $d = $start->clone; $d < $stop; $d->add(days => 1) ) {

    for my $brand(@brands) {
        my $measure = int(rand(1000));
        say "$d,$brand,$measure";
    }
}

