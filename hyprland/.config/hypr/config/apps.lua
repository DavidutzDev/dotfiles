local Hyprland = require("core")
local mod = Hyprland.Bindings.Modifiers

Hyprland.Applications.register({
	name = "screenshot-utility",
	cmd = "satty",
	class = "com.gabm.satty",
	float = true,
})

Hyprland.Applications.register({
	name = "wallpaper",
	cmd = "awww-daemon",
	autostart = true,
})

Hyprland.Applications.register({
	name = "terminal",
	cmd = "ghostty",
	class = "com.mitchellh.ghostty",
	binding = Hyprland.Bindings.NewLeader({}, "RETURN"),
})

Hyprland.Applications.register({
	name = "browser",
	cmd = "zen-browser",
	binding = Hyprland.Bindings.NewLeader({}, "B"),
})

Hyprland.Applications.register({
	name = "discord",
	cmd = "legcord --enable-features=UseOzonePlatform,WebRTCPipeWireCapturer --ozone-platform=wayland --enable-gpu-rasterization --enable-zero-copy --ignore-gpu-blocklist %U",
	class = "legcord",
	workspace = "10",
	binding = Hyprland.Bindings.NewLeader({ mod.SHIFT }, "D"),
})

Hyprland.Applications.register({
	name = "fileManager",
	cmd = "nautilus",
	binding = Hyprland.Bindings.NewLeader({}, "E"),
})

Hyprland.Applications.register({
	name = "music",
	cmd = "spotify-launcher",
	class = "Spotify",
	workspace = "10",
	binding = Hyprland.Bindings.NewLeader({ mod.SHIFT }, "M"),
})

Hyprland.Applications.register({
	name = "wepapered-gui",
	cmd = "wepaperedctl gui",
	class = "Wepapered-gui",
	autostart = true,
	float = true,
	binding = Hyprland.Bindings.NewLeader({ mod.SHIFT }, "W"),
})

Hyprland.Applications.register({
	name = "wepapered-daemon",
	cmd = "wepaperedctl daemon",
	autostart = true,
})

Hyprland.Applications.register({
	name = "nekoland",
	cmd = "/home/davidutz/.local/bin/nekoland",
	autostart = true,
})
