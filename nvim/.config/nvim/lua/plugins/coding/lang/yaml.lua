local lang = require("utils.lang")

lang.register("yaml", {
	mason = { "yaml-language-server" },
	treesitter = { "yaml" },
	plugins = {
		{
			"b0o/SchemaStore.nvim",
			lazy = true,
			version = false,
		},
	},
	none_ls = {},
	lsp = {
		yamlls = {
			enable = true,
			filetypes = { "yaml" },
			settings = {
				redhat = { telemetry = { enabled = false } },
				yaml = {
					keyOrdering = false,
					format = {
						enable = true,
					},
					validate = true,
					schemaStore = {
						enable = false,
						url = "",
					},
				},
			},
		},
	},
})
