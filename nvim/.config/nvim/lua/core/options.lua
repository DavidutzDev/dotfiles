vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.opt.clipboard = "unnamedplus"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.o.guifont = "FiraMono Nerd Font:h11"

-- Enable virtual lines and text
vim.diagnostic.config({
	virtual_text = {
		severity = {
			max = vim.diagnostic.severity.WARN,
		},
	},
	virtual_lines = {
		severity = {
			min = vim.diagnostic.severity.ERROR,
		},
	},
})
