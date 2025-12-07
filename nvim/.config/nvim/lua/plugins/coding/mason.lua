local lang = require("utils.lang")

return {
	{
		"mason-org/mason.nvim",
		config = true,
	},
	{
		"mason-org/mason-lspconfig.nvim",
		opts = {
			ensure_installed = lang.get_mason_packages(),
		},
	},
}
