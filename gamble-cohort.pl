#!/usr/bin/perl
# create data set for cohort analysis

use v5.10;
use strict;
use warnings;

use Getopt::Std;
use DateTime;
use Data::Dumper;

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

my $numPlayers = 100000;
my $playerMaxAge = 730;
my $minEventsPerDay = 300;
my $maxEventsPerDay = 1000;
my $maxDeposit = 50;

my @players;
my @playerSignup;

my $today = DateTime->today;

# initialize players and signup dates

for my $i (0 .. $numPlayers-1 ) {
    my $playerID = "p" . sprintf("%05d", $i);
    $players[$i] = $playerID;
    my $playerAgeNow = int(rand($playerMaxAge));
    my $signupDate = $today - DateTime::Duration->new(days => $playerAgeNow);
    $playerSignup[$i] = $signupDate;
    # say "$playerID $signupDate $playerAgeNow";
}

say "curdate,playerid,signupdate,deposit";

for ( my $d = $start->clone; $d < $stop; $d->add(days => 1) ) {
    my $n = 0;
    my $numEventsMax = $minEventsPerDay + int(rand($maxEventsPerDay - $minEventsPerDay));
    while ($n < $numEventsMax) {
        my $ind = int(rand($numPlayers));
        my $playerID = $players[$ind];
        # my $playerAge = ($d - $playerSignup[$ind])->days;
        next if ( $playerSignup[$ind] > $d ); # player did not exist yet
        my $playerAge = $d->delta_days($playerSignup[$ind])->in_units('days');
        my $cooldown = exp(-3.0 * $playerAge / $playerMaxAge);
        next if ( rand(1.0) > $cooldown ); # simulate that players churn off slowly
        # say "$d $n $ind $playerID $playerSignup[$ind] $playerAge $cooldown";
        my $deposit = sprintf("%.2f", rand($maxDeposit));
        say "$d,$playerID,$playerSignup[$ind],$deposit";
        ++$n;
    }
}

