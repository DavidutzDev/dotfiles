local lang = require("utils.lang")

lang.register("lua", {
	mason = { "lua_ls", "stylua" },
	treesitter = { "lua" },
	none_ls = { "stylua" },
	lsp = {
		lua_ls = {
			filetypes = {
				"lua",
			},
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
					workspace = {
						library = {
							[vim.fn.expand("$VIMRUNTIME/lua")] = true,
							[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
						},
						maxPreload = 10000,
						preloadFileSize = 10000,
					},
				},
			},
		},
	},
	plugins = {
		{
			"folke/lazydev.nvim",
			ft = "lua",
			cmd = "Lazydev",
			opts = {
				library = {
					{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				},
			},
		},
	},
})
