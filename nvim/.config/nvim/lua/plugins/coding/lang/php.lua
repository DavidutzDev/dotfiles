local lang = require("utils.lang")

lang.register("php", {
  mason = { "phpactor", "phpcs", "php-cs-fixer", "intelephense" },
  treesitter = { "php" },
  none_ls = { "phpcs", "php-cs-fixer" },
  lsp = {
    phpactor = {
      enable = true,
      filetypes = { "php" },
    },
    intelephense = {
      enable = true,
      filetypes = { "php" },
    },
  },
})
