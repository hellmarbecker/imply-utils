#!/bin/bash

DRUID_HOME="/Users/hellmarbecker/apache-druid-0.22.0"

java -classpath "${DRUID_HOME}/lib/*" -Ddruid.extensions.loadList="[]" org.apache.druid.cli.Main \
tools dump-segment \
  --directory /Users/hellmarbecker/tmpwork \
  --out ~/tmpwork/output.txt
