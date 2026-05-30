------------------
---- MONITORS ----
------------------
local M = {}

local monitors = {}

function M.register(name, config)
	hl.monitor(config)

	monitors[name] = config
end

function M:get(name)
	return monitors[name]
end

M.register("main", {
	output = "DP-1",
	mode = "1920x1080@165",
	position = "0x0",
	scale = 1,
})

M.register("secondary", {
	output = "HDMI-A-1",
	mode = "1920x1080@60",
	position = "1920x0",
	scale = 1,
})

return M
