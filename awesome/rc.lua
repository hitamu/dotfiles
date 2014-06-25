-- Standard awesome library--{{{
require("awful")
require("awful.autofocus")
require("awful.rules")
-- Theme handling library
require("beautiful")
-- Notification library
require("naughty")
require("vicious")--}}}

-- {{{ Variable definitions
-- Themes define colours, icons, and wallpapers
beautiful.init("/home/hitamu/.config/awesome/themes/hitamu/theme.lua")
--beautiful.init("/home/hitamu/.config/awesome/themes/awesome-solarized/dark/theme.lua")
-- This is used later as the default terminal and editor to run.
--terminal = "mate-terminal"
terminal = "mate-terminal"
editor = os.getenv("EDITOR") or "vim"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"
altkey = "Mod1"
-- Titlebar
use_titlebar = false


-- Table of layouts to cover with awful.layout.inc, order matters.
layouts =
{
    awful.layout.suit.floating, --1
    awful.layout.suit.tile, --2
    awful.layout.suit.tile.left, --3
    awful.layout.suit.tile.bottom, --4
    awful.layout.suit.tile.top, --5
    awful.layout.suit.fair, --6
    awful.layout.suit.fair.horizontal, --7
    awful.layout.suit.spiral, --8
    awful.layout.suit.spiral.dwindle, --9
    awful.layout.suit.max, --10
    awful.layout.suit.max.fullscreen, --11
    awful.layout.suit.magnifier --12
}
-- }}}

-- {{{ Tags
-- Define a tag table which hold all screen tags.
tags = {}
tags.settings = {
    { name = "WorkSpace",  layout = layouts[1] },
    { name = "file",  layout = layouts[1] },
    { name = "web", layout = layouts[1] },
    { name = "media", layout = layouts[1] },
    { name = "chat", layout = layouts[1] },
}
for s = 1, screen.count() do
    tags[s] = {}
    for i, v in ipairs(tags.settings) do
        tags[s][i] = tag({ name = v.name })
        tags[s][i].screen = s
        awful.tag.setproperty(tags[s][i], "layout", v.layout)
    end
    tags[s][1].selected = true
end
-- }}}


-- Create a laucher widget and a main menu
myawesomemenu = {
   { "Manual", terminal .. " -e man awesome" },
   { "Edit config", editor_cmd .. " " .. awful.util.getdir("config") .. "/rc.lua" },
   { "Edit theme", editor_cmd .. " " .. awful.util.getdir("config") .. "/themes/hitamu/theme.lua" },
   { "Restart", awesome.restart },
   { "Quit", awesome.quit },
   { "Oblogout", "oblogout" }
}
internetmenu = {   
   { "Firefox", "firefox"},
   { "Pidgin", "pidgin" }
}
mediamenu = {
   { "Ncmpcpp", "urxvt -e ncmpcpp" },
   { "VLC", "vlc -e" },
   { "Vbox", "virtualbox" }
}
officemenu = {
	{ "base",		"libreoffice --base"	},
	{ "calc",		"libreoffice --calc"	},
	{ "impress",		"libreoffice --impress"	},
	{ "libreoffice",	"libreoffice"		},
	{ "writer",		"libreoffice --writer"	}
}
manamenu = {
   { "spacefm", "spacefm" },
   { "pcmanfm", "pcmanfm" },
   { "caja", "caja" }
}
editormenu = {
   { "GVim", "gvim" },
   { "Pluma", "pluma" }
}
graphimenu = {
   { "Gimp", "gimp" },
}
sistemenu = {
   { "Htop", "urxvt -e htop"},
   { "Bleachbit", "bleachbit" },
   { "Gparted", "gksudo gparted" },
   { "Lxappearance", "lxappearance" },
   { "VolumeControl", "mate-volume-control" },
   { "NetworkApplet", "nm-applet" }
}

mymainmenu = awful.menu({ items = { 
				    { "Terminal", terminal },
                    { " ", nil, nil}, -- separator
                    { "Awesome", myawesomemenu },
                    { "Internet", internetmenu },
                    { "Media", mediamenu },
                    { "Manager", manamenu },
                    { "Office", officemenu },
                    { "Graphics", graphimenu },
                    { "Editor", editormenu },
                    { " ", nil, nil}, -- separator
                    { "System", sistemenu },
                    { " ", nil, nil}, -- separator
				    { "Quit", exitmenu }
                                  }
                        })

mylauncher = awful.widget.launcher({ image = image(beautiful.awesome_icon),
                                     menu = mymainmenu })
-- }}}

-- {{{ Wibox
-- Create a textclock widget
mytextclock = awful.widget.textclock({ align = "right" })

-- Create a systray
mysystray = widget({ type = "systray" })

-- Separator (hitamu)
separator = widget({ type = "textbox" })
separator.text = '<span color="#a2a2a2"> </span>'

-- Clock widget (hitamu)
datewidget = widget({ type = "textbox" })
vicious.register(datewidget, vicious.widgets.date, '<span color="#a86500">[</span><span color="#00ccFF">%d</span> <span color="#00ccFF">%B</span> <span color="#00ccFF">%R</span><span color="#a86500">]</span>', 60)

-- Vol widget (hitamu)
volwidget = widget({ type = "textbox" })
vicious.register(volwidget, vicious.widgets.volume, '<span color="#00ccFF">$1%</span>', 1, "Master")

-- Vol icon (hitamu)
volicon = widget({ type = "imagebox", align = "right" })
volicon.image = image("/home/hitamu/.config/awesome/themes/hitamu/icons/vol.png")

-- CPU widget (hitamu)
cpuwidget = widget({ type = "textbox" })
vicious.register(cpuwidget, vicious.widgets.cpu, '<span color="#EF2929">$1%</span>')

-- Cpu icon (hitamu)
cpuicon = widget({ type = "imagebox", align = "right" })
cpuicon.image = image("/home/hitamu/.config/awesome/themes/hitamu/icons/cpu.png")
	
-- Memory usage (hitamu)
memwidget = widget({ type = "textbox" })
vicious.register(memwidget, vicious.widgets.mem, '<span color="#FF9300">$1%</span>', 13)


-- Mem icon (hitamu)
memicon = widget({ type = "imagebox", align = "right" })
memicon.image = image("/home/hitamu/.config/awesome/themes/hitamu/icons/mem.png")

-- temperature
tzicon = widget({ type = "imagebox", align = "right" })
tzicon.image = image("/home/hitamu/.config/awesome/themes/hitamu/icons/temp.png")
tzswidget = widget({ type = "textbox" })
vicious.register(tzswidget, vicious.widgets.thermal,
	function (widget, args)
		if args[1] > 0 then
			tzfound = true
			return " <span color='#00ccFF'>" .. args[1] .. "°C</span>"
		else return "" 
		end
	end
	, 19, "thermal_zone0")

--  Battery widget
batwidget = widget({ type = "textbox" })
vicious.register(batwidget, vicious.widgets.bat, '<span color="#a2a2a2">$1%</span>', 13)

baticon = widget({ type = "imagebox", align = "right" })
-- Register widget
vicious.register(batwidget, vicious.widgets.bat,
	function (widget, args)
		if args[2] == 0 then return ""
		else
			baticon.image = image("/home/hitamu/.config/awesome/themes/hitamu/icons/bat.png")
			return "<span color='#00ccFF'>".. args[2] .. "%</span>"
		end
	end, 61, "BAT0"
)

-- }}}

-- Create a wibox for each screen and add it--{{{
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
                     awful.button({ }, 1, function (c)
                                              if not c:isvisible() then
                                                  awful.tag.viewonly(c:tags()[1])
                                              end
                                              client.focus = c
                                              c:raise()
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({ width=250 })
                                              end
                                          end),
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
    mypromptbox[s] = awful.widget.prompt({ layout = awful.widget.layout.horizontal.leftright })
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    --mylayoutbox[s] = awful.widget.layoutbox(s)
    --mylayoutbox[s]:buttons(awful.util.table.join(
      --                     awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
        --                   awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
          --                 awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
            --               awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.label.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(function(c)
                                              return awful.widget.tasklist.label.currenttags(c, s)
                                          end, mytasklist.buttons)

    -- Create the wibox
    mywibox[s] = awful.wibox({
	    position = "top",
	    -- screen = s
	    height = 16,
	    border_color = beautiful.border_panel,
	    border_width = beautiful.border_width_panel
    })
    -- Add widgets to the wibox - order matters
    mywibox[s].widgets = {
        {
            mytaglist[s],
            mypromptbox[s],
            mylayoutbox[s],
            layout = awful.widget.layout.horizontal.leftright
        },
        datewidget,
        separator,
        batwidget,
        separator,
        baticon,
        separator,
        memwidget,
        separator,
        memicon,
        separator,
        cpuwidget,
        separator,
        cpuicon,
        separator,
        volwidget,
        separator,
        volicon,
        separator,
        tzswidget,
        tzicon,
        s == 1 and mysystray or nil,
        mytasklist[s],
        layout = awful.widget.layout.horizontal.rightleft
    }
end
-- }}}--}}}


-- {{{ Key bindings
globalkeys = awful.util.table.join(
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ altkey,           }, "Tab",
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
    
    awful.key({ modkey,           }, "p",     function () awful.util.spawn("pidgin")      end),
    awful.key({ modkey,           }, "b",     function () awful.util.spawn("google-chrome")   end),
    awful.key({           }, "`",     function () awful.util.spawn("tilda")   end),
    awful.key({ modkey, 	      }, "r",     function () awful.util.spawn("gmrun")     end),
    awful.key({ modkey, 	      }, "g",     function () awful.util.spawn("gvim")     end),
    awful.key({ modkey, 	      }, "s",     function () awful.util.spawn("synapse")     end),
    awful.key({ modkey, 	      }, "a",     function () awful.util.spawn("lxappearance")     end),
    
    awful.key({ modkey,           }, "Return",function () awful.util.spawn(terminal)    end),
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

   awful.key({ "Control"}, "Next",  function () awful.client.moveresize( 20,  20, -40, -40) end),
   awful.key({ "Control"}, "Prior", function () awful.client.moveresize(-20, -20,  40,  40) end),
   awful.key({ "Control"}, "Down",  function () awful.client.moveresize(  0,  20,   0,   0) end),
   awful.key({ "Control"}, "Up",    function () awful.client.moveresize(  0, -20,   0,   0) end),
   awful.key({ "Control"}, "Left",  function () awful.client.moveresize(-20,   0,   0,   0) end),
   awful.key({ "Control"}, "Right", function () awful.client.moveresize( 20,   0,   0,   0) end),

   awful.key({ modkey, "Control"}, "Down",  function () awful.client.moveresize(  0, 0,  0,  20) end),
   awful.key({ modkey, "Control"}, "Up",    function () awful.client.moveresize(  0, 0,  0,  -20) end),
   awful.key({ modkey, "Control"}, "Left",  function () awful.client.moveresize(0,   0,   -20,   0) end),
   awful.key({ modkey, "Control"}, "Right", function () awful.client.moveresize( 0,   0,  20,   0) end),
    
    -- Print screen
    awful.key({ }, "Print", function () awful.util.spawn("scrot -e 'mv $f ~/hitamu/ 2>/dev/null'") end),

    -- hitamu keys
    awful.key({ modkey,           }, "-",     function () awful.util.spawn("urxvt -e htop" )    end),
    awful.key({ modkey,           }, "Home",     function () awful.util.spawn("spacefm" )    end),
        
    -- hitamu multimedia keys
    awful.key({ modkey,           }, "Up",     function () awful.util.spawn("amixer sset Master 5%+" )   end),
    awful.key({ modkey,           }, "Down",     function () awful.util.spawn("amixer sset Master 5%-" )   end),

    -- hitamu music keys
    awful.key({ modkey,           }, "/",     function () awful.util.spawn("mpc toggle" )  end),
    awful.key({ modkey,           }, ".",     function () awful.util.spawn("mpc next" )    end),
    awful.key({ modkey,           }, ",",     function () awful.util.spawn("mpc prev" )    end),

    -- Prompt
    --awful.key({ modkey, 	   },"r",     function () mypromptbox[mouse.screen]:run() end),

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
    awful.key({ modkey,           }, "n",      function (c) c.minimized = not c.minimized    end),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)

-- Compute the maximum number of digit we need, limited to 9
keynumber = 0
for s = 1, screen.count() do
   keynumber = math.min(9, math.max(#tags[s], keynumber));
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
                      end
                  end),
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.toggletag(tags[client.focus.screen][i])
                      end
                  end))
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize)
)


-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = true,
                     keys = clientkeys,
                     maximized_vertical   = false,
                     maximized_horizontal = false,
                     buttons = clientbuttons } },
    { rule = { class = "urxvt" },
      properties = { floating = true } },
    { rule = { class = "Gvim" },
      properties = { floating = true } },
    { rule = { class = "google-chrome" },
      properties = { floating = true } },
    { rule = { class = "firefox" },
      properties = { floating = true } },
    -- Set Gvim to always map on tags number 2 of screen 1.
    { rule = { class = "Gvim" },
      properties = { tag = tags[1][1] } },
    -- Set caja to always map on tags number 4 of screen 1.
    { rule = { class = "spacefm" },
      properties = { tag = tags[1][2] } },
    -- Set caja to always map on tags number 4 of screen 1.
    { rule = { class = "caja" },
      properties = { tag = tags[1][2] } },
    -- Set chmsee to always map on tags number 1 of screen 1.
    { rule = { class = "Chmsee" },
      properties = { tag = tags[1][2] } },
    -- Set Evince to always map on tags number 2 of screen 1.
    { rule = { class = "Evince" },
      properties = { tag = tags[1][2] } },
    -- Set Firefox to always map on tags number 3 of screen 1.
    { rule = { class = "Firefox" },
      properties = { tag = tags[1][3] } },
    -- Set Chrome to always map on tags number 3 of screen 1.
    { rule = { class = "Google-chrome" },
      properties = { tag = tags[1][3] } },
    -- Set ncmpcpp to always map on tags number 5 of screen 1.
    { rule = { class = "Vlc"},
      properties = { tag = tags[1][4] } },
    -- Set pidgin to always map on tags number 6 of screen 1.
    { rule = { class = "Pidgin" },
      properties = { tag = tags[1][5] } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.add_signal("manage", function (c, startup)
    -- Add a titlebar
    -- awful.titlebar.add(c, { modkey = modkey })

    -- Enable sloppy focus
    c:add_signal("mouse::enter", function(c)
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

-- hitamu focus
--client.add_signal("focus", function(c) c.border_color = beautiful.border_focus
--                                      c.opacity = 1
--			       end)
client.add_signal("focus",
        function(c)
                if c.maximized_horizontal == true and c.maximized_vertical == true then
                        c.border_width = "0"
                        c.border_color = beautiful.border_focus
                else
                        c.border_width = beautiful.border_width
                        c.border_color = beautiful.border_focus
                end
        end)
client.add_signal("unfocus", function(c) c.border_color = beautiful.border_wnormal
	                                 c.opacity = 0.9
				end)

--hitamu autorun
function run_once(prg)
	if not prg then
		do return nil end
	end
	awful.util.spawn_with_shell("pgrep -u $USER -x " .. prg .. " || (" .. prg .. ")")
end

--run_once("thunar --daemon")
--run_once("conky")
--run_once("/home/hitamu/.scripts/run.sh")
--run_once("caja")
