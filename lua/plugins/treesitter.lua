-- Parse code for better syntax highlighting
local treesitter = require("nvim-treesitter")

treesitter.setup({
    install_dir = vim.fn.stdpath("data") .. "/site",
})

-- Install parsers
treesitter.install({
    "lua",
    "go",
    "python",
    "vim",
    "vimdoc",
    "json",
    "yaml",
    "markdown",
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = {
        "lua",
        "go",
        "python",
        "vim",
        "help",
        "json",
        "yaml",
        "markdown",
    },
    callback = function()
        vim.treesitter.start()
    end,
})
