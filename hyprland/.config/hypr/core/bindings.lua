local M = {}

--- @alias Modifier "SHIFT" | "CTRL" | "ALT" | "SUPER"

--- @class Binding
--- @field modifiers Modifier[]
--- @field key string
--- @field combo string

M.LeaderKey = "SUPER"

M.Modifiers = {
	SHIFT = "SHIFT",
	CTRL = "CTRL",
	ALT = "ALT",
}

local VALID = {
	[M.LeaderKey] = true,
	[M.Modifiers.SHIFT] = true,
	[M.Modifiers.CTRL] = true,
	[M.Modifiers.ALT] = true,
}

--- Create a Binding value (does not register it).
--- @param modifiers Modifier[]
--- @param key string
--- @return Binding
function M.New(modifiers, key)
	assert(type(key) == "string" and key ~= "", "key must be a non-empty string")
	local parts = {}
	for _, mod in ipairs(modifiers or {}) do
		assert(VALID[mod], ("invalid modifier: %s"):format(tostring(mod)))
		parts[#parts + 1] = mod
	end
	parts[#parts + 1] = key
	return {
		modifiers = modifiers or {},
		key = key,
		combo = table.concat(parts, " + "),
	}
end

--- Like New, but prepends the LeaderKey.
--- @param modifiers Modifier[]
--- @param key string
--- @return Binding
function M.NewLeader(modifiers, key)
	local with_leader = { M.LeaderKey }
	for _, mod in ipairs(modifiers or {}) do
		with_leader[#with_leader + 1] = mod
	end
	return M.New(with_leader, key)
end

--- @alias Action function | HL.Dispatcher

--- Register a Binding to an action.
--- @param binding Binding
--- @param action Action
--- @param opts table?
--- @return Binding
function M.Bind(binding, action, opts)
	assert(action ~= nil, "action is required")
	hl.bind(binding.combo, action, opts)
	return binding
end
return M
