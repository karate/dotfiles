#!/bin/sh

killall polybar
polybar -c ~/.config/polybar/main.conf main &
polybar -c ~/.config/polybar/main.conf secondary

