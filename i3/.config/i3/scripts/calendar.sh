#!/usr/bin/sh

notify-send -c calendar -t 10000 "This Month" "$(cal -m --color=always | sed "s/..7m/<b><span color=\"#fc9d37\">/;s/..27m/<\/span><\/b>/")"
