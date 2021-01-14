#!/bin/bash

SEVERITY="LOW\|MEDIUM\|HIGH\|CRITICAL"

if [ -z "$1" ]
then
    echo "parse-testssl-csv.sh <INPUT FILE>"
    exit 1
fi
while IFS= read -r line
do
    if [ ! -d SSLParse.log ]
    then
        mkdir SSLParse.log
    else
        of=${line//\"/}
        grep $SEVERITY $1 | grep $line | cut -d "," -f 2,3 | cut -d "/" -f 2 | sed 's/"//g;s/,/:/g' | sort -u > SSLParse.log/$of
    fi
done < <(cat $1 | grep $SEVERITY | cut -d "," -f 1 | sort -u)
