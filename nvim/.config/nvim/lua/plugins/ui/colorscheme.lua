return {
	{
		"folke/tokyonight.nvim",
		enabled = true,
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd([[ colorscheme tokyonight-moon ]])
		end,
	},
	{
		"DavidutzDev/desert-night.nvim",
		enabled = true,
		lazy = false,
		priority = 1000,
		config = function()
			require("desert-night").setup({
				transparent = false,
			})

			-- vim.cmd([[ colorscheme desert-night ]])
		end,
	},
}
