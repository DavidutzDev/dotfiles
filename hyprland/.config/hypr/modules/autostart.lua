-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function()
	hl.exec_cmd("awww-daemon")
	hl.exec_cmd("waybar")

	hl.exec_cmd("walker --gapplication-service")
	hl.exec_cmd("elephant")

	hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
	hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
	hl.exec_cmd("/usr/lib/xdg-desktop-portal-hyprland &")

	hl.exec_cmd("gsettings set org.gnome.desktop.interface gtk-theme 'catppuccin-mocha-lavender-standard+default'")
	hl.exec_cmd("gsettings set org.gnome.desktop.interface icon-theme 'Adawaita'")
	hl.exec_cmd("gsettings set org.gnome.desktop.interface cursor-theme 'default'")
	hl.exec_cmd("gsettings set org.gnome.desktop.interface font-theme 'JetBrainsMonoNL Nerd Font Medium 11'")
end)
