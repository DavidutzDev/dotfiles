local M = {}

M.terminal = "ghostty"
M.notifications = "swaync-client -t -sw"
M.browser = {
	launch = "zen-browser",
	class = "zen-browser",
}
M.discord = {
	launch = "discord",
	class = "discord",
}
M.fileManager = "thunar"
M.menu = "walker"
M.music = {
	launch = "spotify-launcher",
	class = "Spotify",
}

-- Helpers

function M:get_launch(app_name)
	local target = self[app_name]
	if type(target) == "table" then
		return target.launch
	end
	return target
end

function M:get_class(app_name)
	local target = self[app_name]
	if type(target) == "table" and target.class then
		return target.class
	end
	return target
end

return M
