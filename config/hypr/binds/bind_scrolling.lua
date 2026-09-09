-- Lua port of binds/bind_scrolling.conf
-- Movement binds for the scrolling layout.

local mainMod = "SUPER"

hl.bind(mainMod .. " + right", hl.dsp.layout("move +col"))
hl.bind(mainMod .. " + left",  hl.dsp.layout("move -col"))

hl.bind(mainMod .. " + SHIFT + right", hl.dsp.layout("movewindowto r"))
hl.bind(mainMod .. " + SHIFT + left",  hl.dsp.layout("movewindowto l"))
hl.bind(mainMod .. " + SHIFT + up",    hl.dsp.layout("movewindowto u"))
hl.bind(mainMod .. " + SHIFT + down",  hl.dsp.layout("movewindowto d"))
