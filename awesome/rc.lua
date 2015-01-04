local vicious = require("vicious")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
awful.rules = require("awful.rules")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
-- dynamic tagging
--local shifty = require("shifty")

-- {{{ Variable definitions
-- Themes define colours, icons, and wallpapers
beautiful.init("/usr/share/awesome/themes/default/theme.lua")

-- This is used later as the default terminal and editor to run.
--terminal = "urxvt"
terminal = "terminator"
editor = os.getenv("EDITOR") or "vi"
--editor_cmd = terminal .. " -e " .. editor
editor_cmd = "urxvt -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
layouts = {
	awful.layout.suit.tile,
	awful.layout.suit.tile.left,
	awful.layout.suit.tile.bottom,
	awful.layout.suit.tile.top,
	awful.layout.suit.fair,
	awful.layout.suit.fair.horizontal,
	awful.layout.suit.spiral,
	awful.layout.suit.spiral.dwindle,
	awful.layout.suit.max,
	awful.layout.suit.max.fullscreen,
	awful.layout.suit.magnifier,
	awful.layout.suit.floating
}

-- {{{ List of properties to get set for clients identified by rules
AppsPropRules = {
	floating = {
		class = {
			[true] = { "MPlayer", "pinentry", "gimp", "Audacious", "Vlc" },
			[false] = { "Gvimdiff" }
		},
		instance = {
			[true] = { "mocp", "playlist" }
		},
		name = {
			[false] = { "Playlist" },
			[true] = { "MATLAB" },
		}
	},  -- clients that should be floating
	maximized_horizontal = {
		class = {},
		instance = { [true] = { "gvimdiff", "meld" } }
	}, -- clients that should be maximzed horizontally
	maximized_vertical = {
		class = {
			--["Vlc"] = true
		},
		instance = {}
	}, -- clients that should be maximized vertically
	size_hints_honor = {
	class    = {
		[true] = { },
		[false] = { "Gnome-terminal", "Terminator", "Gvim", "Gvimdiff" } }
	}
}
-- }}}

-- {{{ Additional client specific tags:
AppsTagRules = {
	i = {
		class = { "emesene", "Empathy" }
	}, -- i for instant messengers
	m = {
		class = { "Miro.real", "Quodlibet", "Audacious" }
	}, -- m for music/media
	M = {
		class = { "Mathematica" },
		name = { "MATLAB" , "Mathematica" }
	}, -- M for Mathematics
	T = {
		class = { "Terminator" }
	}, -- T for Terminals
	W = {
		class = { "Chromium-broswer-live", "Firefox", "Chromium-browser"}
	}, -- W for webs
	E = {
		class = { "Gvim" }
	}, -- Editors
	v = {
		class = { "Miro.real", "Vlc" }
	} -- v for video
}
-- }}}
-- }}}

-- {{{ Wallpaper
if beautiful.wallpaper then
    for s = 1, screen.count() do
        gears.wallpaper.maximized(beautiful.wallpaper, s, true)
    end
end
-- }}}

-- Useful functions {{{
function find_tags_byname(s,n)
	local t = {}
	for j,tag in ipairs(tags[s]) do
		if tag.name == n then
			table.insert(t,tag)
		end
	end
	return t
end
-- }}}

-- {{{ Tags
-- Default tag names
ts = {"甲","乙","丙","丁","戊","己","庚","辛","壬","癸"}
-- insert those needed for tag rules
for tags,v in pairs(AppsTagRules) do
	table.insert(ts,tags)
end

-- Define a tag table which hold all screen tags.
tags = {}
for s = 1, screen.count() do
	-- Each screen has its own tag table.
	tags[s] = awful.tag(ts, s, layouts[1])
end
-- }}}

-- {{{ Menu
-- Create a laucher widget and a main menu
myawesomemenu = {
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", awesome.quit }
}

mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
                                    { "open terminal", terminal }
                                  }
                        })

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- {{{ Wibox
-- Create a textbox to display client info
local mytextclient = wibox.widget.textbox()
mytextclient:set_align("left")
mytextclient:set_markup("<b><small> AWESOME </small></b>")

-- {{{ Vicious
-- netwidget
local netwidget = wibox.widget.textbox()
netwidget:set_align("left")
vicious.register(netwidget, vicious.widgets.net, '<span color="#CC9393">${wlan0 down_kb}</span> <span color="#7F9F7F">${wlan0 up_kb}</span>', 3)

-- separator
local separator = wibox.widget.textbox()
separator:set_text(" :: ")

-- cpuwidget
local cpuwidget = wibox.widget.textbox()
--vicious.register(cpuwidget, vicious.widgets.cpu, "$1%")
vicious.register(cpuwidget, vicious.widgets.cpu, '<span color="#CC6016">$1%</span> <span color="#CC6016">$2%</span> <span color="#CC6016">$3%</span> <span color="#CC6016">$4%</span>')

--datewidget 
local datewidget = wibox.widget.textbox()
vicious.register(datewidget, vicious.widgets.date, '<span color="#8470FF">%b %d</span> <span color="#7FFF00">%R</span>', 60)

--batwidget
local batwidget = wibox.widget.textbox()
vicious.register(batwidget, vicious.widgets.bat, '<span color="#008B45">$1$2</span>', 60, "BAT0")
-- }}}

-- Create a textclock widget
--mytextclock = awful.widget.textclock({ align = "right" })
mytextclock = awful.widget.textclock()
mytextclock:set_align("right")

-- Create a systray
mysystray = wibox.widget.systray()

-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, awful.tag.viewnext),
                    awful.button({ }, 5, awful.tag.viewprev)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
-- left button switches to client
awful.button({ }, 1, function (c)
	if c == client.focus then
		c.minimized = true
	else
		if not c:isvisible() then
			awful.tag.viewonly(c:tags()[1])
		end
		-- This will also un-minimize
		-- the client, if needed
		client.focus = c
		c:raise()
	end
end),
-- mod + middle button kills client
awful.button({ modkey, }, 2, function (c) c:kill() end),
-- right button for context menu
awful.button({ }, 3, function ()
	if instance then
		instance:hide()
		instance = nil
	else
		instance = awful.menu.clients({ width=250 })
	end
end),
-- scroll up and down to enumerate clients
awful.button({ }, 4, function ()
	awful.client.focus.byidx(1)
	if client.focus then client.focus:raise() end
end),
awful.button({ }, 5, function ()
	awful.client.focus.byidx(-1)
	if client.focus then client.focus:raise() end
end))

for s = 1, screen.count() do
	-- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt()
	-- Create an imagebox widget which will contains an icon indicating which layout we're using.
	-- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
	mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)

	-- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons)

	-- Create the wibox
	mywibox[s] = awful.wibox({ position = "top", screen = s })

    -- Widgets that are aligned to the left
    local left_layout = wibox.layout.fixed.horizontal()
    left_layout:add(mylauncher)
    left_layout:add(mytaglist[s])
    left_layout:add(mypromptbox[s])

    -- Widgets that are aligned to the right
    local right_layout = wibox.layout.fixed.horizontal()
    --right_layout:add(mytextclock)
    right_layout:add(mytextclient)
    right_layout:add(separator)
    right_layout:add(batwidget)
    right_layout:add(separator)
    right_layout:add(cpuwidget)
    right_layout:add(separator)
    right_layout:add(netwidget)
    right_layout:add(separator)
    right_layout:add(datewidget)
    if s == 1 then right_layout:add(mysystray) end
    right_layout:add(mylayoutbox[s])

    -- Now bring it all together (with the tasklist in the middle)
    local layout = wibox.layout.align.horizontal()
    layout:set_left(left_layout)
    layout:set_middle(mytasklist[s])
    layout:set_right(right_layout)

    mywibox[s]:set_widget(layout)
end
-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
awful.button({ }, 1, function () mymainmenu:hide() end),
awful.button({ }, 3, function () mymainmenu:toggle() end),
awful.button({ }, 4, awful.tag.viewnext),
-- awful.button({ "Shift" }, 4,
--   function()
--     if client.focus then
--       client.opacity = math.max(0,client.opacity -0.05)
--     end
--   end),
awful.button({ }, 5, awful.tag.viewprev)
))

clientbuttons = awful.util.table.join(
awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
awful.button({ modkey }, 1, awful.mouse.client.move),
awful.button({ modkey }, 3, awful.mouse.client.resize))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
-- awful.key({ modkey, "Shift"   }, "Left",
--     function ()
--         if client.focus and tags[client.focus.screen][i] then
--             awful.client.movetotag(tags[client.focus.screen][i])
--         end
--      end),
awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
awful.key({ modkey,           }, "Escape", awful.tag.history.restore),

awful.key({ modkey,           }, "j",
function ()
			awful.client.focus.byidx( 1)
			if client.focus then client.focus:raise() end
end),
awful.key({ modkey,           }, "k",
function ()
			awful.client.focus.byidx(-1)
			if client.focus then client.focus:raise() end
end),
awful.key({ modkey,           }, "w", function () mymainmenu:show({keygrabber=true}) end),

-- Layout manipulation
awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
awful.key({ modkey,           }, "Tab",
function ()
			awful.client.focus.history.previous()
			if client.focus then
				client.focus:raise()
			end
end),

-- Standard program
awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
awful.key({ modkey, "Control" }, "r", awesome.restart),
awful.key({ modkey, "Shift"   }, "q", awesome.quit),

awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),

awful.key({ modkey, "Control" }, "n", awful.client.restore),

-- Prompt
awful.key({ modkey },            "r",     function () mypromptbox[mouse.screen]:run() end),

awful.key({ modkey }, "x",
function ()
			awful.prompt.run({ prompt = "Run Lua code: " },
			mypromptbox[mouse.screen].widget,
			awful.util.eval, nil,
			awful.util.getdir("cache") .. "/history_eval")
end)
)

clientkeys = awful.util.table.join(
awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
awful.key({ modkey, "Shift"   }, "r",      function (c) c:redraw()                       end),
awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
awful.key({ modkey,           }, "n",
function (c)
		-- The client currently has the input focus, so it cannot be
		-- minimized, since minimized clients can't have the focus.
		c.minimized = true
end),
awful.key({ modkey,           }, "m",
function (c)
		c.maximized_horizontal = not c.maximized_horizontal
		c.maximized_vertical   = not c.maximized_vertical
	end)
)

-- Compute the maximum number of digit we need, limited to 9
keynumber = 0
for s = 1, screen.count() do
	keynumber = math.min(10, math.max(#tags[s], keynumber));
end

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, keynumber do
	globalkeys = awful.util.table.join(globalkeys,
		awful.key({ modkey }, "#" .. i + 9,
		function ()
			local screen = mouse.screen
			if tags[screen][i] then
				awful.tag.viewonly(tags[screen][i])
			end
		end),
	awful.key({ modkey, "Control" }, "#" .. i + 9,
		function ()
			local screen = mouse.screen
			if tags[screen][i] then
				awful.tag.viewtoggle(tags[screen][i])
			end
		end),
	awful.key({ modkey, "Shift" }, "#" .. i + 9,
		function ()
			if client.focus and tags[client.focus.screen][i] then
				awful.client.movetotag(tags[client.focus.screen][i])
				naughty.notify({
					text = "Moving client from tag " .. (client.focus or "nil") .. " to tag " .. i,
					icon = "/usr/share/pixmaps/fixfox.png"})
				print(client.focus)
				--awful.client.toggletag(tags[client.focus.screen][i])
				--awful.client.toggletag(tags[client.focus.screen][i])
			end
		end),
	awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
		function ()
			if client.focus and tags[client.focus.screen][i] then
				awful.client.toggletag(tags[client.focus.screen][i])
			end
		end))
end -- loop thru keynumbers

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c)	client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
awful.rules.rules = {
	-- All clients will match this rule.
	{
		rule = { },
		properties = {
			border_width = beautiful.border_width,
			border_color = beautiful.border_normal,
			focus = true,
			size_hints_honor = false,
			keys = clientkeys,
			buttons = clientbuttons
		}
	}
}

-- Go through application tag rule list and append each rule to rule table (awful.rules.rules)
-- AppsTagRules = { "tag" = { "match_method" = { "app_by_match_method" } } }
for tagname,ruleslist in pairs(AppsTagRules) do
	for idmethod,appslist in pairs(ruleslist) do
		for k,apps in pairs(appslist) do
			-- print(tagname,idmethod,apps)
			awful.rules.rules = awful.util.table.join (
			awful.rules.rules, {{
				rule = { [idmethod] = apps},
				callback =
				function(c)
					local t = c:tags()
					t = awful.util.table.join(t,find_tags_byname(c.screen,tagname))
					c:tags(t)
				end
			}})
		end
	end
end

-- Go through application property rule list and append each property rule to rule table
-- AppsPropRules = { "properties" = { "match_method" = { "setting" = { "app_by_match_method" } } } }
for prop,m in pairs(AppsPropRules) do
	for match,n in pairs(m) do
		for set,apps in pairs(n) do
			for q,app in pairs(apps) do
				-- os.execute("echo " .. p .. "-" .. "-" .. v .. "-" .. j)
				-- os.execute("echo" .. " " .. match .. ":" .. app .. ":" .. prop .. ":" .. set)
				print(match,app,prop,set)
				awful.rules.rules = awful.util.table.join(
				awful.rules.rules,
				{ { rule = { [match] = app },
				properties = { [prop] = set} } })
			end
		end
	end
end
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage",
function (c, startup)
	-- Add a titlebar
	-- awful.titlebar.add(c, { modkey = modkey })

	-- Enable sloppy focus
	c:connect_signal("mouse::enter",
	function(c)
		if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
			and awful.client.focus.filter(c) then
			client.focus = c
		end
	end)

	if not startup then
		-- Set the windows at the slave,
		-- i.e. put it at the end of others instead of setting it master.
		-- awful.client.setslave(c)

		-- Put windows in a smart way, only if they does not set an initial position.
		if not c.size_hints.user_position and not c.size_hints.program_position then
			awful.placement.no_overlap(c)
			awful.placement.no_offscreen(c)
		end
	end
end)

-- When client focus, write its class and instance on the mytextclient.
client.connect_signal("focus",
function(c)
	c.border_color = beautiful.border_focus
	DisplayText = (c.class or "").. "[" .. (c.instance or "") .. "]"
	if awful.client.floating.get(c) then
		DisplayText = DisplayText .. "F"
	else
		DisplayText = DisplayText .. "f"
	end
	mytextclient:set_markup("<b><small>" .. DisplayText .. "</small></b>")
end)

-- when client unfocus, change mytextclient to be AWESOME
client.connect_signal("unfocus",
function(c)
	c.border_color = beautiful.border_normal
    mytextclient:set_markup("<b><small> AWESOME </small></b>")
end)
-- }}}

-- {{{ Autostart

--- function autostart(dir)
---    if not dir then
---        do return nil end
---    end
---    local fd = io.popen("ls -1 -F " .. dir)
---    if not fd then
---        do return nil end
---    end
---    for file in fd:lines() do
---        local c= string.sub(file,-1)   -- last char
---        if c=='*' then  -- executables
---            executable = string.sub( file, 1,-2 )
---            print("Awesome Autostart: Executing: " .. executable)
---            awful.util.spawn_with_shell(dir .. "/" .. executable .. "") -- launch in bg
---        -- elseif c=='@' then  -- symbolic links
---        --    print("Awesome Autostart: Not handling symbolic links: " .. file)
---        else
---            print ("Awesome Autostart: Skipping file " .. file .. " not executable.")
---        end
---    end
---    io.close(fd)
---end
---
---autostart_dir = os.getenv("HOME") .. "/.config/autostart"
---autostart(autostart_dir)
---os.execute(os.getenv("HOME") .. "/.xinitrc")
os.execute(os.getenv("HOME") .. "/.config/awesome/xinitrc")
-- }}}
