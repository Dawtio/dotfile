-- Lua port of binds/bind_master.conf
-- Movement for master layout

local mainMod = "SUPER"

-- Move focus through list of windows
hl.bind(mainMod .. " + up",   hl.dsp.layout("cyclenext"))
hl.bind(mainMod .. " + down", hl.dsp.layout("cycleprev"))
hl.bind(mainMod .. " + SHIFT + up",   hl.dsp.layout("swapnext"))
hl.bind(mainMod .. " + SHIFT + down", hl.dsp.layout("swapprev"))

-- Repeatable binds for resizing the active window
hl.bind(mainMod .. " + ALT + right", hl.dsp.window.resize({ x = 50,  y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + ALT + left",  hl.dsp.window.resize({ x = -50, y = 0, relative = true }), { repeating = true })

-- increase decrease master
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.layout("addmaster"))
hl.bind(mainMod .. " + SHIFT + left",  hl.dsp.layout("removemaster"))
