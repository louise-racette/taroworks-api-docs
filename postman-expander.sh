#!/bin/bash
current=0
while IFS= read -r line; do
    #echo "Text read from file: $line"
    if echo $line | grep "{{url}}/" 
    then
        current=$((current+1))
        old='{{url}}/'
        new="{{url}}/rm-${current}-rm/"
        echo $line | sed "s|$old|$new|" >> new-postman.json
        else
        echo $line >> new-postman.json
    fi
done < postman-temp.json