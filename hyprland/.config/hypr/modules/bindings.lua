---------------------
---- KEYBINDINGS ----
---------------------
local apps = require("config.apps")

local mainMod = "SUPER"

hl.bind(mainMod .. " + W", hl.dsp.window.close())
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ "fullscreen", "toggle" }))
hl.bind(mainMod .. " + T", hl.dsp.window.float())
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd("hyprctl reload"))
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("hyprlock"))

hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(apps:get_launch("terminal")))
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd(apps:get_launch("notifications")))
hl.bind("PRINT", hl.dsp.exec_cmd("hyprshot -m region --raw | satty --filename -"))

hl.bind(mainMod .. "+ SHIFT + F", hl.dsp.exec_cmd(apps:get_launch("fileManager")))
hl.bind(mainMod .. "+ SHIFT + B", hl.dsp.exec_cmd(apps:get_launch("browser")))
hl.bind(mainMod .. "+ SHIFT + M", hl.dsp.exec_cmd(apps:get_launch("music")))

hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd(apps:get_launch("menu")))
hl.bind(mainMod .. " + ESCAPE", hl.dsp.exec_cmd(apps:get_launch("menu") .. " -m menus:powermenu"))
hl.bind(mainMod .. " + F1", hl.dsp.exec_cmd(apps:get_launch("menu") .. " -m menus:wallpapers"))

hl.bind(
	mainMod .. " + M",
	hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'")
)
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit")) -- dwindle only

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
	local key = i % 10 -- 10 maps to key 0
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Example special workspace (scratchpad)
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

hl.bind(mainMod .. " + SHIFT + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + SHIFT + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
	{ locked = true, repeating = true }
)
