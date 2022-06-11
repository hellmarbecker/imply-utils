#!/bin/bash

export PULSAR_HOME=$HOME/apache-pulsar-2.10.0
export TOPIC=pulsar-to-druid

while true; do
    ${PULSAR_HOME}/bin/pulsar-client produce kop/kop/pulsar-to-druid -s "\000" \
        -m "{ \"timestamp\": \"$(date -Iseconds)\", \"dim\": \"dim$((1 + RANDOM % 5))\", \"value\": \"$((1 + RANDOM % 100))\" }"
    sleep 1
done

