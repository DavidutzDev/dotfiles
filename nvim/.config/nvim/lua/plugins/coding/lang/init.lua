local lang = require("utils.lang")

local lang_dir = vim.fn.stdpath("config") .. "/lua/plugins/coding/lang"
for _, file in ipairs(vim.fn.globpath(lang_dir, "*.lua", false, true)) do
	local name = vim.fn.fnamemodify(file, ":t:r")
	if name ~= "init" then
		require("plugins.coding.lang." .. name)
	end
end

return lang.get_plugins()
