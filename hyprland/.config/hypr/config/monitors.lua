local Hyprland = require("core")

Hyprland.Monitors.register("main", {
	output = "DP-3",
	mode = "1920x1080@165",
	position = "1920x0",
	scale = 1,
	workspaces = {
		{ id = "1", default = true, layout = "dwindle" },
		{ id = "2", default = true, layout = "dwindle" },
		{ id = "3", default = true, layout = "dwindle" },
		{ id = "4", default = true, layout = "dwindle" },
		{ id = "5", default = true, layout = "dwindle" },
	},
})

Hyprland.Monitors.register("secondary", {
	output = "HDMI-A-1",
	mode = "1920x1080@60",
	position = "0x0",
	scale = 1,
	workspaces = {
		{ id = "10", default = true, layout = "scrolling" },
	},
})

-- Virtual vkms output used by the headless (over-SSH, VNC) session.
-- Only present when the real GPU is in the VM; ignored otherwise.
Hyprland.Monitors.register("headless", {
	output = "Virtual-1",
	mode = "1920x1080@60",
	position = "0x0",
	scale = 1,
	workspaces = {
		{ id = "1", default = true, layout = "dwindle" },
	},
})
