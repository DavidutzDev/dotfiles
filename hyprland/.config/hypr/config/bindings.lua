local Hyprland = require("core")
local Bindings = Hyprland.Bindings
local Ecosystem = Hyprland.Ecosystem
local mod = Hyprland.Bindings.Modifiers
local menu = Hyprland.Applications.get("menu").cmd

-- menu modes
Bindings.Bind(Bindings.NewLeader({}, "ESCAPE"), function()
	hl.exec_cmd(menu .. " -m menus:powermenu")
end)
Bindings.Bind(Bindings.NewLeader({}, "F1"), function()
	hl.exec_cmd(menu .. " -m menus:wallpapers")
end)

Bindings.Bind(Bindings.NewLeader({}, "L"), Ecosystem.actions.lock)
Bindings.Bind(Bindings.NewLeader({}, "R"), Ecosystem.actions.reload)
Bindings.Bind(Bindings.NewLeader({}, "M"), Ecosystem.actions.logout)
Bindings.Bind(Bindings.New({}, "PRINT"), Ecosystem.actions.screenshot)

-- window management
Bindings.Bind(Bindings.NewLeader({}, "W"), hl.dsp.window.close())
Bindings.Bind(Bindings.NewLeader({}, "F"), hl.dsp.window.fullscreen({ "fullscreen", "toggle" }))
Bindings.Bind(Bindings.NewLeader({}, "T"), hl.dsp.window.float())
Bindings.Bind(Bindings.NewLeader({}, "V"), hl.dsp.window.float({ action = "toggle" }))
Bindings.Bind(Bindings.NewLeader({}, "P"), hl.dsp.window.pseudo())
Bindings.Bind(Bindings.NewLeader({}, "J"), hl.dsp.layout("togglesplit"))

-- focus movement
Bindings.Bind(Bindings.NewLeader({}, "left"), hl.dsp.focus({ direction = "left" }))
Bindings.Bind(Bindings.NewLeader({}, "right"), hl.dsp.focus({ direction = "right" }))
Bindings.Bind(Bindings.NewLeader({}, "up"), hl.dsp.focus({ direction = "up" }))
Bindings.Bind(Bindings.NewLeader({}, "down"), hl.dsp.focus({ direction = "down" }))

-- workspaces: SUPER + [0-9] to switch, SUPER + SHIFT + [0-9] to move active window
for i = 1, 10 do
	local key = tostring(i % 10) -- 10 maps to key 0
	Bindings.Bind(Bindings.NewLeader({}, key), hl.dsp.focus({ workspace = i }))
	Bindings.Bind(Bindings.NewLeader({ mod.SHIFT }, key), hl.dsp.window.move({ workspace = i }))
end

-- special workspace (scratchpad)
Bindings.Bind(Bindings.NewLeader({}, "S"), hl.dsp.workspace.toggle_special("magic"))
Bindings.Bind(Bindings.NewLeader({ mod.SHIFT }, "S"), hl.dsp.window.move({ workspace = "special:magic" }))

-- scroll through workspaces
Bindings.Bind(Bindings.NewLeader({}, "mouse_down"), hl.dsp.focus({ workspace = "e+1" }))
Bindings.Bind(Bindings.NewLeader({}, "mouse_up"), hl.dsp.focus({ workspace = "e-1" }))
Bindings.Bind(Bindings.NewLeader({ mod.SHIFT }, "mouse_down"), hl.dsp.focus({ workspace = "e+1" }))
Bindings.Bind(Bindings.NewLeader({ mod.SHIFT }, "mouse_up"), hl.dsp.focus({ workspace = "e-1" }))

-- move / resize with mouse drag
Bindings.Bind(Bindings.NewLeader({}, "mouse:272"), hl.dsp.window.drag(), { mouse = true })
Bindings.Bind(Bindings.NewLeader({}, "mouse:273"), hl.dsp.window.resize(), { mouse = true })

-- multimedia keys (locked = works while screen locked, repeating = holds)
Bindings.Bind(
	Bindings.New({}, "XF86AudioRaiseVolume"),
	hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
	{ locked = true, repeating = true }
)
Bindings.Bind(
	Bindings.New({}, "XF86AudioLowerVolume"),
	hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%-"),
	{ locked = true, repeating = true }
)
Bindings.Bind(
	Bindings.New({}, "XF86AudioMute"),
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
	{ locked = true }
)
Bindings.Bind(
	Bindings.New({}, "XF86AudioMicMute"),
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
	{ locked = true }
)
Bindings.Bind(
	Bindings.New({}, "XF86MonBrightnessUp"),
	hl.dsp.exec_cmd("brightnessctl s 5%+"),
	{ locked = true, repeating = true }
)
Bindings.Bind(
	Bindings.New({}, "XF86MonBrightnessDown"),
	hl.dsp.exec_cmd("brightnessctl s 5%-"),
	{ locked = true, repeating = true }
)
