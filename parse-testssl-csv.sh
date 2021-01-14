#!/bin/bash

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
                grep "LOW\|MEDIUM\|HIGH\|CRITICAL" $1 | grep $line | cut -d "," -f 2,3 | cut -d "/" -f 2 | sed 's/"//g;s/,/:/g' | sort -u > SSLParse.log/$of
        fi
done < <(cat $1 | grep "LOW\|MEDIUM\|HIGH\|CRITICAL" | cut -d "," -f 1 | sort -u)
