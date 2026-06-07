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
	name = "bar",
	cmd = "waybar",
	autostart = true,
})

Hyprland.Applications.register({
	name = "terminal",
	cmd = "ghostty",
	class = "com.mitchellh.ghostty",
	binding = Hyprland.Bindings.NewLeader({}, "RETURN"),
})

Hyprland.Applications.register({
	name = "nc",
	cmd = "swaync-client -t -sw",
	binding = Hyprland.Bindings.NewLeader({}, "N"),
})

Hyprland.Applications.register({
	name = "browser",
	cmd = "zen-browser",
	binding = Hyprland.Bindings.NewLeader({ mod.SHIFT }, "B"),
})

Hyprland.Applications.register({
	name = "discord",
	cmd = "legcord --enable-features=WebRTCPipeWireCapturer --ozone-platform-hint=auto --enable-webrtc-pipewire-capturer",
	class = "legcord",
	workspace = "10",
	binding = Hyprland.Bindings.NewLeader({ mod.SHIFT }, "D"),
})

Hyprland.Applications.register({
	name = "fileManager",
	cmd = "thunar",
	binding = Hyprland.Bindings.NewLeader({ mod.SHIFT }, "F"),
})

Hyprland.Applications.register({
	name = "menu",
	cmd = "walker",
	binding = Hyprland.Bindings.NewLeader({}, "SPACE"),
})

Hyprland.Applications.register({
	name = "menu-service",
	cmd = "walker --gapplication-service",
	autostart = true,
})

Hyprland.Applications.register({
	name = "menu-provider",
	cmd = "elephant",
	autostart = true,
})

Hyprland.Applications.register({
	name = "music",
	cmd = "spotify-launcher",
	class = "Spotify",
	workspace = "10",
	binding = Hyprland.Bindings.NewLeader({ mod.SHIFT }, "M"),
})
