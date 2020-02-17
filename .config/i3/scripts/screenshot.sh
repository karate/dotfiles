#!/usr/bin/env bash

# Check is scrot exist
if ! which scrot &> /dev/null; then
  echo "scrot not found"
  exit 1;
fi

# Use dmenu to get user selection
SEL=$(echo -e "1: Select window or rectange\n2: Whole Screen" | dmenu -l 10)

# Select region or window.
# User should either click on a window, or drag a rectange on the screen
if [[ $SEL == 1:* ]]; then
  OPTIONS='-s'
# Grab all monitors
elif [[ $SEL = 2:* ]]; then
  OPTIONS=''
else
  exit 1
fi;

# Take screenshot, save in `/tmp` and copy file path in system clipboad
scrot '/tmp/%Y-%m-%d--%H-%M-%S--$wx$h-scrot.png' $OPTIONS -e 'echo "$f" | xclip -sel clip; feh $f'
