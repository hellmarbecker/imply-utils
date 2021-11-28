#!/bin/bash

# path settings for default quickstart install

DRUID_HOME="/Users/hellmarbecker/apache-druid-0.22.0"
DRUID_DATADIR="${DRUID_HOME}/var/druid/segments"
DRUID_DATASOURCE="wikipedia"
DUMP_TMPDIR=~/tmpwork

java -classpath "${DRUID_HOME}/lib/*" -Ddruid.extensions.loadList="[]" org.apache.druid.cli.Main \
tools dump-segment \
  --directory /Users/hellmarbecker/tmpwork \
  --out ~/tmpwork/output.txt
