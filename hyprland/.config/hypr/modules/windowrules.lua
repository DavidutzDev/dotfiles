--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------
local apps = require("config.apps")

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

-- Example window rules that are useful

hl.window_rule({
	-- Ignore maximize requests from all apps. You'll probably like this.
	name = "suppress-maximize-events",
	match = { class = ".*" },

	suppress_event = "maximize",
})

hl.window_rule({
	-- Fix some dragging issues with XWayland
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},

	no_focus = true,
})

-- Layer rules also return a handle.
-- local overlayLayerRule = hl.layer_rule({
--     name  = "no-anim-overlay",
--     match = { namespace = "^my-overlay$" },
--     no_anim = true,
-- })
-- overlayLayerRule:set_enabled(false)

-- Hyprland-run windowrule
hl.window_rule({
	name = "move-hyprland-run",
	match = { class = "hyprland-run" },

	move = "20 monitor_h-120",
	float = true,
})

hl.layer_rule({
	name = "walker",
	match = { namespace = "walker" },
	animation = "popin 80%",
	dim_around = true,
})

hl.layer_rule({
	name = "notifications",
	match = { namespace = "swaync-control-center" },
	animation = "slide right 80%",
})
--
hl.window_rule({
	name = "browser-to-workspace-1",
	match = { class = apps:get_class("browser") },
	workspace = "1",
})

hl.window_rule({
	name = "discord-to-workspace-10",
	match = { class = apps:get_class("discord") },
	workspace = "10",
})

hl.window_rule({
	name = "music-to-workspace-10",
	match = { class = apps:get_class("music") },
	workspace = "10",
})
