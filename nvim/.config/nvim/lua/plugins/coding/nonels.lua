local lang = require("utils.lang")

return {
	{
		"nvimtools/none-ls.nvim",
		dependencies = {
			"mason-org/mason.nvim",
			opts = {
				ensure_installed = {
					--Lua
					"stylua",
					--Go
					"gomodifytags",
					"impl",
					--TS
					"biome",
				},
			},
		},
		config = function()
			local null_ls = require("null-ls")
			local sources = {}

			local builtins = null_ls.builtins
			local all = lang.get_none_ls_sources()

			for _, source in ipairs(all) do
				local mod, kind = source, "formatting"
				if builtins.code_actions[source] then
					table.insert(sources, builtins.code_actions[source])
				elseif builtins.formatting[source] then
					table.insert(sources, builtins.formatting[source])
				elseif builtins.diagnostics[source] then
					table.insert(sources, builtins.diagnostics[source])
				else
					vim.notify(string.format("No null-ls source for %s", source), vim.log.levels.WARN)
				end
			end
			null_ls.setup({
				sources = sources,
			})

			--
			-- null_ls.setup({
			--   sources = {
			--     --Lua
			--     null_ls.builtins.formatting.stylua,
			--     --Go
			--     null_ls.builtins.code_actions.gomodifytags,
			--     null_ls.builtins.code_actions.impl,
			--     null_ls.builtins.formatting.goimports,
			--     null_ls.builtins.formatting.gofumpt,
			--     --TS
			--     null_ls.builtins.formatting.biome,
			--   },
			-- })
		end,
		keys = {
			{
				"<leader>lf",
				function()
					vim.lsp.buf.format()
				end,
				desc = "Format code (none-ls)",
			},
		},
	},
	{
		"lukas-reineke/lsp-format.nvim",
		config = function()
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
					require("lsp-format").on_attach(client, args.buf)
				end,
			})
		end,
	},
}
