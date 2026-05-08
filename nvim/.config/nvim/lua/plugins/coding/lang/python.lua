local lang = require("utils.lang")

lang.register("python", {
	mason = { "pyright", "ruff", "black", "isort" },
	treesitter = { "python" },
	none_ls = { "ruff", "black", "isort" },
	lsp = {
		pyright = {
			enable = true,
			filetypes = { "python" },
		},
	},
})
