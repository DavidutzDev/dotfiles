local Hyprland = require("core")

-- Headless (over-VNC) session has no nvidia GPU on the host -> use mesa GL.
local headless = os.getenv("HYPR_HEADLESS") == "1"

Hyprland.Environment.set({
	-- cursor
	XCURSOR_SIZE = "24",
	HYPRCURSOR_SIZE = "24",

	-- toolkit backend
	GDK_BACKEND = "wayland,x11,*",
	SDL_VIDEODRIVER = "wayland",
	CLUTTER_BACKEND = "wayland",

	-- XDG
	XDG_CURRENT_DESKTOP = "Hyprland",
	XDG_SESSION_TYPE = "wayland",
	XDG_SESSION_DESKTOP = "Hyprland",

	-- Qt
	QT_QPA_PLATFORM = "wayland;xcb",
	QT_AUTO_SCREEN_SCALE_FACTOR = "1",
	QT_WAYLAND_DISABLE_WINDOWDECORATION = "1",
	QT_QPA_PLATFORMTHEME = "qt5ct",

	-- Nvidia on the real session; mesa/llvmpipe when headless.
	GBM_BACKEND = headless and "mesa" or "nvidia-drm",
	__GLX_VENDOR_LIBRARY_NAME = headless and "mesa" or "nvidia",
})
