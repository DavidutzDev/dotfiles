local lang = require("utils.lang")

lang.register("svelte", {
	mason = { "svelte-language-server" },
	treesitter = { "svelte", "scss", "javascript", "typescript", "html", "css" },
	none_ls = {},
	lsp = {
		svelte = {
			enable = true,
			filetypes = { "svelte" },
		},
	},
})
