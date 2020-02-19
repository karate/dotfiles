# Gnome keyring for passwords only (no ssh keys)
eval $(/usr/bin/gnome-keyring-daemon --start --components=secrets)

feh --randomize --bg-fill ~/Pictures/wallpapers/minimal/
dbus-launch --exit-with-session i3

#exec /usr/src/dwm/dwm
#exec awesome

