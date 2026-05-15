vim.pack.add({
    -- Syntax highlighting
    "https://github.com/nvim-treesitter/nvim-treesitter",

    -- LSP
    "https://github.com/neovim/nvim-lspconfig",
    "http://github.com/mason-org/mason.nvim",
    "https://github.com/mason-org/mason-lspconfig.nvim",

    -- Picker
    "https://github.com/nvim-mini/mini.pick",

    -- Themes
    "https://github.com/rebelot/kanagawa.nvim"
})

require("plugins.theme")
require("plugins.treesitter")
require("plugins.lsp")
require("plugins.picker")
