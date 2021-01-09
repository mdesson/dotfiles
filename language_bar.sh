#!/bin/bash

i3status --config ~/.config/i3status/config | while :
do
    read line
    LG=$(setxkbmap -query | awk '/layout/{print $2}')
    if [ $LG == "us" ]
    then
        dat="[{ \"full_text\": \"Lang: en\", \"color\":\"#FF7600\" },"
    else
        dat="[{ \"full_text\": \"Lang: fr\", \"color\":\"#7AD7F0\" },"
    fi
    echo "${line/[/$dat}" || exit 1
done
