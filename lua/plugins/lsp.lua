-- Installing language servers
require("mason").setup()

-- Ensure language server binaries exist
require("mason-lspconfig").setup({
    ensure_installed = {
        "gopls",
        "lua_ls",
        "pyright",
    },
})

-- Lua server
vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" },
            },
            workspace = {
                Library = {
                    vim.env.VIMRUNTIME,
                },
            },
        },
    },
})

-- Go server
vim.lsp.config("gopls", {
    settings = {
        gopls = {
            gofumpt = true,
            staticcheck = true,
            analyses = {
                unusedparams = true,
                nilness = true,
                unusedwrite = true,
            },
        },
    },
})

-- Python server
vim.lsp.config("pyright", {})

-- Add to the list of servers if required
vim.lsp.enable({
    "gopls",
    "lua_ls",
    "pyright",
})
