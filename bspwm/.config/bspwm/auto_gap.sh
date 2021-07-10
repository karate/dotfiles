#!/usr/bin/env sh
bspc subscribe node_add node_remove node_state node_transfer desktop_focus | while read line; do 
  WINDOWS=$(bspc query --desktop focused --nodes --node .!floating.!fullscreen | wc -l);
  LOCKED=
  GAP=$(echo "-3 * $WINDOWS + 25" | bc)
  if [ "$GAP" -lt "0" ]; then
    GAP=0
  fi;
  bspc config window_gap $GAP
done
