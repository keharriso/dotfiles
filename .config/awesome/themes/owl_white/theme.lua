local title = 'owl_white'
local themes = (os.getenv 'XDG_CONFIG_HOME' or os.getenv 'HOME'..'/.config')..'/awesome/themes'
local root = themes..'/'..title

theme = {
	font = 'clean 12',

	bg_normal   = '#f0f5fd',
	bg_focus    = '#2e322e',
	bg_urgent   = '#f7d17c',
	bg_minimize = '#b0b5bd',

	fg_normal   = '#2e322e',
	fg_focus    = '#f0f5fd',
	fg_urgent   = '#2e322e',
	fg_minimize = '#6e726e',

	wibar_thickness = 12,

	border_width  = '0',
	border_normal = '#000000',
	border_focus  = '#555555',
	border_marked = '#ead0dd',

	taglist_squares_sel   = root..'/taglist/squarefw.png',
	taglist_squares_unsel = root..'/taglist/squarew.png',

	tasklist_floating_icon = root..'/tasklist/floatingw.png',

	titlebar_close_button_normal = root..'/titlebar/close_normal.png',
	titlebar_close_button_focus  = root..'/titlebar/close_focus.png',

	titlebar_ontop_button_normal_inactive = root..'/titlebar/ontop_normal_inactive.png',
	titlebar_ontop_button_focus_inactive  = root..'/titlebar/ontop_focus_inactive.png',
	titlebar_ontop_button_normal_active   = root..'/titlebar/ontop_normal_active.png',
	titlebar_ontop_button_focus_active    = root..'/titlebar/ontop_focus_active.png',

	titlebar_sticky_button_normal_inactive = root..'/titlebar/sticky_normal_inactive.png',
	titlebar_sticky_button_focus_inactive  = root..'/titlebar/sticky_focus_inactive.png',
	titlebar_sticky_button_normal_active   = root..'/titlebar/sticky_normal_active.png',
	titlebar_sticky_button_focus_active    = root..'/titlebar/sticky_focus_active.png',

	titlebar_floating_button_normal_inactive = root..'/titlebar/floating_normal_inactive.png',
	titlebar_floating_button_focus_inactive  = root..'/titlebar/floating_focus_inactive.png',
	titlebar_floating_button_normal_active   = root..'/titlebar/floating_normal_active.png',
	titlebar_floating_button_focus_active    = root..'/titlebar/floating_focus_active.png',

	titlebar_maximized_button_normal_inactive = root..'/titlebar/maximized_normal_inactive.png',
	titlebar_maximized_button_focus_inactive  = root..'/titlebar/maximized_focus_inactive.png',
	titlebar_maximized_button_normal_active   = root..'/titlebar/maximized_normal_active.png',
	titlebar_maximized_button_focus_active    = root..'/titlebar/maximized_focus_active.png',

	wallpaper = root..'/background.jpg',

	urxvtc_opts = {
		'-icon',  "'/usr/share/icons/gnome/16x16/apps/gnome-terminal.png'",
		'-bg',    "'#2e322e'",
		'-fg',    "'#ecece6'",
		'-fn',    "'-*-clean-medium-r-normal--12-*-*-*-*-*-*-*'",
		'-fb',    "'-*-clean-bold-r-normal--12-*-*-*-*-*-*-*'",
		'-sl',    "'512'",
		'-tn',    "'rxvt'",
		'-xrm',   "'URxvt*urgentOnBell: true'",
		"'+sb'", "'+sr'", "'-bc'"
	},

	xresources = [[
! Base
		*background:  #2e322e
		*foreground:  #ecece6
! Black + Dark Gray
		*color0    :  #0e1210
		*color8    :  #555763
! Dark Red + Red
		*color1    :  #cf4f7a
		*color9    :  #ff7faa
! Dark Green + Green
		*color2    :  #a3f45f
		*color10   :  #b8f7a8
! Dark Yellow + Yellow
		*color3    :  #e7d17c
		*color11   :  #efc123
! Dark Blue + Blue
		*color4    :  #80e0f7
		*color12   :  #3465a4
! Dark Magenta + Magenta
		*color5    :  #ff6600
		*color13   :  #f58910
! Dark Cyan + Cyan
		*color6    :  #99a6e2
		*color14   :  #5684ff
! Light Gray + White
		*color7    :  #fcfcfc
		*color15   :  #ffffff

! xscreensaver
		xscreensaver.Dialog.headingFont           :  -*-clean-medium-r-normal--12-*-*-*-*-*-*-*
		xscreensaver.Dialog.bodyFont              :  -*-clean-medium-r-normal--12-*-*-*-*-*-*-*
		xscreensaver.Dialog.labelFont             :  -*-clean-medium-r-normal--12-*-*-*-*-*-*-*
		xscreensaver.Dialog.unameFont             :  -*-clean-medium-r-normal--12-*-*-*-*-*-*-*
		xscreensaver.Dialog.buttonFont            :  -*-clean-medium-r-normal--12-*-*-*-*-*-*-*
		xscreensaver.Dialog.dateFont              :  -*-clean-medium-r-normal--12-*-*-*-*-*-*-*
		xscreensaver.Dialog.passwdFont            :  -*-clean-medium-r-normal--12-*-*-*-*-*-*-*
		xscreensaver.Dialog.background            :  #3e423e
		xscreensaver.Dialog.foreground            :  #ecece6
		xscreensaver.Dialog.topShadowColor        :  #2e322e
		xscreensaver.Dialog.bottomShadowColor     :  #0e1210
		xscreensaver.Dialog.Button.background     :  #0e1210
		xscreensaver.Dialog.Button.foreground     :  #ecece6
		xscreensaver.Dialog.text.background       :  #0e1210
		xscreensaver.Dialog.text.foreground       :  #ecece6
		xscreensaver.Dialog.internalBorderWidth   :  24
		xscreensaver.Dialog.borderWidth           :  2
		xscreensaver.Dialog.shadowThickness       :  2
		xscreensaver.passwd.thermometer.background:  #ecece6
		xscreensaver.passwd.thermometer.foreground:  #2e322e
		xscreensaver.passwd.thermometer.width     :  8
		xscreensaver.dateFormat                   :  %I:%M:%P %a %b %d, %Y
	]],

	gtkrc2 = [[
style "owl-white-default" {
	engine "clearlooks" {}

	bg[NORMAL]        = "#2E322E"
	bg[PRELIGHT]      = "#ECECE6"
	bg[SELECTED]      = "#ECECE6"
	bg[ACTIVE]        = "#ECECE6"
	bg[INSENSITIVE]   = "#B0B5BD"
	fg[NORMAL]        = "#ECECE6"
	fg[PRELIGHT]      = "#8E928E"
	fg[SELECTED]      = "#8E928E"
	fg[ACTIVE]        = "#8E928E"
	fg[INSENSITIVE]   = "#6E726E"
	base[NORMAL]      = "#2E322E"
	base[PRELIGHT]    = "#2E322E"
	base[SELECTED]    = "#ECECE6"
	base[ACTIVE]      = "#F7D17C"
	base[INSENSITIVE] = "#B0B5BD"
	text[NORMAL]      = "#ECECE6"
	text[PRELIGHT]    = "#4C4C46"
	text[SELECTED]    = "#2E322E"
	text[ACTIVE]      = "#4C4C46"
	text[INSENSITIVE] = "#2E322E"
}

class "GtkWidget" style "owl-white-default"
	]],

	gtkcss = [[
* {
	background-color: #2E322E;
	color:            #ECECE6;
}

*:hover {
	background-color: #ECECE6;
	color:            #8E928E;
}

*:selected {
	background-color: #ECECE6;
	color:            #8E928E;
}

*:active {
	background-color: #ECECE6;
	color:            #8E928E;
}

*:insensitive {
	background-color: #B0B5BD;
	color:            #6E726E;
}
	]],

	gtksettings = [[
[Settings]
	]]
}

theme.urxvt_opts = theme.urxvtc_opts
theme.rxvt_opts = theme.urxvtc_opts

return theme
