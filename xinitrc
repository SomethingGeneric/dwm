slstatus &

discord &
# slack &

feh --bg-scale .wallpaper.jpg &

if [[ -d .local/bin ]]; then
    ./.local/bin/displays.sh
fi

xrdb -merge ~/.Xresources

exec dbus-launch dwm
