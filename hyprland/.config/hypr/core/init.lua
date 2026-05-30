local M = {}

M.Bindings = require("core.bindings")
M.Applications = require("core.apps")
M.Monitors = require("core.monitors")
M.Autostart = require("core.autostart")
M.Environment = require("core.environment")
M.Ecosystem = require("core.ecosystem")

M.Autostart.addHook(function()
	M.Applications.start_all()
end)

M.Autostart.install()

return M
