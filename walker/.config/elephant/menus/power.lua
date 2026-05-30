Name = "powermenu"
NamePretty = "Power Menu"
Icon = "⏻"
HideFromProviderlist = false
Cache = false
Action = "%VALUE%"

function GetEntries()
	return {
		{
			Text = "Lock",
			Subtext = "Lock the screen",
			Value = "hyprlock",
			Icon = "",
		},
		{
			Text = "Sleep",
			Subtext = "Suspend to RAM",
			Value = "systemctl suspend",
			Icon = "󰒲",
		},
		{
			Text = "Logout",
			Subtext = "Exit Hyprland session",
			Value = "hyprctl dispatch exit",
			Icon = "󰍃",
		},
		{
			Text = "Restart",
			Subtext = "Reboot the computer",
			Value = "systemctl reboot",
			Icon = "",
		},
		{
			Text = "Shutdown",
			Subtext = "Power off the computer",
			Value = "systemctl poweroff",
			Icon = "⏻",
		},
	}
end
