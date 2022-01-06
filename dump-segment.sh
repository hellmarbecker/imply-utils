#!/bin/bash

# path settings for default quickstart install

DRUID_HOME="${HOME}/apache-druid-0.22.1"
DRUID_DATADIR="${DRUID_HOME}/var/druid/segments"
DRUID_DATASOURCE="wikipedia-dynamic-1"
DUMP_TMPDIR="${HOME}/tmpwork"

FILES=$(cd ${DRUID_DATADIR} && find ${DRUID_DATASOURCE} -type f)

for f in $FILES; do
  FDIR=$(dirname $f)
  FBASE=$(basename $f)
  ODIR=${DUMP_TMPDIR}/$FDIR
  mkdir -p $ODIR
  unzip $f -d $ODIR

  java -classpath "${DRUID_HOME}/lib/*" -Ddruid.extensions.loadList="[]" org.apache.druid.cli.Main \
    tools dump-segment \
    --directory $ODIR \
    --out $ODIR/output.txt
done
