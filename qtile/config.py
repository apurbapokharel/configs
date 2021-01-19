# Copyright (c) 2008 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

from typing import List  # noqa: F401

from libqtile import bar, layout, widget
from libqtile.config import Click, Drag, Group, Key, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal

mod = "mod4"
terminal = guess_terminal()

keys = [
    Key([mod], "h", lazy.layout.left()),
    Key([mod], "l", lazy.layout.right()),
    Key([mod], "j", lazy.layout.down()),
    Key([mod], "k", lazy.layout.up()),
    Key([mod, "shift"], "h", lazy.layout.swap_left()),
    Key([mod, "shift"], "l", lazy.layout.swap_right()),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down()),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up()),
    Key([mod, "control"], "j", lazy.layout.grow()),
    Key([mod, "control"], "k", lazy.layout.shrink()),
    Key([mod, "control"], "l", lazy.layout.normalize()),
    Key([mod, "control"], "h", lazy.layout.maximize()),
    Key([mod, "shift"], "space", lazy.layout.flip()),
    # Switch between windows in current stack pane
    #Key([mod], "k", lazy.layout.down(),
    #    desc="Move focus down in stack pane"),
    #Key([mod], "j", lazy.layout.up(),
    #    desc="Move focus up in stack pane"),

    # Move windows up or down in current stack
    #Key([mod, "control"], "k", lazy.layout.shuffle_down(),
    #    desc="Move window down in current stack "),
    #Key([mod, "control"], "j", lazy.layout.shuffle_up(),
    #    desc="Move window up in current stack "),

    # Switch window focus to other pane(s) of stack
    Key([mod], "space", lazy.layout.next(),
        desc="Switch window focus to other pane(s) of stack"),

    # Swap panes of split stack
    Key([mod, "shift"], "space", lazy.layout.rotate(),
        desc="Swap panes of split stack"),

    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    #Key([mod, "shift"], "Return", lazy.layout.toggle_split(),
    #    desc="Toggle between split and unsplit sides of stack"),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),

    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "w", lazy.window.kill(), desc="Kill focused window"),

    Key([mod, "control"], "r", lazy.restart(), desc="Restart qtile"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown qtile"),
    Key([mod], "r", lazy.spawn("rofi -show run"),
        desc="Spawn a command using a prompt widget"),
    Key([], 'XF86AudioLowerVolume', lazy.spawn('amixer sset Master,0 2%-')),
    Key([], 'XF86AudioRaiseVolume', lazy.spawn('amixer sset Master,0 2%+')),
    Key([], 'XF86AudioMute', lazy.spawn('amixer sset Master,0 toggle')),
    Key([], 'XF86AudioPlay',
        lazy.spawn(
            'dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify '
            '/org/mpris/MediaPlayer2 '
            'org.mpris.MediaPlayer2.Player.PlayPause')),
    Key([], 'XF86AudioStop',
        lazy.spawn(
            'dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify '
            '/org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Stop')),
    Key([], 'XF86AudioNext',
        lazy.spawn(
            'dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify '
            '/org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Next')),
    Key([], 'XF86AudioPrev',
        lazy.spawn(
            'dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify '
            '/org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Previous')),
    Key([], 'XF86MonBrightnessDown', lazy.spawn('brightnessctl s 50-')),
    Key([], 'XF86MonBrightnessUp', lazy.spawn('brightnessctl s +50')),
]

groups = [Group(i) for i in "12345678"] 

for i in groups:
    keys.extend([
        # mod1 + letter of group = switch to group
        Key([mod], i.name, lazy.group[i.name].toscreen(),
            desc="Switch to group {}".format(i.name)),

        # mod1 + shift + letter of group = switch to & move focused window to group
        Key([mod, "shift"], i.name, lazy.window.togroup(i.name, switch_group=True),
            desc="Switch to & move focused window to group {}".format(i.name)),
        # Or, use below if you prefer not to switch to that group.
        # # mod1 + shift + letter of group = move focused window to group
        # Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
        #     desc="move focused window to group {}".format(i.name)),
    ])

colors = [["#282c34", "#282c34"], # panel background
          ["#434758", "#434758"], # background for current screen tab
          ["#ffffff", "#ffffff"], # font color for group names
          ["#ff5555", "#ff5555"], # border line color for current tab
          ["#8d62a9", "#8d62a9"], # border line color for other tab and odd widgets
          ["#668bd7", "#668bd7"], # color for the even widgets
          ["#e1acff", "#e1acff"], # window name
          ["#2D3142","#2D3142"],
          ["#4D7EA8","#4D7EA8"],
          ["#AFAFAF","#AFAFAF"]] # gray

layout_theme = {"border_width": 2,
                "margin": 16,
                "border_focus": "#B0D7FF",
                "border_normal": "1D2330"
                }

layouts = [
    # Try more layouts by unleashing below layouts.
    layout.MonadTall(ratio=0.60, **layout_theme),
    layout.Tile(shift_windows=True, **layout_theme),
    layout.Columns(fair=True, **layout_theme),
    layout.Max(**layout_theme),
    layout.Floating(**layout_theme)

]

widget_defaults = dict(
    font='sans',
    fontsize=28,
    padding=10,
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.Sep(
                       linewidth = 0,
                       padding = 12,
                       ),
                widget.Sep(
                       linewidth = 0,
                       padding = 12,
                       ),
                widget.GroupBox(
                       fontsize = 22,
                       margin_y = 6,
                       margin_x = 0,
                       padding_y = 10,
                       padding_x = 6,
                       borderwidth = 3,
                       active = colors[2],
                       inactive = colors[2],
                       rounded = False,
                       highlight_method = "text",
                       highlight_color = colors[1],
                       this_current_screen_border = colors[3],
                       this_screen_border = colors [4],
                       other_current_screen_border = colors[0],
                       other_screen_border = colors[0],
                       foreground = colors[2],
                       background = colors[7]
                       ),
                widget.Sep(
                       linewidth = 0,
                       padding = 8,
                       ),
                widget.WindowName(
                    font="Ubuntu Mono",
                    foreground = colors[9],
                    ),
                #widget.Chord(
                #    chords_colors={
                #        'launch': ("#ff0000", "#ffffff"),
                #    },
                #    name_transform=lambda name: name.upper(),
                #    ),
                widget.CurrentLayout(),
                widget.Sep(
                       linewidth = 0,
                       padding = 6,
                       foreground = colors[2],
                       background = colors[5]
                       ),
                widget.CPUGraph(),
                widget.Sep(
                       linewidth = 0,
                       padding = 6,
                       foreground = colors[2],
                       background = colors[5]
                       ),
                widget.TextBox(
                       text = " V:",
                       foreground = colors[2],
                       padding = 0
                       ),
                widget.Volume(
                       foreground = colors[2],
                       background = colors[7],
                       padding = 5
                       ),
                widget.Sep(
                       linewidth = 0,
                       padding = 6,
                       foreground = colors[2],
                       background = colors[8]
                       ),
                widget.Battery(
                        format = 'B: {percent:2.0%}'
                        ),
                widget.Sep(
                       linewidth = 0,
                       padding = 6,
                       foreground = colors[2],
                       background = colors[8]
                       ),
                widget.Pomodoro(
                        color_inactive="#00649f",
                        color_active="#008565"
                        ),
                widget.Sep(
                       linewidth = 0,
                       padding = 6,
                       foreground = colors[2],
                       background = colors[8]
                       ),
                widget.Clock(
                       foreground = colors[2],
                       format = " %B %d  [ %H:%M ]"
                       ),
                widget.Sep(
                       linewidth = 0,
                       padding = 10,
                       foreground = colors[0],
                       background = colors[8]
                       ),
                widget.Notify(),
            ],
            32,
        ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
main = None  # WARNING: this is deprecated and will be removed soon
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(float_rules=[
    # Run the utility of `xprop` to see the wm class and name of an X client.
    {'wmclass': 'confirm'},
    {'wmclass': 'dialog'},
    {'wmclass': 'download'},
    {'wmclass': 'error'},
    {'wmclass': 'file_progress'},
    {'wmclass': 'notification'},
    {'wmclass': 'splash'},
    {'wmclass': 'toolbar'},
    {'wmclass': 'confirmreset'},  # gitk
    {'wmclass': 'makebranch'},  # gitk
    {'wmclass': 'maketag'},  # gitk
    {'wname': 'branchdialog'},  # gitk
    {'wname': 'pinentry'},  # GPG key password entry
    {'wmclass': 'ssh-askpass'},  # ssh-askpass
])
auto_fullscreen = True
focus_on_window_activation = "smart"

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
