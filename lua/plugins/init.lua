vim.pack.add({
    -- Syntax highlightinig
    {src = "https://github.com/nvim-treesitter/nvim-treesitter", version = vim.version.range("*")},

    -- Syntax highlighting (Treesitter recommends locking to a specific commit or using stable)
    { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = vim.version.range("*") },

    -- LSP Core 
    { src = "https://github.com/neovim/nvim-lspconfig", version = vim.version.range("*") },
    { src = "https://github.com/williamboman/mason.nvim", version = vim.version.range("*") },
    { src = "https://github.com/williamboman/mason-lspconfig.nvim", version = vim.version.range("*") },

    -- Mini Ecosystem 
    { src = "https://github.com/echasnovski/mini.pick", version = "stable" },
    { src = "https://github.com/echasnovski/mini.files", version = "stable" },
    { src = 'https://github.com/nvim-mini/mini.pairs', version = 'stable' },

    -- Completion 
    { src = "https://github.com/saghen/blink.lib" },
    { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("1.*") },

    -- Themes 
    { src = "https://github.com/rebelot/kanagawa.nvim", version = vim.version.range("*") },

})

require("plugins.theme")
require("plugins.treesitter")
require("plugins.lsp")
require("plugins.picker")
require("plugins.files")
require("plugins.completion")
require("plugins.pairs")
