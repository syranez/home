-- default rc.lua for shifty
--
-- Standard awesome library
require("awful")
-- Theme handling library
require("beautiful")
-- Notification library
require("naughty")
-- shifty - dynamic tagging library
require("shifty")
-- MacOSX-Expose
-- Siehe auch: https://awesome.naquadah.org/wiki/Revelation
-- Source: http://github.com/bioe007/awesome-configs/blob/master/revelation.lua
require("revelation")

-- useful for debugging, marks the beginning of rc.lua exec
print("Entered rc.lua: " .. os.time())

-- {{{ Variable definitions

-- Actually load theme
beautiful.init(awful.util.getdir("config") .. "/themes/syranez/theme.lua")

-- This is used later as the default terminal and editor to run.
browser = "firefox"
mail = "thunderbird"
terminal = "urxvt"
editor = os.getenv("EDITOR") or "vim"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key, I suggest you to remap
-- Mod4 to another key using xmodmap or other tools.  However, you can use
-- another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
layouts =
{
    awful.layout.suit.tile,
    awful.layout.suit.fair,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
--    awful.layout.suit.tile.top,
--    awful.layout.suit.magnifier,
--    awful.layout.suit.fair.horizontal,
    awful.layout.suit.max,
--    awful.layout.suit.max.fullscreen,
--    awful.layout.suit.floating
}

-- Define if we want to use titlebar on all applications.
use_titlebar = false
-- }}}

--{{{ Shifty configured tags.
shifty.config.tags = {
    ["Iol"]      = {
                     position = 1,
                     init     = true},
    ["www"]      = {
                     position = 2,
                     init     = true},
    ["marathon"] = {
                     position = 3,
                     init     = true},
    ["opera"]    = {
                     position = 4,
                     init     = true},
    ["chromium"] = {
                     position = 5,
                     init     = true},
    ["pw"]       = {
                     position = 6,
                     init     = true},
    ["naxos"]    = {
                     position = 7,
                     init     = true},
    ["skype"]    = {
                     position = 8,
                     init     = true},
}
--}}}

--{{{SHIFTY: application matching rules
-- order here matters, early rules will be applied first
shifty.config.apps = {
         { match = { "Navigator" }       , tag = "www"    } ,
         { match = { "skype" }           , tag = "skype"    } ,
         { match = { "opera" }           , tag = "opera"    } ,
         { match = { "chromium-browser" }, tag = "chromium"    } ,
         { match = { "keepassx" }        , tag = "pw"    } ,
}
--}}}

--{{{SHIFTY: default tag creation rules
-- parameter description
--  * floatBars : if floating clients should always have a titlebar
--  * guess_name : should shifty try and guess tag names when creating
--                 new (unconfigured) tags?
--  * guess_position: as above, but for position parameter
--  * run : function to exec when shifty creates a new tag
--  * all other parameters (e.g. layout, mwfact) follow awesome's tag API
shifty.config.defaults = {
    layout = awful.layout.suit.fair,
    ncol = 1,
    mwfact = 0.60,
    floatBars = true,
    guess_name = true,
    guess_position = true,
    }
--}}}

-- {{{Wibox
-- Create a textbox widget
mytextclock = awful.widget.textclock({align = "right"})

-- Create a laucher widget and a main menu
myawesomemenu = {
    {"manual", terminal .. " -e man awesome"},
    {"edit config",
     editor_cmd .. " " .. awful.util.getdir("config") .. "/rc.lua"},
    {"restart", awesome.restart},
    {"quit", awesome.quit}
}

mymainmenu = awful.menu(
    {items = {{"awesome", myawesomemenu, beautiful.awesome_icon},
              {"open terminal", terminal}}
          })

mylauncher = awful.widget.launcher({image = image(beautiful.awesome_icon),
                                     menu = mymainmenu})

-- Create a systray
mysystray = widget({type = "systray", align = "right"})

-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
    awful.button({}, 1, awful.tag.viewonly),
    awful.button({modkey}, 1, awful.client.movetotag),
    awful.button({}, 3, function(tag) tag.selected = not tag.selected end),
    awful.button({modkey}, 3, awful.client.toggletag),
    awful.button({}, 4, awful.tag.viewnext),
    awful.button({}, 5, awful.tag.viewprev)
    )

mytasklist = {}
mytasklist.buttons = awful.util.table.join(
    awful.button({}, 1, function(c)
        if not c:isvisible() then
            awful.tag.viewonly(c:tags()[1])
        end
        client.focus = c
        c:raise()
        end),
    awful.button({}, 3, function()
        if instance then
            instance:hide()
            instance = nil
        else
            instance = awful.menu.clients({width=250})
        end
        end),
    awful.button({}, 4, function()
        awful.client.focus.byidx(1)
        if client.focus then client.focus:raise() end
        end),
    awful.button({}, 5, function()
        awful.client.focus.byidx(-1)
        if client.focus then client.focus:raise() end
        end))

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] =
        awful.widget.prompt({layout = awful.widget.layout.leftright})
    -- Create an imagebox widget which will contains an icon indicating which
    -- layout we're using.  We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
            awful.button({}, 1, function() awful.layout.inc(layouts, 1) end),
            awful.button({}, 3, function() awful.layout.inc(layouts, -1) end),
            awful.button({}, 4, function() awful.layout.inc(layouts, 1) end),
            awful.button({}, 5, function() awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist.new(s,
                                            awful.widget.taglist.label.all,
                                            mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist.new(function(c)
                        return awful.widget.tasklist.label.currenttags(c, s)
                    end,
                                              mytasklist.buttons)

    -- Create the wibox
    mywibox[s] = awful.wibox({position = "top", screen = s})
    -- Add widgets to the wibox - order matters
    mywibox[s].widgets = {
        {
            mylauncher,
            mytaglist[s],
            mypromptbox[s],
            layout = awful.widget.layout.horizontal.leftright
        },
        mytextclock,
        s == 1 and mysystray or nil,
        mytasklist[s],
        layout = awful.widget.layout.horizontal.rightleft
        }

    mywibox[s].screen = s
end
-- }}}

--{{{SHIFTY: initialize shifty
-- the assignment of shifty.taglist must always be after its actually
-- initialized with awful.widget.taglist.new()
shifty.taglist = mytaglist
shifty.init()
--}}}

-- {{{Mouse bindings
root.buttons({
    awful.button({}, 3, function() mymainmenu:toggle() end),
    awful.button({}, 4, awful.tag.viewnext),
    awful.button({}, 5, awful.tag.viewprev)
})
-- }}}

-- {{{Key bindings
globalkeys = awful.util.table.join(
    -- Tags
    awful.key({modkey,}, "Left", awful.tag.viewprev),
    awful.key({modkey,}, "Right", awful.tag.viewnext),
    awful.key({modkey,}, "Escape", awful.tag.history.restore),

    -- Shifty: keybindings specific to shifty
    awful.key({modkey, "Shift"}, "d", shifty.del), -- delete a tag
    awful.key({modkey, "Shift"}, "n", shifty.send_prev), -- client to prev tag
    awful.key({modkey}, "n", shifty.send_next), -- client to next tag
    awful.key({modkey, "Control"}, "n", function()
        shifty.tagtoscr(awful.util.cycle(screen.count(), mouse.screen + 1))
    end), -- move client to next tag
    awful.key({modkey}, "a", shifty.add), -- creat a new tag
    awful.key({modkey,}, "r", function() shifty.rename() end),
    awful.key({modkey, "Shift"}, "a", -- nopopup new tag
    function()
        shifty.add({nopopup = true})
    end),

    awful.key({modkey,}, "j",
    function()
        awful.client.focus.byidx(1)
        if client.focus then client.focus:raise() end
    end),
    awful.key({modkey,}, "k",
    function()
        awful.client.focus.byidx(-1)
        if client.focus then client.focus:raise() end
    end),
    awful.key({modkey,}, "w", function() mymainmenu:show(true) end),

    -- Layout manipulation
    awful.key({modkey, "Shift"}, "j",
        function() awful.client.swap.byidx(1) end),
    awful.key({modkey, "Shift"}, "k",
        function() awful.client.swap.byidx(-1) end),
    awful.key({modkey, "Control"}, "j", function() awful.screen.focus(1) end),
    awful.key({modkey, "Control"}, "k", function() awful.screen.focus(-1) end),
    awful.key({modkey,}, "u", awful.client.urgent.jumpto),
    awful.key({modkey,}, "Tab",
    function()
        awful.client.focus.history.previous()
        if client.focus then
            client.focus:raise()
        end
    end),

    -- Standard program
    awful.key({modkey,}, "Return", function() awful.util.spawn(terminal) end),
    awful.key({modkey, "Control"}, "r", awesome.restart),
    awful.key({modkey, "Shift"}, "q", awesome.quit),

    awful.key({modkey,}, "l", function() awful.tag.incmwfact(0.05) end),
    awful.key({modkey,}, "h", function() awful.tag.incmwfact(-0.05) end),
    awful.key({modkey, "Shift"}, "h", function() awful.tag.incnmaster(1) end),
    awful.key({modkey, "Shift"}, "l", function() awful.tag.incnmaster(-1) end),
    awful.key({modkey, "Control"}, "h", function() awful.tag.incncol(1) end),
    awful.key({modkey, "Control"}, "l", function() awful.tag.incncol(-1) end),
    awful.key({modkey,}, "space", function() awful.layout.inc(layouts, 1) end),
    awful.key({modkey, "Shift"}, "space",
        function() awful.layout.inc(layouts, -1) end),

    -- Prompt
    awful.key({modkey}, "p", function()
        awful.prompt.run({prompt = "Run: "},
        mypromptbox[mouse.screen],
        awful.util.spawn, awful.completion.shell,
        awful.util.getdir("cache") .. "/history")
    end),

    awful.key({modkey}, "F4", function()
        awful.prompt.run({prompt = "Run Lua code: "},
        mypromptbox[mouse.screen],
        awful.util.eval, nil,
        awful.util.getdir("cache") .. "/history_eval")
    end),

    awful.key({modkey}, "b", function ()
        mywibox[mouse.screen].visible = not mywibox[mouse.screen].visible
    end),

    awful.key({modkey}, "e", revelation.revelation)
)

--{{{Client awful tagging: this is useful to tag some clients and then do stuff
-- like move to tag on them
--
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
-- SHIFTY: assign client keys to shifty for use in
-- match() function(manage hook)
shifty.config.clientkeys = clientkeys
shifty.config.modkey = modkey
--}}}

-- Compute the maximum number of digit we need, limited to 9
for i = 1, (shifty.config.maxtags or 9) do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({modkey}, i, function()
            local t =  awful.tag.viewonly(shifty.getpos(i))
            end),
        awful.key({modkey, "Control"}, i, function()
            local t = shifty.getpos(i)
            t.selected = not t.selected
            end),
        awful.key({modkey, "Control", "Shift"}, i, function()
            if client.focus then
                awful.client.toggletag(shifty.getpos(i))
            end
            end),
        -- move clients to other tags
        awful.key({modkey, "Shift"}, i, function()
            if client.focus then
                t = shifty.getpos(i)
                awful.client.movetotag(t)
                awful.tag.viewonly(t)
            end
        end))
    end

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{Hooks
-- Hook function to execute when focusing a client.
client.add_signal("focus", function(c)
    if not awful.client.ismarked(c) then
        c.border_color = beautiful.border_focus
    end
end)

-- Hook function to execute when unfocusing a client.
client.add_signal("unfocus", function(c)
    if not awful.client.ismarked(c) then
        c.border_color = beautiful.border_normal
    end
end)

client.add_signal("manage", function (c, startup)
    -- Add a titlebar
    awful.titlebar.add(c, { modkey = modkey })

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
-- }}}

-- vim: fdm=marker:tw=80:
