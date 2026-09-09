-- Lua port of binds/bind_dwindle.conf
-- Movement for dwindle layout

local mainMod = "SUPER"

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

-- Move window with mainMod + SHIFT + arrow keys
hl.bind(mainMod .. " + SHIFT + left",  hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + up",    hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + down",  hl.dsp.window.move({ direction = "down" }))

-- Repeatable binds for resizing the active window
hl.bind(mainMod .. " + ALT + right", hl.dsp.window.resize({ x = 50,  y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + ALT + left",  hl.dsp.window.resize({ x = -50, y = 0, relative = true }), { repeating = true })
