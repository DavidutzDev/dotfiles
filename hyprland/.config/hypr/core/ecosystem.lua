local M = {}

-- default command for each named action
M.commands = {
	screenshot = "hyprshot -m region --raw | satty --filename -",
	lock = "hyprlock",
	reload = "hyprctl reload",
	logout = "command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'",
}

--- Override one action's command.
--- @param name string
--- @param cmd string
function M.override(name, cmd)
	assert(M.commands[name], ("unknown ecosystem action: %s"):format(name))
	assert(type(cmd) == "string" and cmd ~= "", "cmd must be a non-empty string")
	M.commands[name] = cmd
end

--- Bulk override.
--- @param overrides table<string, string>
function M.set(overrides)
	for name, cmd in pairs(overrides) do
		M.override(name, cmd)
	end
end

--- Run an action now.
--- @param name string
function M.run(name)
	local cmd = assert(M.commands[name], ("unknown ecosystem action: %s"):format(name))
	hl.exec_cmd(cmd)
end

--- @type table<string, function>
-- actions.lock, actions.screenshot, ... — each a bindable function that
-- reads the *current* command at call time (so overrides set later still apply)
M.actions = setmetatable({}, {
	__index = function(_, name)
		assert(M.commands[name], ("unknown ecosystem action: %s"):format(name))
		return function()
			M.run(name)
		end
	end,
})

return M
