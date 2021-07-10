j!/usr/bin/env bash

# https://www.reddit.com/r/unixporn/comments/3358vu/i3lock_unixpornworthy_lock_screen/
temp_file="/tmp/screen.png"
icon="$HOME/.config/i3/scripts/rick-lock.png"
# This assumes 2 monitors with 1920x1080 resolution, positioned sibe-by-side
monitor_count=$(xrandr | grep " connected" | wc -l)
width=$(echo "1920*${monitor_count}" | bc)
# 1080 + 105px vertical offset
height=1185
blur_factor=6

# Turn off monitor after 5 minuter
xset +dpms dpms 0 0 1

# https://www.reddit.com/r/unixporn/comments/4yj29e/i3lock_simple_blur_script/
ffmpeg -f x11grab -y \
  -video_size "${width}x${height}" \
  -i $DISPLAY \
  -i $icon \
  -filter_complex "boxblur=$blur_factor:$blur_factor,overlay=(main_w/2-overlay_w)/2:(main_h-overlay_h)/2" \
  -vframes 1 \
  $temp_file

i3lock --ignore-empty-password --no-unlock-indicator --image=$temp_file

# Revert
xset +dpms dpms 0 0 0
rm $temp_file

