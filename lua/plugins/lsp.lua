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

-- LSP Attach Autocommand for buffer-local keymaps
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(ev)
        -- Buffer local mappings
        -- See `:help vim.lsp.*` for docs on any of the below functions
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = ev.buf, desc = "LSP: Go to declaration"})
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = ev.buf, desc = "LSP: Go to definition"})
        vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = ev.buf, desc = "LSP: References" })
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = ev.buf, desc = "LSP: Implementation" })

        vim.keymap.set("n", "<leader>i", vim.lsp.buf.hover, { buffer = ev.buf, desc = "LSP: Hover info" })
        vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { buffer = ev.buf, desc = "LSP: Rename symbol" })
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = ev.buf, desc = "LSP: Code action" })

        vim.keymap.set("n", "<leader>dn", vim.diagnostic.goto_next, { buffer = ev.buf, desc = "Diagnostic: Next" })
        vim.keymap.set("n", "<leader>dp", vim.diagnostic.goto_prev, { buffer = ev.buf, desc = "Diagnostic: Previous" })
        vim.keymap.set("n", "<leader>df", vim.diagnostic.open_float, { buffer = ev.buf, desc = "Diagnostic: Show float" })
    end,
})

-- Add to the list of servers if required
vim.lsp.enable({
    "gopls",
    "lua_ls",
    "pyright",
})
