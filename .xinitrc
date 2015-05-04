case "$WM" in
	awesome) ;&
	*)
		dbus-launch --exit-with-session awesome
		;;
esac
