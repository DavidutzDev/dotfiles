-- Keybindings
--
-- Our own key map. Odyssey's layout supplies what we had no binding for
-- (monitor navigation, preselect, resize, extra workspace cycling); every key
-- that was already ours keeps the combo it always had.
--
-- Application launchers live in config/apps.lua. Odyssey's shell surfaces are
-- bound below rather than in ~/.config/hypr/odyssey.lua — see the note there.

local Hyprland = require("core")
local Ecosystem = Hyprland.Ecosystem

local mod = "SUPER"

local function odyssey(command)
	return hl.dsp.exec_cmd("odyssey ipc " .. command)
end

-- Odyssey shell surfaces.
--
-- These are deliberately NOT delegated to Odyssey's managed block in
-- ~/.config/hypr/odyssey.lua. That block is rendered by the running shell from
-- its own settings (services/ShortcutService.qml), so it is rewritten whenever
-- the shell starts and any change made with scripts/shortcutctl.sh is lost.
-- Binding them here keeps the keys ours and lets us pick our own combos.
--
-- Leave "Odyssey manages these shell shortcuts" OFF in Odyssey settings, or
-- every key below gains a duplicate on Odyssey's hardcoded combo.
hl.bind(mod .. " + space", odyssey("launcher toggle"))
hl.bind(mod .. " + C", odyssey("control-center toggle"))
hl.bind(mod .. " + V", odyssey("clipboard toggle"))
hl.bind(mod .. " + comma", odyssey("settings open"))
hl.bind(mod .. " + N", odyssey("notifications toggle"))
hl.bind(mod .. " + Y", odyssey("insights wallpaper"))
-- SUPER + L is the lock key we have always used; ALT + L is Odyssey's own and
-- costs nothing to keep. Region screenshots live on Print, so SUPER + SHIFT + S
-- stays free for the scratchpad and SUPER + SHIFT + F for the file manager.
hl.bind(mod .. " + L", odyssey("session lock"))
hl.bind(mod .. " + ALT + L", odyssey("session lock"))
hl.bind(mod .. " + SHIFT + R", odyssey("capture record region"))

-- Audio controls
hl.bind("XF86AudioRaiseVolume", odyssey("audio increment 3"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", odyssey("audio decrement 3"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", odyssey("audio mute"), { locked = true })
hl.bind("XF86AudioMicMute", odyssey("audio micmute"), { locked = true })

-- Application launchers
-- Terminal, browser and file manager live in config/apps.lua on our own keys.
hl.bind(mod .. " + SHIFT + C", hl.dsp.exec_cmd("code"))

-- Keyboard backlight
-- Uses the standard Linux keyboard-backlight LED device when available.
hl.bind("XF86KbdBrightnessUp", hl.dsp.exec_cmd("brightnessctl -d '*::kbd_backlight' set +1"), { repeating = true })
hl.bind("XF86KbdBrightnessDown", hl.dsp.exec_cmd("brightnessctl -d '*::kbd_backlight' set 1-"), { repeating = true })

-- Display brightness
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

-- Window management
-- SUPER + W closes and SUPER + M logs out, as they always have. Odyssey puts
-- close on Q, group toggle on W and fullscreen on M; Q is kept as a harmless
-- second close, group toggle moves to G, and Odyssey's SUPER + M fullscreen is
-- dropped because SUPER + CTRL + F already does exactly that.
hl.bind(mod .. " + W", hl.dsp.window.close())
hl.bind(mod .. " + Q", hl.dsp.window.close())
hl.bind(mod .. " + F", hl.dsp.window.fullscreen({ "fullscreen", "toggle" }))
hl.bind(mod .. " + T", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mod .. " + G", hl.dsp.group.toggle())
hl.bind(mod .. " + M", Ecosystem.actions.logout)

-- Focus navigation
hl.bind(mod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mod .. " + down", hl.dsp.focus({ direction = "down" }))
hl.bind(mod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mod .. " + right", hl.dsp.focus({ direction = "right" }))

-- Window movement
hl.bind(mod .. " + SHIFT + left", hl.dsp.window.move({ direction = "left" }))
hl.bind(mod .. " + SHIFT + down", hl.dsp.window.move({ direction = "down" }))
hl.bind(mod .. " + SHIFT + up", hl.dsp.window.move({ direction = "up" }))
hl.bind(mod .. " + SHIFT + right", hl.dsp.window.move({ direction = "right" }))

-- Monitor navigation
hl.bind(mod .. " + CTRL + left", hl.dsp.focus({ monitor = "left" }))
hl.bind(mod .. " + CTRL + right", hl.dsp.focus({ monitor = "right" }))
hl.bind(mod .. " + CTRL + H", hl.dsp.focus({ monitor = "left" }))
hl.bind(mod .. " + CTRL + J", hl.dsp.focus({ monitor = "down" }))
hl.bind(mod .. " + CTRL + K", hl.dsp.focus({ monitor = "up" }))
hl.bind(mod .. " + CTRL + L", hl.dsp.focus({ monitor = "right" }))

-- Move window to monitor
hl.bind(mod .. " + SHIFT + CTRL + left", hl.dsp.window.move({ monitor = "left" }))
hl.bind(mod .. " + SHIFT + CTRL + down", hl.dsp.window.move({ monitor = "down" }))
hl.bind(mod .. " + SHIFT + CTRL + up", hl.dsp.window.move({ monitor = "up" }))
hl.bind(mod .. " + SHIFT + CTRL + right", hl.dsp.window.move({ monitor = "right" }))
hl.bind(mod .. " + SHIFT + CTRL + H", hl.dsp.window.move({ monitor = "left" }))
hl.bind(mod .. " + SHIFT + CTRL + J", hl.dsp.window.move({ monitor = "down" }))
hl.bind(mod .. " + SHIFT + CTRL + K", hl.dsp.window.move({ monitor = "up" }))
hl.bind(mod .. " + SHIFT + CTRL + L", hl.dsp.window.move({ monitor = "right" }))

-- Workspace navigation
hl.bind(mod .. " + Page_Down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mod .. " + Page_Up", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mod .. " + U", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mod .. " + I", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mod .. " + CTRL + down", hl.dsp.window.move({ workspace = "e+1" }))
hl.bind(mod .. " + CTRL + up", hl.dsp.window.move({ workspace = "e-1" }))
hl.bind(mod .. " + CTRL + U", hl.dsp.window.move({ workspace = "e+1" }))
hl.bind(mod .. " + CTRL + I", hl.dsp.window.move({ workspace = "e-1" }))

-- Move window to workspace
hl.bind(mod .. " + SHIFT + Page_Down", hl.dsp.window.move({ workspace = "e+1" }))
hl.bind(mod .. " + SHIFT + Page_Up", hl.dsp.window.move({ workspace = "e-1" }))
hl.bind(mod .. " + SHIFT + U", hl.dsp.window.move({ workspace = "e+1" }))
hl.bind(mod .. " + SHIFT + I", hl.dsp.window.move({ workspace = "e-1" }))

-- Mouse-wheel workspace navigation
hl.bind(mod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mod .. " + SHIFT + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mod .. " + SHIFT + mouse_up", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mod .. " + CTRL + mouse_down", hl.dsp.window.move({ workspace = "e+1" }))
hl.bind(mod .. " + CTRL + mouse_up", hl.dsp.window.move({ workspace = "e-1" }))

-- Numbered workspaces
for i = 1, 9 do
	hl.bind(mod .. " + " .. i, hl.dsp.focus({ workspace = i }))
	hl.bind(mod .. " + SHIFT + " .. i, hl.dsp.window.move({ workspace = i }))
	hl.bind(mod .. " + ALT + " .. i, hl.dsp.window.move({ workspace = i, silent = true }))
end

-- Workspace 10 keeps the key Odyssey leaves free; Discord and Spotify open there.
hl.bind(mod .. " + 0", hl.dsp.focus({ workspace = 10 }))
hl.bind(mod .. " + SHIFT + 0", hl.dsp.window.move({ workspace = 10 }))
hl.bind(mod .. " + ALT + 0", hl.dsp.window.move({ workspace = 10, silent = true }))

-- Special workspaces
-- SUPER + S and SUPER + SHIFT + S are the scratchpad keys we have always used.
-- Odyssey's F1/F2 set is kept alongside; it collides with nothing.
hl.bind(mod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))
hl.bind(mod .. " + F1", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mod .. " + SHIFT + F1", hl.dsp.window.move({ workspace = "special:magic" }))
hl.bind(mod .. " + ALT + F1", hl.dsp.window.move({ workspace = "special:magic", silent = true }))
hl.bind(mod .. " + F2", hl.dsp.workspace.toggle_special("magic1"))
hl.bind(mod .. " + SHIFT + F2", hl.dsp.window.move({ workspace = "special:magic1" }))
hl.bind(mod .. " + ALT + F2", hl.dsp.window.move({ workspace = "special:magic1", silent = true }))

-- Layout management
hl.bind(mod .. " + bracketleft", hl.dsp.layout("preselect l"))
hl.bind(mod .. " + bracketright", hl.dsp.layout("preselect r"))
hl.bind(mod .. " + J", hl.dsp.layout("togglesplit"))
hl.bind(mod .. " + CTRL + F", hl.dsp.window.fullscreen())
hl.bind(mod .. " + P", hl.dsp.window.pseudo())

-- Mouse move / resize
hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })
hl.bind(mod .. " + Z", hl.dsp.window.drag(), { mouse = true })
hl.bind(mod .. " + X", hl.dsp.window.resize(), { mouse = true })

-- Resize by keycode
hl.bind(mod .. " + code:20", hl.dsp.window.resize({ x = -100, y = 0 }), { description = "Expand window left" })
hl.bind(mod .. " + code:21", hl.dsp.window.resize({ x = 100, y = 0 }), { description = "Shrink window left" })

-- Manual sizing
hl.bind(mod .. " + minus", hl.dsp.window.resize({ x = -50, y = 0 }), { repeating = true })
hl.bind(mod .. " + equal", hl.dsp.window.resize({ x = 50, y = 0 }), { repeating = true })
hl.bind(mod .. " + SHIFT + minus", hl.dsp.window.resize({ x = 0, y = -50 }), { repeating = true })
hl.bind(mod .. " + SHIFT + equal", hl.dsp.window.resize({ x = 0, y = 50 }), { repeating = true })

-- Screenshots and Odyssey power control
hl.bind("XF86Launch1", odyssey("power cycle"))
hl.bind("CTRL + XF86Launch1", odyssey("capture screenshot full copy"))
hl.bind("ALT + XF86Launch1", odyssey("capture screenshot active copy"))
-- Print takes the region screenshot, saved and copied, the way the old satty
-- binding did. SUPER + SHIFT + F is the file manager, not a screenshot key.
hl.bind("Print", odyssey("capture screenshot region both"))
hl.bind("CTRL + Print", odyssey("capture screenshot full copy"))
hl.bind("ALT + Print", odyssey("capture screenshot active copy"))

-- Personal bindings Odyssey has no equivalent for.
-- Power actions live in Odyssey's island SessionPage, so no powermenu key here.
hl.bind(mod .. " + Backspace", hl.dsp.exec_cmd("~/.local/bin/mic-toggle"))
hl.bind(mod .. " + R", Ecosystem.actions.reload)

-- Media transport; Odyssey exposes no player IPC target.
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl --player=spotify,%any play-pause"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl --player=spotify,%any play-pause"), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl --player=spotify,%any next"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl --player=spotify,%any previous"), { locked = true })
hl.bind("XF86AudioStop", hl.dsp.exec_cmd("playerctl --player=spotify,%any stop"), { locked = true })
