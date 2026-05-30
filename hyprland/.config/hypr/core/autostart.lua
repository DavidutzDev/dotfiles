local M = {}

M.session = {}
M.hooks = {}
M.started = false

--- @param cmds string[]
function M.setSession(cmds)
	assert(type(cmds) == "table", "session must be a list of command strings")
	M.session = cmds
end

--- @param fn function
function M.addHook(fn)
	assert(type(fn) == "function", "hook must be a function")
	M.hooks[#M.hooks + 1] = fn
end

function M.install()
	assert(not M.started, "Autostart already installed")
	M.started = true
	hl.on("hyprland.start", function()
		for _, fn in ipairs(M.hooks) do
			fn()
		end
		for _, cmd in ipairs(M.session) do
			hl.exec_cmd(cmd)
		end
	end)
end

return M
