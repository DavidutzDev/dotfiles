local Hyprland = require("core")

Hyprland.Autostart.setSession({
	"dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP",
	"systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP",
	"/usr/lib/xdg-desktop-portal-hyprland &",

	"gsettings set org.gnome.desktop.interface gtk-theme 'catppuccin-mocha-lavender-standard+default'",
	"gsettings set org.gnome.desktop.interface icon-theme 'Adwaita'",
	"gsettings set org.gnome.desktop.interface cursor-theme 'default'",
	"gsettings set org.gnome.desktop.interface font-theme 'JetBrainsMonoNL Nerd Font Medium 11'",

	"cliphist wipe",
	"sh -c 'wl-copy --clear; wl-copy --primary --clear'",
	"wl-paste --type text --watch cliphist store &",
	"wl-paste --type image --watch cliphist store &",
	"wl-clip-persist --clipboard regular &",
})
