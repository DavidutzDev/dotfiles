return {
	-- Sops edit tools
	"lemarsu/sops.nvim",
	opts = function()
		local config = require("sops.config")
		config.follow = { "SOPS_AGE_KEY_FILE" }
	end,
	keys = {
		{ "<leader>se", "<cmd>Sops encrypt<cr>", desc = "[S]ops [E]ncrypt" },
		{ "<leader>sd", "<cmd>Sops decrypt<cr>", desc = "[S]ops [D]ecrypt" },
		{ "<leader>sS", "<cmd>Sops toggle<cr>", desc = "[S]ops [T]oggle" },
	},
}
