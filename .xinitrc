start-pulseaudio-x11
[ -d /usr/fonts/local ] && xset +fp /usr/share/fonts/local
xrdb -merge ~/.Xresources
urxvtd -q -o -f &>/dev/null
unclutter -idle 2 -jitter 10 &
xcompmgr -c -C -t-15 -l-15 -r12 -o.75 &
(pnmixer & sleep 0.6 ; wicd-client -t) &

case "$1" in
awesome) ;&
*) dbus-launch --exit-with-session awesome ;;
esac
