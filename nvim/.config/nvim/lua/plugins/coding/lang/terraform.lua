local lang = require("utils.lang")

lang.register("terraform", {
	mason = { "terraform-ls" },
	treesitter = { "terraform" },
	plugins = {},
	none_ls = {},
	lsp = {},
})
