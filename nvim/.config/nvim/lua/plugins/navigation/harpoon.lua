return {
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local harpoon = require("harpoon")

			harpoon:setup()
		end,
		keys = {
			{
				"<leader>a",
				mode = { "n" },
				function()
					require("harpoon"):list():add()
				end,
				desc = "Add Harpoon",
			},
			{
				"<C-e>",
				mode = { "n" },
				function()
					local harpoon = require("harpoon")
					harpoon.ui:toggle_quick_menu(harpoon:list())
				end,
				desc = "Open Harpoon Menu",
			},
			{
				"<C-h>",
				mode = { "n" },
				function()
					require("harpoon"):list():select(1)
				end,
				desc = "Select first harpoon item",
			},
			{
				"<C-j>",
				mode = { "n" },
				function()
					require("harpoon"):list():select(2)
				end,
				desc = "Select first harpoon item",
			},
			{
				"<C-k>",
				mode = { "n" },
				function()
					require("harpoon"):list():select(3)
				end,
				desc = "Select first harpoon item",
			},
			{
				"<C-l>",
				mode = { "n" },
				function()
					require("harpoon"):list():select(4)
				end,
				desc = "Select first harpoon item",
			},
		},
	},
}
