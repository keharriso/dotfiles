local title = 'calvin'
local themes = (os.getenv 'XDG_CONFIG_HOME' or os.getenv 'HOME'..'/.config')..'/awesome/themes'
local root = themes..'/'..title

theme = {
	font = 'gotham-rounded 8',

	bg_normal   = '#382c1c',
	bg_focus    = '#ebe0c4',
	bg_urgent   = '#b5aa92',
	bg_minimize = '#6e624e',

	fg_normal   = '#ebe0c4',
	fg_focus    = '#382c1c',
	fg_urgent   = '#382c1c',
	fg_minimize = '#ebe0c4',

	wibar_thickness = 16,

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

	wallpaper = root..'/background.png',

	urxvtc_opts = {
		'-icon',  "'/usr/share/icons/gnome/16x16/apps/gnome-terminal.png'",
		'-bg',    "'#ebe0c4'",
		'-fg',    "'#382c1c'",
		'-fn',    "'-*-gohufont-medium-r-normal--14-*-*-*-*-*-*-*'",
		'-fb',    "'-*-gohufont-bold-r-normal--14-*-*-*-*-*-*-*'",
		'-sl',    "'512'",
		'-tn',    "'rxvt'",
		'-xrm',   "'URxvt*urgentOnBell: true'",
		"'+sb'", "'+sr'", "'-bc'"
	},

	xresources = [[
! --- special colors ---

*background: #ebe0c4
*foreground: #382c1c

! --- standard colors ---

! black
!*color0: #1e1b19
*color0: #000000

! bright_black
!*color8: #514e4b
*color8: #262626

! red
!*color1: #c03375
*color1: #8f0048

! bright_red
!*color9: #ca5c8e
*color9: #d7006c

! green
!*color2: #7abd30
*color2: #488f00

! bright_green
!*color10: #94c759
*color10: #6cd700

! yellow
!*color3: #c07830
*color3: #8f4800

! bright_yellow
!*color11: #ca9159
*color11: #d76c00

! blue
!*color4: #3678bb
*color4: #00488f

! bright_blue
!*color12: #5f91c4
*color12: #006cd7

! magenta
!*color5: #7a33bb
*color5: #48008f

! bright_magenta
!*color13: #945cc4
*color13: 6c00d7

! cyan
!*color6: #36bd75
*color6: #008f48

! bright_cyan
!*color14: #5fc78e
*color14: #00d76c

! white
!*color7: #e9e6e4
*color7: #808080

! bright_white
!*color15: #e9e6e4
*color15: #808080
	]],

	gtkrc2 = [[
style "calvin-default" {
	engine "aurora" {}

	bg[NORMAL]        = "#ebe0c4"
	bg[PRELIGHT]      = "#ebe0c4"
	bg[SELECTED]      = "#382c1c"
	bg[ACTIVE]        = "#382c1c"
	bg[INSENSITIVE]   = "#514e4b"
	fg[NORMAL]        = "#1e1b19"
	fg[PRELIGHT]      = "#8E928E"
	fg[SELECTED]      = "#8E928E"
	fg[ACTIVE]        = "#8E928E"
	fg[INSENSITIVE]   = "#6E726E"
	base[NORMAL]      = "#e9e6e4"
	base[PRELIGHT]    = "#e9e6e4"
	base[SELECTED]    = "#382c1c"
	base[ACTIVE]      = "#F7D17C"
	base[INSENSITIVE] = "#514e4b"
	text[NORMAL]      = "#1e1b19"
	text[PRELIGHT]    = "#4C4C46"
	text[SELECTED]    = "#e9e6e4"
	text[ACTIVE]      = "#4C4C46"
	text[INSENSITIVE] = "#e9e6e4"
}

class "GtkWidget" style "calvin-default"
	]],

	gtkcss = [[
* {
	background-color: #ebe0c4;
	color:            #1e1b19;
}

*:hover {
	background-color: #ebe0c4;
	color:            #8E928E;
}

*:selected {
	background-color: #382c1c;
	color:            #8E928E;
}

*:active {
	background-color: #382c1c;
	color:            #8E928E;
}

*:insensitive {
	background-color: #514e4b;
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
