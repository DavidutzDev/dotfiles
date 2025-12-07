return {
	{
		"nvim-mini/mini.nvim",
		lazy = true,
		config = function()
			require("mini.ai").setup()
			require("mini.align").setup()
			require("mini.bracketed").setup()
			require("mini.cursorword").setup()
			require("mini.diff").setup()
			require("mini.extra").setup()
			require("mini.icons").setup()
			require("mini.move").setup()
			require("mini.operators").setup()
			require("mini.pairs").setup()
			require("mini.files").setup({
				windows = {
					preview = true,
				},
				options = {
					use_as_default_explorer = true,
				},
			})
			require("mini.splitjoin").setup({
				mappings = {
					toggle = "<leader>m",
				},
			})
			require("mini.surround").setup({
				mappings = {
					add = "ys",
					find = "",
					replace = "cs",
					delete = "ds",
				},
			})
			require("mini.trailspace").setup()
		end,
		keys = {
			{
				"=",
				function()
					require("mini.files").open()
				end,
				desc = "Open File Explorer (mini.files)",
			},
		},
	},
}
