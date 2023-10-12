#!/usr/bin/bash

# Map Caps Lock to ESC (does not work)
#xmodmap -e 'clear lock' -e 'keycode 0x42 = Escape'

# KEYBOARD LAYOUTS
setxkbmap -layout us,gr
setxkbmap -option 'grp:alt_shift_toggle'
