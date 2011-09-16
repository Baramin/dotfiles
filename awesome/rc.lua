-- Standard awesome library require("awful")
require("awful.autofocus")
require("awful.rules")
-- Theme handling library
require("beautiful")
-- Notification library
require("naughty")
-- Load Debian menu entries
--require("debian.menu")
-- Custom libraries
require("revelation")
require("shifty")
require("vicious")
require("teardrop")

hostname = awful.util.pread("hostname"):gsub("\n", "")

function file_exists(name)
   local f=io.open(name,"r")
   if f~=nil then io.close(f) return true else return false end
end

--if true then return end
-- {{{ Variable definitions
-- Themes define colours, icons, and wallpapers
beautiful.init("/home/ace/.config/awesome/themes/fiesta/theme.lua")

naughty_width = 200 -- in pixels
naughty.config.presets.low.width = naughty_width
naughty.config.presets.normal.width = naughty_width
naughty.config.presets.critical.width = naughty_width

-- This is used later as the default terminal and editor to run.
terminal = "x-terminal-emulator"
editor = os.getenv("EDITOR") or "editor"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"
modkey2 = "Mod3"
-- Table of layouts to cover with awful.layout.inc, order matters.
layouts =
{
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
-- }}}


-- {{{ Tags

shifty.config.tags = {
  --  ["foo"] = { position = 13, init = true, },
  ["1:term"] = { position = 1, init = true, },
  ["3:dev"] = { position = 3, },
  ["2:www"]  = { position = 2,  spawn = "firefox",},
  ["3:gvim"]  = { position = 4, },
  ["5:eclipse"]  = { position = 5, exclusive = true,  nopopup = true, },
  ["6:gimp"] = { position = 6, exclusive = true, nopopup = true, spawn = "gimp", },
  ["7:office"]  = { position = 7, exclusive = true, },
  ["8:view"] = { position = 8, exclusive = true,  },
  ["9:vbox"] = { position = 9, exclusive = true, nopopup = true,  },
}

shifty.taglist = mytaglist
-- Clients rules

shifty.config.apps = {

  { match = {"Gvim"                                       }, tag = "4:gvim", opacity = 1.0 },
  --{ match = {"dev -" }, tag = "3:dev", opacity = 1.0 },
  { match = {"Eterm", "Term -", "terminal" }, opacity = 0.8 },
  { match = {"^Download$", "Preferences", "VideoDownloadHelper","Downloads", "Firefox Preferences", }, float = true, intrusive = true },
  { match = {"Firefox","Iceweasel","Vimperator","Shiretoko"} , tag = "2:www", opacity = 1.0       } ,
  { match = {"Eclipse"} , tag = "5:eclipse", opacity = 1.0       } ,
  { match = {"Gimp"                           }, tag = "6:gimp",  float = true , opacity = 1.0    },
  { match = {"gimp-image-window"              }, slave = true,  opacity = 1.0                     },
  { match = {"LibreOffice" }, tag = "7:office", opacity = 1.0 },
  --{ match = {"MPlayer","ffplay","vlc"                       }, tag = "8:view", float = true,  opacity = 1.0             },
  { match = {"VirtualBox"                     }, tag = "9:vbox", float = true,  opacity = 1.0     },
  { match = {"lxappearence","Caml graphics"               }, float = true, opacity = 1.0                      },
  { match = {"evince", "gpicview","Epdfview", "f-spot"    }, float = true, tag = "8:view",                    },
  { match = { "" },
  buttons = awful.util.table.join(
  awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
  awful.button({ modkey }, 1, awful.mouse.client.move),
  awful.button({ modkey }, 3, awful.mouse.client.resize),
  awful.button({ modkey }, 8, awful.mouse.client.resize))
}
}

-- Options par défaut.
shifty.config.defaults = {
  layout = awful.layout.suit.tile,
  ncol = 1,
  mwfact = 0.50,
  floatBars=false,
}


-- }}}

-- {{{ Menu
-- Create a laucher widget and a main menu
myawesomemenu = {
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awful.util.getdir("config") .. "/rc.lua" },
   { "restart", awesome.restart },
   { "quit", awesome.quit }
}

mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
    --                                { "Debian", debian.menu.Debian_menu.Debian },
    --{ "Dev windows", function () awesome.spawn("/home/ace/bin/rundev.sh"); end },
    { "open terminal", terminal }
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
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.label.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(function(c)
                                              return awful.widget.tasklist.label.currenttags(c, s)
                                          end, mytasklist.buttons)


--- {{ Section des Widgets


-- Date


datewidget = widget({ type = "textbox" })
vicious.register(datewidget, vicious.widgets.date, "%b %d, %R", 60)

-- Mem Widget

memwidget = widget({ type = "textbox" })
vicious.register(memwidget, vicious.widgets.mem, " $2MB/$3MB", 13)


-- CPU Widget


-- Initialize widget
cpuwidget = widget({ type = "textbox" })
-- Register widget
vicious.register(cpuwidget, vicious.widgets.cpu, "$1%")


-- Widget MPD

--mpdwidget = widget({ type = "textbox", name = "mpdwidget" })
--vicious.register(mpdwidget, vicious.widgets.mpd, " $1", 5, { 30, "mpd" })

-- Net Widget
netwidget       = widget({ type = "textbox", name = "netwidget" })
vicious.register(netwidget, vicious.widgets.net, '${eth0 down_kb} kbps / ${eth0 up_kb} kbps', 3)

-- FS Widget
fswidget       = widget({ type = "textbox", name = "fswidget" })
--vicious.register(fswidget, vicious.widgets.fs, ' ${/home used_gb}<span color="'.. beautiful.fg_widget ..'"> /</span> ${/home size_gb} ', 120)
vicious.register(fswidget, vicious.widgets.fs, ' Root : ${/ used_gb} / ${/ size_gb} ', 120)

tempwidget  = widget({ type = "textbox", name = "tempwidget" })
vicious.register(tempwidget, vicious.widgets.thermal, "$1°C", 20, "thermal_zone2")

-- Icones

mycpuicon        = widget({ type = "imagebox", name = "mycpuicon" })
mycpuicon.image  = image(beautiful.widget_cpu)


myneticon         = widget({ type = "imagebox", name = "myneticon" })
myneticonup       = widget({ type = "imagebox", name = "myneticonup" })

myneticonup.image = image(beautiful.widget_netup)
myneticon.image   = image(beautiful.widget_net)

myvolicon       = widget({ type = "imagebox", name = "myvolicon" })
myvolicon.image = image(beautiful.widget_vol)

--mymusicicon     = widget({ type = "imagebox", name = "mymusicicon"})
--mymusicicon.image = image(beautiful.widget_music)

myspacer         = widget({ type = "textbox", name = "myspacer" })
myseparator      = widget({ type = "textbox", name = "myseparator" })

myspacer.text    = " "
myseparator.text = "|"

mydiskicon         = widget({ type = "imagebox", name = "mydiskicon" })
mytimeicon       = widget({ type = "imagebox", name = "mytimeicon" })
mytimeicon.image = image(beautiful.widget_date)
mydiskicon.image   = image(beautiful.widget_fs)

mymemicon       = widget({ type = "imagebox", name = "mymemicon" })
mymemicon.image = image(beautiful.widget_mem)




    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", screen = s })
    -- Add widgets to the wibox - order matters
    mywibox[s].widgets = {
        {
            mytaglist[s],
            mypromptbox[s],
            layout = awful.widget.layout.horizontal.rightleft
        },
        mylayoutbox[s],
        myspacer,
        datewidget,
        s == 1 and mysystray or nil,
        myspacer,
        myspacer,
        fswidget, mydiskicon,
        myspacer,
        myneticonup, netwidget, myneticon,
        myspacer,
        cpuwidget,
        mycpuicon,
        myspacer,
        memwidget,
        mymemicon,
        layout = awful.widget.layout.horizontal.rightleft
    }
end
-- }}}
-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
    -- all minimized clients are restored
    awful.key({ modkey, "Shift"   }, "n",
        function()
            local tag = awful.tag.selected()
                for i=1, #tag:clients() do
                    tag:clients()[i].minimized=false
                    tag:clients()[i]:redraw()
            end
        end),
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
    awful.key({ modkey, "Shift"         }, "Escape", awful.tag.history.restore),

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
--    awful.key({ modkey,           }, "w", function () mymainmenu:show(true)        end),

    awful.key({ modkey, "Control" }, "l", function () awful.util.spawn("gnome-screensaver-command -a") end),

  -- Layout manipulationi
--    awful
    awful.key({ modkey,           }, "Tab", function () awful.client.focus.byidx( 1)    end),
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey, "Shift"	  }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),
-- Shifty

    awful.key({ modkey, "Shift"   }, "t",             shifty.add),
    awful.key({ modkey, "Shift"   }, "r",           shifty.rename),
    awful.key({ modkey, "Shift"   }, "w",           shifty.del),

    awful.key({ modkey, "Shift"   }, "Left",   shifty.shift_prev        ),
    awful.key({ modkey, "Shift"   }, "Right",  shifty.shift_next        ),
 --   awful.key({ modkey            }, "Escape", function() awful.tag.history.restore() end), -- move to prev tag by history
    awful.key({ modkey, "Shift"   }, "n", shifty.send_prev), -- move client to prev tag
    awful.key({ modkey            }, "n", shifty.send_next),

--    shifty.config.clientkeys = clientkeys
    -- Standard program
   -- awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit),
    awful.key({ modkey            },"x",      function () teardrop("urxvt", "top") end),
    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),
    awful.key({ modkey            }, "Down",                          revelation.revelation),
    awful.key({ modkey            }, "F12", function () awful.util.spawn("/home/ace/bin/toggleTrackpad.sh") end ),
 -- Keybindings Perso
 --   awful.key({ modkey2}, "Left", function () awful.util.spawn("amixer -q sset Front 2dB-") end),
 --   awful.key({ modkey2}, "Right", function () awful.util.spawn("amixer -q sset Front 2dB+") end),
    awful.key({ modkey}, "v", function () awful.util.spawn("apps") end),
    awful.key({ modkey}, "t", function () awful.util.spawn("gnome-terminal --hide-menubar") end),
    awful.key({ modkey}, "w", function () awful.util.spawn("firefox") end),
    awful.key({ modkey}, "e", function () awful.util.spawn("gvim") end),
    awful.key({ modkey }, "b", function ()
      mywibox[mouse.screen].visible = not mywibox[mouse.screen].visible
    end),
    awful.key({  }, "XF86AudioRaiseVolume",
    function ()
      naughty.notify({ text = io.popen("echo -n `amixer -c 0 sset PCM 5%+|sed -n 's/.*Front Left: Playback [0-9]* \\[\\([0-9]*\\)\\%\\] .*/Volume: \\1%/p'`"):read("*a") })
    end),
    awful.key({  }, "XF86AudioLowerVolume",
    function ()
      naughty.notify({ text = io.popen("echo -n `amixer -c 0 sset PCM 5%-|sed -n 's/.*Front Left: Playback [0-9]* \\[\\([0-9]*\\)\\%\\] .*/Volume: \\1%/p'`"):read("*a") })
    end),
    awful.key({  }, "XF86AudioMute",
    function ()
      os.execute("amixer -c 0 set Master toggle mutt")
      local on_off = io.popen("echo -n `amixer -c 0 get Master|sed -n 's/.*Front Left: Playback [0-9]* \\[[0-9]*\\%\\] \\[[^ ]*\\] \\[\\([a-z]*\\)\\].*/\\1/p'`"):read("*a")
      if on_off == "on" then
        naughty.notify({ text = io.popen("echo -n `amixer -c 0 get PCM |sed -n 's/.*Front Left: Playback [0-9]* \\[\\([0-9]*\\)\\%\\] .*/Volume ON:\\1%/p'`"):read("*a") })
      else
        naughty.notify({ text = "Volume OFF" })
      end
    end),
    --}) end),


    -- Prompt
    awful.key({ modkey },            "BackSpace",
    function ()
      mypromptbox[mouse.screen]:run()
    end),
    -- Customs prompts
    awful.key({ modkey }, "g",
    function ()
      awful.prompt.run({ prompt = "Urxvtc: " }, promptbox[mouse.screen].widget,
      function (name)
        exec("urxvtc -T "..name.."")
      end)
    end)
    )

tagkeys = { '#10', '#11', '#12', '#13', '#14', '#15', '#16', '#17', '#18', '#19', '#20' }
for i=1,9 do

  globalkeys = awful.util.table.join(globalkeys, awful.key({ modkey }, tagkeys[i],
  function ()
    local t = awful.tag.viewonly(shifty.getpos(i))
  end))
  globalkeys = awful.util.table.join(globalkeys, awful.key({ modkey, "Control" }, tagkeys[i],
  function ()
    local t = shifty.getpos(i)
    t.selected = not t.selected
  end))
  globalkeys = awful.util.table.join(globalkeys, awful.key({ modkey, "Control", "Shift" }, tagkeys[i],
  function ()
    if client.focus then
      awful.client.toggletag(shifty.getpos(i))
    end
  end))
  -- move clients to other tags
  globalkeys = awful.util.table.join(globalkeys, awful.key({ modkey, "Shift" }, tagkeys[i],
    function ()
      if client.focus then
        local t = shifty.getpos(i)
        awful.client.movetotag(t)
        awful.tag.viewonly(t)
      end
    end))
end


clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "s",      function (c) c.ontop  = not c.ontop  end        ),
    awful.key({ modkey,           }, "s",      function (c) c.sticky = not c.sticky end        ),
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey           }, "c",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
--    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey, "Shift"   }, "r",      function (c) c:redraw()                       end),
  --  awful.key({ modkey,           }, "n",      function (c) c.minimized = not c.minimized    end),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
shifty.config.globalkeys = globalkeys
shifty.config.clientkeys = clientkeys

-- }}}


-- {{{ Rules
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = true,
                     keys = clientkeys,
                     buttons = clientbuttons } },
    { rule = { class = "MPlayer" },
      properties = { floating = true } },
    { rule = { class = "pinentry" },
      properties = { floating = true } },
    { rule = { class = "gimp" },
      properties = { floating = true } },
    -- Set Firefox to always map on tags number 2 of screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { tag = tags[1][2] } },
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
shifty.init()
client.add_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.add_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}

-- }}}
client.add_signal("focus", function(c)
  c.border_color = beautiful.border_focus
  if c.opacity < 1.0 then
    c.opacity = beautiful.opacity_focus
  end
end)

client.add_signal("unfocus", function(c)
  c.border_color = beautiful.border_normal
  if c.opacity < 1.0 then
    c.opacity = beautiful.opacity_normal
  end
end)

autorun = true
autorunApps =
{
   "xcompmgr -fF -D6 -cC -t -5 -l-6 -r5",
   "gnome-volume-control-applet"
}
if autorun then
  for app = 1, #autorunApps do
    awful.util.spawn(autorunApps[app])
  end
end

if file_exists("/home/ace/.config/awesome/rc-local.lua") then
  dofile "/home/ace/.config/awesome/rc-local.lua"
end

