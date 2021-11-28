#!/bin/bash
java -classpath "/Users/hellmarbecker/apache-druid-0.22.0/lib/*" -Ddruid.extensions.loadList="[]" org.apache.druid.cli.Main \
tools dump-segment \
  --directory /Users/hellmarbecker/tmpwork \
  --out ~/tmpwork/output.txt
