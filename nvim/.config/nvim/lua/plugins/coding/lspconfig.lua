local lang = require("utils.lang")

return {
	{
		"neovim/nvim-lspconfig",
		dependencies = { "williamboman/mason-lspconfig.nvim" },
		event = "VeryLazy",
		config = function()
			local capabilities = require("blink.cmp").get_lsp_capabilities()

			lang.setup_lsps(capabilities)
		end,
		keys = {
			{ "gd", vim.lsp.buf.definition, desc = "Goto Definition" },
			{
				"gr",
				vim.lsp.buf.references,
				desc = "References",
				nowait = true,
			},
			{ "gI", vim.lsp.buf.implementation, desc = "Goto Implementation" },
			{ "gy", vim.lsp.buf.type_definition, desc = "Goto Type Definition" },
			{ "gD", vim.lsp.buf.declaration, desc = "Goto Declaration" },
			{
				"K",
				function()
					return vim.lsp.buf.hover()
				end,
				desc = "Hover",
			},
			{
				"gK",
				function()
					return vim.lsp.buf.signature_help()
				end,
				desc = "Signature Help",
			},
			{
				"<c-k>",
				function()
					return vim.lsp.buf.signature_help()
				end,
				mode = "i",
				desc = "Signature Help",
			},
			{
				"<leader>ca",
				vim.lsp.buf.code_action,
				desc = "Code Action",
				mode = { "n", "x" },
			},
			{
				"<leader>cc",
				vim.lsp.codelens.run,
				desc = "Run Codelens",
				mode = { "n", "x" },
			},
			{
				"<leader>cR",
				function()
					require("snacks.rename").rename_file()
				end,
				desc = "Rename File",
				mode = { "n" },
			},
			{ "<leader>cr", vim.lsp.buf.rename },
		},
	},
}
