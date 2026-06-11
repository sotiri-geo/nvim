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
        local client = vim.lsp.get_client_by_id(ev.data.client_id)

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

        -- Format and organize imports on save for Go buffers
        if client and client.name == "gopls" then
            vim.api.nvim_create_autocmd("BufWritePre", {
                buffer = ev.buf,
                callback = function()
                    -- Synchronously organize imports via LSP code action
                    local params = vim.lsp.util.make_range_params()
                    params.context = { only = { "source.organizeImports" } }
                    local result = vim.lsp.buf_request_sync(ev.buf, "textDocument/codeAction", params, 1000)
                    for _, res in pairs(result or {}) do
                        for _, r in pairs(res.result or {}) do
                            if r.edit then
                                vim.lsp.util.apply_workspace_edit(r.edit, "utf-8")
                            else
                                vim.lsp.buf.execute_command(r)
                            end
                        end
                    end

                    -- Synchronously format the buffer
                    vim.lsp.buf.format({ id = client.id, async = false })
                end,
            })
        end
    end,
})

-- Add to the list of servers if required
vim.lsp.enable({
    "gopls",
    "lua_ls",
    "pyright",
})
