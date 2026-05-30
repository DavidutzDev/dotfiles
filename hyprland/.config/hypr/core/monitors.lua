local M = {}

--- @alias Layout "scrolling" | "dwindle" | "master"

--- @class Workspace
--- @field id string|integer
--- @field default boolean?
--- @field layout Layout?

--- @class MonitorConfig
--- @field output string
--- @field mode string?
--- @field position string?
--- @field scale number?
--- @field workspaces Workspace[]?

--- @class Monitor : MonitorConfig
--- @field id string

M.registry = {}

--- @param id string
--- @param config MonitorConfig
--- @return Monitor
function M.register(id, config)
	assert(type(id) == "string" and id ~= "", "monitor id is required")
	assert(type(config.output) == "string" and config.output ~= "", "config.output is required")
	assert(not M.registry[id], ("monitor already registered: %s"):format(id))

	local monitor = {
		id = id,
		output = config.output,
		mode = config.mode,
		position = config.position,
		scale = config.scale,
		workspaces = config.workspaces,
	}
	M.registry[id] = monitor

	hl.monitor({
		output = monitor.output,
		mode = monitor.mode,
		position = monitor.position,
		scale = monitor.scale,
	})

	for _, ws in ipairs(config.workspaces or {}) do
		assert(ws.id ~= nil, "workspace.id is required")
		hl.workspace_rule({
			workspace = tostring(ws.id),
			monitor = monitor.output,
			default = ws.default,
			layout = ws.layout,
		})
	end

	return monitor
end

--- @param id string
--- @return Monitor
function M.get(id)
	return assert(M.registry[id], ("no monitor registered: %s"):format(id))
end

return M
