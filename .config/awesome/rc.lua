--[[ INCLUDES ]]--
-- Standard awesome library
local gears = require 'gears'
local awful = require 'awful'
awful.rules = require 'awful.rules'
require 'awful.autofocus'
-- Widget and layout library
local wibox = require 'wibox'
-- Theme handling library
local beautiful = require 'beautiful'
-- Notification library
local naughty = require 'naughty'
local menubar = require 'menubar'


--[[ ERRORS ]]--
if awesome.startup_errors then
	naughty.notify {
		preset = naughty.config.presets.critical,
		title = 'Startup Error',
		text = awesome.startup_errors
	}
end

do
	local in_error
	awesome.connect_signal('debug::error', function (err)
		if in_error then return end
		in_error = true

		naughty.notify {
			preset = naughty.config.presets.critical,
			title = 'Error',
			text = err
		}

		in_error = false
	end)
end


--[[ SETTINGS ]]--
local theme = 'calvin'
local date = ' %a %b %d @ %H:%M:%S '
local terminal = os.getenv 'TERMINAL' or 'urxvtc'
local mod = 'Mod4'
local config = os.getenv 'XDG_CONFIG_HOME' or os.getenv 'HOME'..'/.config'

local programs = {
	'[ -z "`pidof pulseaudio`" ] && start-pulseaudio-x11',
	'[ -d /usr/fonts/local ] && xset +fp /usr/share/fonts/local',
	'xrdb -merge ~/.Xresources',
	'[ -z "`pidof urxvtd`" ] && urxvtd -q -o -f &>/dev/null',
	'[ -z "`pidof unclutter`" ] && unclutter -idle 2 -jitter 10',
	'[ -z "`pidof xcompmgr`" ] && xcompmgr -c -C -t-15 -l-15 -r12 -o.75',
	--'[ -z "`pidof pnmixer`" ] && pnmixer',
	--'[ -z "`pidof timidity`" ] && timidity -iA',
	'xset m 1/1 4'
}

local nmaster = 2
local ncol = 1
local mwfact = 0.6

layouts = {
	awful.layout.suit.tile.bottom,
	awful.layout.suit.floating
}

tags = {names={'main', 'web', 'term', 'misc'}}


--[[ THEMING ]]--
beautiful.init(config..'/awesome/themes/'..theme..'/theme.lua')

terminal_opts = beautiful[terminal..'_opts'] or {}

terminal = terminal..' '..table.concat(terminal_opts, ' ')

if beautiful.wallpaper then
	for s=1,screen.count() do
		gears.wallpaper.maximized(beautiful.wallpaper, s)
	end
end

if beautiful.xresources and io.popen then
	local xrdb, err = io.popen('xrdb -merge', 'w')
	if xrdb then
		_, err = xrdb:write(beautiful.xresources..'\n')
		xrdb:close()
	end
	if err then
		error(err)
	end
end

os.execute 'wmname LG3D'

local theme_path, theme_current = config..'/awesome/themes/current'
local theme_file = io.open(theme_path, 'r')
if theme_file then
	theme_current = theme_file:read('*line')
	theme_file:close()
end
if theme ~= theme_current then
	local function write(path, text)
		if text then
			local f = io.open(path, 'w')
			if f then
				local _, err = f:write(text..'\n')
				f:close()
				if err then
					error(err)
				end
			end
		end
	end

	write(theme_path, tostring(theme))
	write(os.getenv 'HOME'..'/.gtkrc-2.0', beautiful.gtkrc2)

	if beautiful.gtkcss or beautiful.gtksettings then
		os.execute('mkdir -p '..config..'/gtk-3.0')
		write(config..'/gtk-3.0/gtk.css', beautiful.gtkcss)
		write(config..'/gtk-3.0/settings.ini', beautiful.gtksettings)
	end
end


--[[ TAGS & WIDGETS ]]--
clock = awful.widget.textclock(date, 1)
systray = wibox.widget.systray()
widgets = {}
promptbox = {}

taglist = {
	buttons = awful.util.table.join(
		awful.button({   }, 1, awful.tag.viewonly),
		awful.button({mod}, 1, awful.client.movetotag),
		awful.button({   }, 3, awful.client.viewtoggle),
		awful.button({mod}, 3, awful.client.toggletag),
		awful.button({   }, 4, awful.tag.viewnext),
		awful.button({   }, 5, awful.tag.viewprev)
	)
}

tasklist = {
	buttons = awful.util.table.join(
		awful.button({   }, 1, function (c)
			if c == client.focus then
				c.minimized = true
			else
				if not c:isvisible() then
					awful.tag.viewonly(c:tags()[1])
				end
					client.focus = c
					c:raise()
			end
		end),
		awful.button({   }, 3, function ()
			if instance then
				instance:hide()
				instance = nil
			else
				instance = awful.menu.clients {width=250}
			end
		end),
		awful.button({   }, 4, function ()
			awful.client.focus.byidx(1)
			if client.focus then client.focus:raise() end
		end),
		awful.button({   }, 5, function ()
			awful.client.focus.byidx(-1)
			if client.focus then client.focus:raise() end
		end)
	)
}

for s=1,screen.count() do
	tags[s] = awful.tag(tags.names, s, layouts[1])
	promptbox[s] = awful.widget.prompt {prompt=' % '}
	taglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, taglist.buttons)
	tasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, tasklist.buttons)
	widgets[s] = awful.wibox {position='top', screen=s, height=beautiful.wibar_thickness or 12}
	local left = wibox.layout.fixed.horizontal()
	left:add(taglist[s])
	left:add(promptbox[s])
	local right = wibox.layout.fixed.horizontal()
	if s == 1 then right:add(systray) end
	right:add(clock)
	local layout = wibox.layout.align.horizontal()
	layout:set_left(left)
	layout:set_middle(tasklist[s])
	layout:set_right(right)
	widgets[s]:set_widget(layout)
	widgets[s].opacity = .9
	widgets[s].ontop = true
	for _,t in ipairs(tags[s]) do
		awful.tag.setnmaster(nmaster, t)
		awful.tag.setncol(ncol, t)
		awful.tag.setmwfact(mwfact, t)
	end
end


--[[ ACTIONS ]]--
function focus(i)
	return function ()
		awful.client.focus.byidx(i)
		if client.focus then
			client.focus:raise()
		end
	end
end

function swap(i)
	return function ()
		awful.client.swap.byidx(i)
	end
end

function spawn(s)
	return function ()
		awful.util.spawn(s)
	end
end

do local i = 0
	function urgent(s)
		if awful.client.urgent.get() then
			if client.focus then
				awful.tag.history.update(screen[client.focus.screen])
				awful.client.focus.history.add(client.focus)
			end
			awful.client.urgent.jumpto()
			i = i + 1
		else
			awful.tag.history.restore(s, i)
			awful.client.focus.history.previous()
			i = 0
		end
	end
end

function move(i)
	return function ()
		local c = client.focus
		if c then
			local s = c.screen
			local n = awful.tag.getidx(awful.tag.selected(s))
			local m = (n + i - 1) % #tags[s] + 1
			c:tags {tags[s][m]}
		end
	end
end

function layout(i)
	return function ()
		awful.layout.inc(layouts, i)
	end
end

function maximize(c)
	c.maximized_horizontal = not c.maximized_horizontal
	c.maximized_vertical = not c.maximized_vertical
end

function fullscreen(c)
	c.fullscreen = not c.fullscreen
end

function minimize(c)
	c.minimized = true
end

function prompt()
	promptbox[mouse.screen]:run()
end

function jump(i)
	return function ()
		local s = mouse.screen
		if tags[s][i] then
			awful.tag.viewonly(tags[s][i])
		end
	end
end

function send(i)
	return function ()
		local c = client.focus
		if c and tags[c.screen][i] then
			awful.client.movetotag(tags[c.screen][i])
		end
	end
end

function toggle(i)
	return function ()
		local c = client.focus
		if c and tags[c.screen][i] then
			awful.client.toggletag(tags[c.screen][i])
		end
	end
end

function visible(i)
	return function ()
		local s = mouse.screen
		if tags[s][i] then
			awful.tag.viewtoggle(tags[s][i])
		end
	end
end

function floating(c)
	awful.client.floating.toggle(c)
	fix(c)
end

function raise(c)
	client.focus = c
	c:raise()
end

function kill(c)
	c:kill()
end

function fix(c)
	if client.focus == c then
		c.opacity = opacity.focused[c.class]
		if beautiful.border_focus then c.border_color = beautiful.border_focus end
	else
		c.opacity = opacity.normal[c.class]
		if beautiful.border_normal then c.border_color = beautiful.border_normal end
	end
	if awful.client.floating.get(c) then
		c.above = true
		local left = wibox.layout.fixed.horizontal()
		left:add(awful.titlebar.widget.iconwidget(c))
		local right = wibox.layout.fixed.horizontal()
		right:add(awful.titlebar.widget.maximizedbutton(c))
		right:add(awful.titlebar.widget.closebutton(c))
		local title = awful.titlebar.widget.titlewidget(c)
		title:buttons(awful.util.table.join(
			awful.button({}, 1, function ()
				client.focus = c
				c:raise()
				awful.mouse.client.move(c)
			end),
			awful.button({}, 3, function()
				client.focus = c
				c:raise()
				awful.mouse.client.resize(c)
			end)))
		local layout = wibox.layout.align.horizontal()
		layout:set_left(left)
		layout:set_middle(title)
		layout:set_right(right)
		awful.titlebar(c, {size=12, position='top'}):set_widget(layout)
	else
		c.above = false
		awful.titlebar(c, {size=0})
	end
end


--[[ HOTKEYS ]]--
root.buttons(awful.util.table.join(
	awful.button({}, 4, awful.tag.viewnext),
	awful.button({}, 5, awful.tag.viewprev)
))

root.keys(awful.util.table.join(
	awful.key({mod,          }, 'h',      awful.tag.viewprev),
	awful.key({mod,          }, 'l',      awful.tag.viewnext),
	awful.key({mod, 'Shift'  }, 'h',      move(-1)),
	awful.key({mod, 'Shift'  }, 'l',      move(1)),
	awful.key({mod,          }, 'tab',    urgent),
	awful.key({mod,          }, 'j',      focus(1)),
	awful.key({mod,          }, 'k',      focus(-1)),
	awful.key({mod, 'Shift'  }, 'j',      swap(1)),
	awful.key({mod, 'Shift'  }, 'k',      swap(-1)),
	awful.key({mod,          }, 'Return', spawn(terminal)),
	awful.key({mod,          }, 'space',  layout(1)),
	awful.key({mod, 'Shift'  }, 'space',  layout(-1)),
	awful.key({mod, 'Shift'  }, 'n',      awful.client.restore),
	awful.key({mod,          }, 'r',      prompt),
	awful.key({mod, 'Control'}, 'r',      awesome.restart),
	awful.key({mod, 'Control'}, 'q',      awesome.quit)
))

for i=1,#tags.names do
	root.keys(awful.util.table.join(root.keys(),
		awful.key({mod,          }, '#'..i+9, visible(i)),
		awful.key({mod, 'Shift'  }, '#'..i+9, toggle(i))
	))
end

local client_keys = awful.util.table.join(
	awful.key({mod,          }, 'f', floating),
	awful.key({mod,          }, 'm', maximize),
	awful.key({mod, 'Shift'  }, 'm', fullscreen),
	awful.key({mod,          }, 'n', minimize),
	awful.key({mod, 'Control'}, 'c', kill)
)

local client_buttons = awful.util.table.join(
	awful.button({              }, 1, raise),
	awful.button({mod           }, 1, awful.mouse.client.move),
	awful.button({mod           }, 3, awful.mouse.client.resize),
	awful.button({mod, 'Control'}, 2, kill)
)



--[[ RULES ]]--
awful.rules.rules = {
	{
		rule = {},
		properties = {
			border_width = beautiful.border_width,
			border_color = beautiful.border_normal,
			size_hints_honor = false,
			focus = true,
			keys = client_keys,
			buttons = client_buttons
		}
	},
	{
		rule = {class='Gimp'},
		properties = {floating=true}
	},
	{
		rule = {role='gimp-dock'},
		properties = {ontop=true}
	},
	{
		rule = {class='Eclipse'},
		properties = {floating=true}
	},
	{
		rule = {class='VirtualBox'},
		properties = {floating=true}
	}
}

opacity = {
	focused = setmetatable({}, {__index=function () return 1 end}),
	normal = setmetatable({}, {__index=function () return .85 end})
}

opacity.focused.URxvt = 0.9
opacity.normal.URxvt = .45
opacity.normal.Vanilla = 1
opacity.normal.Eclipse = .9
opacity.focused["org-spoutcraft-launcher-Main"] = 1
opacity.normal["org-spoutcraft-launcher-Main"] = .9
opacity.focused.VirtualBox = 1
opacity.normal.VirtualBox = .9
opacity.focused.Gimp = 1
opacity.normal.Gimp = 1

client.add_signal('manage', function (c, startup)
	c.opacity = opacity.focused[c.class]

	fix(c)

	if not startup then
		if not c.size_hints.user_position and not c.size_hints.program_position then
			awful.placement.no_overlap(c)
			awful.placement.no_offscreen(c)
		end
	end
end)

client.connect_signal('focus', fix)
client.connect_signal('unfocus', fix)

--[[ PROGRAMS ]]--
for _,p in ipairs(programs) do
	awful.util.spawn_with_shell(p)
end
