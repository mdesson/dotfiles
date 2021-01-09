#!/bin/bash

# Get current keyboard layout
LG=$(setxkbmap -query | awk '/layout/{print $2}')

# Toggle layout
if [ $LG == "us" ]
then
	setxkbmap -layout ca -variant fr
else
	setxkbmap us
fi

# Set capslock to mod4
xmodmap ~/.Xmodmap
