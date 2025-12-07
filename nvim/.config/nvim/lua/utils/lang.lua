---@class LangLspConfig
---@field settings? table
---@field capabilities? table
---@filed filetypes? string[]
---@field on_attach? function

---@class LangConfig
---@field mason? string[]
---@field treesitter? string[]
---@field lsp? table<string, LangLspConfig> | LangLspConfig
---@field lsp_setup? table<string, fun(method: string, params: table)>
---@field none_ls? string[]
---@field plugins? table[]
---@field keymaps? (string | function | table)[]

---@class LangRegistry
---@field langs table<string, LangConfig>
local M = {}

---@type table<string, LangConfig>
M.langs = {}

---@param name string
---@param config LangConfig
function M.register(name, config)
	if M.langs[name] then
		vim.notify(string.format("Lang %s already registered", name), vim.log.levels.WARN)
	end
	M.langs[name] = config
end

---@param name string
---@return LangConfig
function M.get(name)
	return M.langs[name]
end

---@param key string
---@return table
function M.collect(key)
	local results = {}
	for _, lang in pairs(M.langs) do
		local value = lang[key]
		if value then
			if vim.islist(value) then
				vim.list_extend(results, value)
			else
				table.insert(results, value)
			end
		end
	end
	return results
end

---@return string[]
function M.get_treesitters()
	return M.collect("treesitter")
end

---@return string[]
function M.get_mason_packages()
	return M.collect("mason")
end

---@return string[]
function M.get_none_ls_sources()
	return M.collect("none_ls")
end

---@return table[]
function M.get_plugins()
	local plugins = {}
	for _, lang in pairs(M.langs) do
		if lang.plugins then
			vim.list_extend(plugins, lang.plugins)
		end
	end
	return plugins
end

---@param capabilities_p? table
---@param on_attach? fun(client: vim.lsp.Client, bufnr: integer)
function M.setup_lsps(capabilities_p, on_attach)
	local function apply_keymaps(maps, bufnr)
		for _, map in ipairs(maps) do
			local lhs, rhs = map[1], map[2]
			if lhs and rhs then
				local mode = map.mode or "n"
				local opts = {
					desc = map.desc,
					buffer = bufnr,
					silent = map.silent ~= false,
					expr = map.expr,
					nowait = map.nowait,
					remap = map.remap,
				}
				vim.keymap.set(mode, lhs, rhs, opts)
			else
				vim.notify("Invalid keymap entry: missing lhs or rhs", vim.log.levels.WARN)
			end
		end
	end

	for _, spec in pairs(M.langs) do
		if spec.lsp then
			for server, config in pairs(spec.lsp) do
				local cfg = vim.tbl_deep_extend("force", {
					capabilities = capabilities_p,
					on_attach = function(client, bufnr)
						if on_attach then
							pcall(on_attach, client, bufnr)
						end
						if spec.keymaps then
							apply_keymaps(spec.keymaps, bufnr)
						end
						if type(config.on_attach) == "function" then
							pcall(config.on_attach, client, bufnr)
						end
					end,
				}, config)
				vim.notify(string.format("Configuring %s lsp server", server), vim.log.levels.INFO)
				vim.lsp.config(server, cfg)
			end
		end

		if spec.lsp_setup then
			for server, fn in pairs(spec.lsp_setup) do
				local ok, err = pcall(fn, server, spec.lsp and spec.lsp[server] or {})
				if not ok then
					vim.notify(string.format("LSP setup for %s failed: %s", server, err), vim.log.levels.ERROR)
				end
			end
		end
	end
end

return M
