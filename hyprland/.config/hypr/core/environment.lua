local M = {}

M.vars = {}

function M.set(vars)
	assert(type(vars) == "table", "vars must be a table of name -> value")

	local names = {}
	for name in pairs(vars) do
		names[#names + 1] = name
	end
	table.sort(names)

	for _, name in ipairs(names) do
		local value = vars[name]
		M.vars[name] = value
		hl.env(name, tostring(value))
	end
end

--- @param name string
--- @return string|number|nil
function M.get(name)
	return M.vars[name]
end

return M
