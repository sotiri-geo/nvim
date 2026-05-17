-- Installing language servers
require("mason").setup()

-- Ensure language server binaries exist
require("mason-lspconfig").setup({
    ensure_installed = {
        "gopls",
        "lua_ls",
        "pyright",
        "ruff",
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

-- Python server: 
vim.lsp.config("pyright", {
    settings = {
        pyright = {
            disableOrganizeImports = true,
        },
        python = {
            analysis = {
                -- Keep pyright for typechecking
                typeCheckingMode = "basic",
            },
        },
    },
})

-- Ruff server: Linting, formatting, organising imports 
vim.lsp.config("ruff", {
    on_attach = function(client) 
        client.server_capabilities.hoverProvider = false
    end,
})

-- Add to the list of servers if required
vim.lsp.enable({
    "gopls",
    "lua_ls",
    "pyright",
})
