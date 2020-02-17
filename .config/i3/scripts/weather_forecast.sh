#! /usr/bin/env sh
#curl wttr.in/Χαλάνδρι_FpdnQ.png  --output - | feh -
notify-send 'Weather Forecast' "$(curl -s wttr.in/Χαλάνδρι\?TFnQ | sed 's/\\/\\\\/g')" 
