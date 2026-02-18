return {
	{
		"lewis6991/gitsigns.nvim",
		event = "BufRead",
		config = function()
			require("gitsigns").setup({})
		end,
	},
	{
		"tpope/vim-fugitive",
		cmd = "Git",
		keys = {
			{ "<leader>gg", "<cmd>Git<cr>", desc = "Git" },
			{ "<leader>gd", "<cmd>Git diff<cr>", desc = "Git Diff" },
			{ "<leader>gc", "<cmd>Git commit<cr>", desc = "Git Commit" },
			{ "<leader>gb", "<cmd>Git blame<cr>", desc = "Git Blame" },
			{ "<leader>gp", "<cmd>Git push<cr>", desc = "Git Push" },
			{ "<leader>ga", "<cmd>Git add .<cr>", desc = "Git Add" },
		},
	},
}
