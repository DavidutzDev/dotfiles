local lang = require("utils.lang")

lang.register("svelte", {
	mason = { "svelte-language-server" },
	treesitter = { "svelte" },
	none_ls = {},
	lsp = {
		svelte = {
			enable = true,
			filetypes = { "svelte" },
		},
	},
})
