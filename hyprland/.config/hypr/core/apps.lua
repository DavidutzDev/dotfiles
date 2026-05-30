local Bindings = require("core.bindings")

local M = {}

--- @class WindowMatch
--- @field class string?
--- @field title string?

--- @class App
--- @field name string
--- @field cmd string          the spawn command
--- @field class string?       window class (used for window rules)
--- @field binding Binding?    optional keybind that spawns this app
--- @field autostart boolean?  spawn on hyprland.start
--- @field float boolean?   float this app's windows
--- @field workspace string?   assign this app's windows to a workspace
--- @field window table?       extra window_rule props merged in

M.registry = {}
M.window_rules = {}
M.layer_rules = {}

-- emit a window rule from an app's rule fields, if any are set
local function apply_window_rules(app)
	if not app.class then
		return
	end
	if app.float == nil and app.workspace == nil and app.window == nil then
		return
	end

	local rule = {
		name = app.name .. "-window",
		match = { class = app.class },
	}
	if app.float ~= nil then
		rule.float = app.float
	end
	if app.workspace ~= nil then
		rule.workspace = app.workspace
	end
	for k, v in pairs(app.window or {}) do
		rule[k] = v
	end

	M.window_rules[rule.name] = rule
	hl.window_rule(rule)
end

--- @param app App
--- @return App
function M.register(app)
	assert(type(app.cmd) == "string" and app.cmd ~= "", "app.cmd is required")
	local name = app.name or app.cmd
	assert(not M.registry[name], ("app already registered: %s"):format(name))

	M.registry[name] = app

	if app.binding then
		Bindings.Bind(app.binding, function()
			hl.exec_cmd(app.cmd)
		end)
	end

	apply_window_rules(app)

	return app
end

--- Spawn every app marked autostart. Call this from hyprland.start.
function M.start_all()
	for _, app in pairs(M.registry) do
		if app.autostart then
			hl.exec_cmd(app.cmd)
		end
	end
end

--- @param name string
--- @return App
function M.get(name)
	return assert(M.registry[name], ("no app registered: %s"):format(name))
end

--- @param name string
--- @return string class
function M.get_class(name)
	local app = M.get(name)
	return assert(app.class, ("app has no class: %s"):format(name))
end

--- Standalone window rule. Pass `app = "name"` to resolve match.class automatically.
--- @param rule table
--- @return table
function M.window_rule(rule)
	if rule.app then
		rule.match = rule.match or {}
		rule.match.class = rule.match.class or M.get_class(rule.app)
		rule.app = nil
	end
	assert(rule.name, "window_rule requires a name")
	M.window_rules[rule.name] = rule
	hl.window_rule(rule)
	return rule
end

--- Layer rule — matches by namespace, not tied to an app.
--- @param rule table
--- @return table
function M.layer_rule(rule)
	assert(rule.name, "layer_rule requires a name")
	M.layer_rules[rule.name] = rule
	hl.layer_rule(rule)
	return rule
end

return M
