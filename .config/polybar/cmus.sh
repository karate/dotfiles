#!/bin/bash

prepend_zero () {
    seq -f "%02g" $1 $1
}

artist=$(echo -n $(cmus-remote -C status | grep artist -m 1| cut -c 12-))
song=$(echo -n $(cmus-remote -C status | grep title | cut -c 11-45))

status=$(cmus-remote -C status | grep status | awk '{print $2}')

reset_color="%{F-}"

if [ "$status" == "playing" ]; then
	#status_icon="" 
	color=$reset_color
else
	#status_icon=" "
	color="%{F#666}" 
fi

echo -n "$color $artist - $song $reset_color"

#position=$(cmus-remote -C status | grep position | cut -c 10-)
#if [[ ! -z $position ]]; then
#	minutes1=$(prepend_zero $(($position / 60)))
#	seconds1=$(prepend_zero $(($position % 60)))
#
#	duration=$(cmus-remote -C status | grep duration | cut -c 10-)
#	minutes2=$(prepend_zero $(($duration / 60)))
#	seconds2=$(prepend_zero $(($duration % 60)))
#	
#	echo -n "$artist - $song [$minutes1:$seconds1 / $minutes2:$seconds2]"
#else
#	echo -n "cmus not running...";
#fi
