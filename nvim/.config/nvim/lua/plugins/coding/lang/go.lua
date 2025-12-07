local lang = require("utils.lang")

lang.register("go", {
	mason = { "gopls" },
	treesitter = { "go", "gomod" },
	none_ls = { "gofumpt" },
	lsp = {
		gopls = {
			settings = {
				gopls = {
					gofumpt = true,
					staticcheck = true,
				},
			},
		},
	},
	lsp_setup = {
		gopls = function(_, _)
			-- semantic tokens workaround
			require("snacks.util.lsp").on({ name = "gopls" }, function(_, client)
				if not client.server_capabilities.semanticTokensProvider then
					local semantic = client.config.capabilities.textDocument.semanticTokens
					client.server_capabilities.semanticTokensProvider = {
						full = true,
						legend = {
							tokenTypes = semantic.tokenTypes,
							tokenModifiers = semantic.tokenModifiers,
						},
						range = true,
					}
				end
			end)
		end,
	},
})
