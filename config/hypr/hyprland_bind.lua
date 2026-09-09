-- Lua port of hyprland_bind.conf

require("binds.bind_master")

---------------------
---- MY PROGRAMS ----
---------------------

local terminal    = "kitty"
local fileManager = "thunar"
local menu        = "~/.config/rofi/launchers/minimal/launcher.sh"

---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER" -- Sets "Windows" key as main modifier

-- Basic
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + C",      hl.dsp.window.close())
hl.bind(mainMod .. " + E",      hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + P",      hl.dsp.exec_cmd('grim -g "$(slurp)" ~/screenshots/$(date +%Y_%h_%d__%H_%M).png'))
hl.bind(mainMod .. " + A",      hl.dsp.exec_cmd("swaync-client -t"))
hl.bind(mainMod .. " + M",      hl.dsp.exit())

-- View
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + V", hl.dsp.window.float())
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("hyprlock -c ~/.config/hypr/hyprlock/hyprlock.conf"))
hl.bind("CTRL + ALT + DELETE", hl.dsp.exec_cmd("~/.config/wlogout/wlogout.sh"))

-- ROFI menus
hl.bind(mainMod .. " + R",         hl.dsp.exec_cmd("pkill rofi || " .. menu))
hl.bind(mainMod .. " + T",         hl.dsp.exec_cmd("~/.config/colorschemes/rofi-launcher.sh"))
hl.bind(mainMod .. " + SHIFT + T", hl.dsp.exec_cmd("~/.config/colorschemes/wallpaper-selector.sh"))
hl.bind(mainMod .. " + I",         hl.dsp.exec_cmd("~/.config/hypr/scripts/layout-switcher.sh"))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key,         hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Example special workspace (scratchpad)
hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume",   hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { repeating = true, locked = true })
hl.bind("XF86AudioLowerVolume",   hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),       { repeating = true, locked = true })
hl.bind("XF86AudioMute",          hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),      { repeating = true, locked = true })
hl.bind("XF86AudioMicMute",       hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),    { repeating = true, locked = true })
hl.bind("XF86MonBrightnessUp",    hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                   { repeating = true, locked = true })
hl.bind("XF86MonBrightnessDown",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                   { repeating = true, locked = true })

-- Requires playerctl
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })
