vim.pack.add({
    -- Syntax highlightinig
    { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = vim.version.range("*") },

    -- LSP Core 
    { src = "https://github.com/neovim/nvim-lspconfig", version = vim.version.range("*") },
    { src = "https://github.com/williamboman/mason.nvim", version = vim.version.range("*") },
    { src = "https://github.com/williamboman/mason-lspconfig.nvim", version = vim.version.range("*") },

    -- Mini Ecosystem 
    { src = "https://github.com/nvim-mini/mini.files", version = "stable" },
    { src = "https://github.com/nvim-mini/mini.pairs", version = "stable" },
    { src = "https://github.com/nvim-mini/mini.icons", version = "stable" },
    { src = "https://github.com/nvim-mini/mini.diff", version = "stable" },
    { src = "https://github.com/nvim-mini/mini.animate", version = "stable" },
    { src = "https://github.com/nvim-mini/mini.surround", version = "stable" },
    { src = "https://github.com/nvim-mini/mini.ai", version = "stable" },
    { src = "https://github.com/nvim-mini/mini.statusline", version = "stable" },

    -- Picker
    { src = "https://github.com/ibhagwan/fzf-lua", version = "05e44d38de0a79c11fba5f7bf8138791b1dbdd1e" },

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
require("plugins.icons")
require("plugins.diff")
require("plugins.animate")
require("plugins.surround")
require("plugins.ai")
require("plugins.statusline")
