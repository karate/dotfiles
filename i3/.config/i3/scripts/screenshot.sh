#!/usr/bin/env bash

# Check is maim exist
if ! which maim &> /dev/null; then
  echo "maim not found"
  exit 1;
fi

FILENAME=/tmp/$(date '+%Y-%m-%d--%H-%M-%S').png;
# Take screenshot
maim -suo $FILENAME
# Copy file path to clipboard
echo $FILENAME | xclip -sel clip;
# Open file
feh $FILENAME
