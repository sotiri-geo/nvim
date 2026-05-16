-- Parse code for better syntax highlighting
require("nvim-treesitter.configs").setup({
    ensure_installed = {
        "lua",
        "go",
        "python",
        "vim",
        "vimdoc",
        "json",
        "yaml",
        "markdown",
    },
    highlight = {
        enable = true,
    },
    indent = {
        enable = true,
    },
})

