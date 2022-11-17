#!/bin/bash

while true; do

    read now < <(date +%s)
    echo '{ "tm": '${now}000', "name": "connection_check", "data": { "field1": "lorem", "field2": "ipsum" } }'
    sleep 2
done

