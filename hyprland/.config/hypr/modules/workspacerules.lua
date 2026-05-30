local monitors = require("modules.monitors")

for i = 1, 5 do
	hl.workspace_rule({
		workspace = i,
		monitor = monitors:get("main").output,
		default = true,
	})
end

hl.workspace_rule({
	workspace = "10",
	monitor = monitors:get("secondary").output,
	default = true,
	layout = "scrolling",
})
