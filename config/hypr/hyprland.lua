-- Lua port of hyprland.conf
-- Refer to the wiki for more information.
-- https://wiki.hypr.land/Configuring/Start/
--
-- NOTE: if this file exists, Hyprland loads it EXCLUSIVELY and ignores
-- hyprland.conf entirely. The old hyprland.conf is left untouched on disk
-- so you can switch back by simply removing/renaming this file.

local colors = require("colors.colors")

require("hyprland_bind")

-- ################
-- ### MONITORS ###
-- ################

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
--
-- Fixed layout (explicit positions, not "auto" -- the old config only ever
-- had a rule for ONE of the two dock monitors, so the second always fell
-- back to unpredictable auto-placement; that was the source of the old
-- monitor-placement bug):
--
--   [ HY5D444 2560x1440 ][ GY5D444 2560x1440 ]   <- both externals, top row
--         [   eDP-1 1920x1200, centered   ]      <- laptop, below
--
-- All logical (post-scale) sizes. Laptop x = (5120 - 1920) / 2 = 1600.
hl.monitor({ output = "desc:Dell Inc. DELL S3225QC HY5D444", mode = "3840x2160@60", position = "0x0",    scale = 1.5 }) -- left external
hl.monitor({ output = "desc:Dell Inc. DELL S3225QC GY5D444", mode = "3840x2160@60", position = "2560x0", scale = 1.5 }) -- right external
hl.monitor({ output = "eDP-1", mode = "2880x1800@60", position = "1600x1440", scale = 1.5 }) -- laptop, centered below

-- Lid switch.
hl.bind("switch:on:Lid Switch",  hl.dsp.exec_cmd("~/.config/hypr/scripts/lid.sh close"), { locked = true })
hl.bind("switch:off:Lid Switch", hl.dsp.exec_cmd("~/.config/hypr/scripts/lid.sh open"),  { locked = true })

-- #################
-- ### AUTOSTART ###
-- #################

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:
hl.on("hyprland.start", function()
    hl.exec_cmd("waybar & awww-daemon & swaync")
    hl.exec_cmd("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")
    hl.exec_cmd("hyprpm reload")
end)


-- #############################
-- ### ENVIRONMENT VARIABLES ###
-- #############################

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")
hl.env("ANV_DEBUG", "video-decode,video-encode")
hl.env("VDPAU_DRIVER", "va_gl")
hl.env("LIBVA_DRIVER_NAME", "iHD")

-- ###################
-- ### PERMISSIONS ###
-- ###################

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Permissions/
-- Please note permission changes here require a Hyprland restart and are not applied on-the-fly
-- for security reasons

-- hl.config({
--   ecosystem = {
--     enforce_permissions = true,
--   },
-- })

hl.permission("/usr/(bin|local/bin)/grim", "screencopy", "allow")
-- hl.permission("/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", "screencopy", "allow")
hl.permission("/usr/(bin|local/bin)/hyprpm", "plugin", "allow")


-- #####################
-- ### LOOK AND FEEL ###
-- #####################

-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({
    general = {
        gaps_in  = 5,
        gaps_out = 20,

        border_size = 2,

        col = {
            active_border   = colors.grey0,
            inactive_border = colors.bg1,
        },

        -- Set to true enable resizing windows by clicking and dragging on borders and gaps
        resize_on_border = true,

        -- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
        allow_tearing = false,

        layout = "scrolling",
    },

    decoration = {
        rounding       = 15,
        rounding_power = 6,

        -- Change transparency of focused and unfocused windows
        active_opacity   = 1.0,
        inactive_opacity = 0.8,

        shadow = {
            enabled      = true,
            range        = 13,
            render_power = 3,
            color        = colors.bg3,
        },

        -- https://wiki.hypr.land/Configuring/Basics/Variables/#blur
        blur = {
            enabled  = true,
            size     = 15,
            passes   = 2,

            vibrancy           = 0.5,
            vibrancy_darkness  = 0.5,
        },
    },

    animations = {
        enabled = true,
    },
})

-- Default curves, see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1},    {0.32, 1}    } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1}    } })
hl.curve("linear",         { type = "bezier", points = { {0, 0},       {1, 1}       } })
hl.curve("almostLinear",   { type = "bezier", points = { {0.5, 0.5},   {0.75, 1}    } })
hl.curve("quick",          { type = "bezier", points = { {0.15, 0},    {0.1, 1}     } })

-- Default animations, see https://wiki.hypr.land/Configuring/Basics/Animations/
hl.animation({ leaf = "global",        enabled = true, speed = 10,   bezier = "default" })
hl.animation({ leaf = "border",        enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows",       enabled = true, speed = 4.79, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn",     enabled = true, speed = 4.1,  bezier = "easeOutQuint", style = "popin 87%" })
hl.animation({ leaf = "windowsOut",    enabled = true, speed = 1.49, bezier = "linear",       style = "popin 87%" })
hl.animation({ leaf = "fadeIn",        enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut",       enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade",          enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers",        enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn",      enabled = true, speed = 4,    bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut",     enabled = true, speed = 1.5,  bezier = "linear",       style = "fade" })
hl.animation({ leaf = "fadeLayersIn",  enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces",    enabled = true, speed = 1.94, bezier = "almostLinear", style = "slidevert" })
hl.animation({ leaf = "workspacesIn",  enabled = true, speed = 1.21, bezier = "almostLinear", style = "slidevert" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear", style = "slidevert" })
hl.animation({ leaf = "zoomFactor",    enabled = true, speed = 7,    bezier = "quick" })

-- Ref https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/
-- "Smart gaps" / "No gaps when only"
-- uncomment all if you wish to use that.
-- hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
-- hl.workspace_rule({ workspace = "f[1]",   gaps_out = 0, gaps_in = 0 })
-- hl.window_rule({
--     name  = "no-gaps-wtv1",
--     match = { float = false, workspace = "w[tv1]" },
--     border_size = 0,
--     rounding    = 0,
-- })
-- hl.window_rule({
--     name  = "no-gaps-f1",
--     match = { float = false, workspace = "f[1]" },
--     border_size = 0,
--     rounding    = 0,
-- })

-- See https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/ for more
hl.config({
    dwindle = {
        -- pseudotile = true, -- Master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
        preserve_split = true, -- You probably want this
    },
})

-- See https://wiki.hypr.land/Configuring/Layouts/Master-Layout/ for more
hl.config({
    master = {
        new_status = "master",
    },
})

-- https://wiki.hypr.land/Configuring/Basics/Variables/#misc
hl.config({
    misc = {
        force_default_wallpaper = -1,    -- Set to 0 or 1 to disable the anime mascot wallpapers
        disable_hyprland_logo   = false, -- If true disables the random hyprland logo / anime girl background. :(
    },
})

-- See https://wiki.hypr.land/Configuring/Layouts/Scrolling-Layout/ for more
-- (built into core now -- no longer a hyprpm plugin, unlike in your old hyprland.conf)
hl.config({
    scrolling = {
        column_width = 0.98,
        fullscreen_on_one_column = true,
    },
})

-- #############
-- ### INPUT ###
-- #############

-- https://wiki.hypr.land/Configuring/Basics/Variables/#input
hl.config({
    input = {
        kb_layout  = "us",
        kb_variant = "altgr-intl",
        kb_model   = "",
        kb_options = "",
        kb_rules   = "",

        follow_mouse = 1,

        sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

        touchpad = {
            natural_scroll = false,
        },
    },
})

-- Clavier Bluetooth Epomaker Tide Alice
hl.device({
    name       = "tide-alice-3-keyboard",
    kb_layout  = "us",
    kb_variant = "altgr-intl",

    -- Remap : Left Alt -> Super
    kb_options = "altwin:swap_lalt_lwin",
})

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/mouse for gestures
hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })

-- Example per-device config
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/per-device for more
hl.device({
    name        = "epic-mouse-v1",
    sensitivity = -0.5,
})

-- ##############################
-- ### WINDOWS AND WORKSPACES ###
-- ##############################

-- See https://wiki.hypr.land/Configuring/Core/Rules/window-rules/ for more
-- See https://wiki.hypr.land/Configuring/Core/Rules/workspace-rules/ for workspace rules

hl.window_rule({
    -- Ignore maximize requests from all apps. You'll probably like this.
    name  = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})

hl.window_rule({
    -- Fix some dragging issues with XWayland
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})

-- Fix windows mode for NetworkManager, blueman
hl.window_rule({
    name  = "fix-networkmanager-mode",
    match = { title = "^(.*Network Manager.*)$" },

    float = true,
    size  = { "(monitor_w*0.5)+17", "(monitor_h*0.4)" },
})

hl.window_rule({
    name  = "fix-blueman-mode",
    match = { title = "^(.*Bluetooth Devices.*)$" },

    float = true,
    size  = { "(monitor_w*0.5)+17", "(monitor_h*0.4)" },
})
