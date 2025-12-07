local lang = require("utils.lang")

lang.register("tailwindcss", {
	mason = { "tailwindcss-language-server" },
	lsp = {
		tailwindcss = {
			enable = true,
		},
	},
	lsp_setup = {
		tailwindcss = function(_, opts)
			opts.filetypes = opts.filetypes or {}

			-- Add default filetypes
			vim.list_extend(opts.filetypes, vim.lsp.config.tailwindcss.filetypes)

			-- Remove excluded filetypes
			--- @param ft string
			opts.filetypes = vim.tbl_filter(function(ft)
				return not vim.tbl_contains(opts.filetypes_exclude or {}, ft)
			end, opts.filetypes)

			-- Add additional filetypes
			vim.list_extend(opts.filetypes, opts.filetypes_include or {})
		end,
	},
})
