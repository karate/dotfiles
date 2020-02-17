#!/usr/bin/env bash

# https://www.reddit.com/r/unixporn/comments/3358vu/i3lock_unixpornworthy_lock_screen/
temp_file="/tmp/screen.png"
icon="$HOME/.config/i3/scripts/rick-lock.png"
# This assumes all displays have 1920x1080 resolution, and are positioned sibe-by-side
monitor_count=$(xrandr | grep " connected" | wc -l)
width=$(echo "1920*${monitor_count}" | bc)
height=1080
# Use either 'pixel' or 'blur'
effect='pixel'

blur_factor=9
pixel_size=10

if [[ "$effect" == "pixel" ]]; then
  filter="[0:v] scale='iw/10:-1', scale='$width:$height:flags=neighbor', overlay=(main_w/2-overlay_w)/2:(main_h-overlay_h)/2"
elif [[ "$effect" == "blur"  ]]; then
  filter="boxblur=$blur_factor:$blur_factor,overlay=(main_w/2-overlay_w)/2:(main_h-overlay_h)/2"
fi

# Turn off monitor after 10 minutes
xset dpms 0 600 600

# https://www.reddit.com/r/unixporn/comments/4yj29e/i3lock_simple_blur_script/
ffmpeg -f x11grab -y \
  -video_size "${width}x${height}" \
  -i $DISPLAY \
  -i $icon \
  -filter_complex "$filter" \
  -vframes 1 \
  $temp_file

# BLUR
# -filter_complex  \
# PIXELATE
# -filter_complex "boxblur=$blur_factor:$blur_factor,overlay=(main_w/2-overlay_w)/2:(main_h-overlay_h)/2" \
i3lock --ignore-empty-password --no-unlock-indicator --image=$temp_file

# Revert
xset dpms 0 0 0
rm $temp_file
