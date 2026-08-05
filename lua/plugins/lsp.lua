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
            directoryFilters = {
                "-**/node_modules",
                "-plz-out",
            },
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

local function set_lsp_keymap(client, method, lhs, rhs, buffer, desc)
    if client:supports_method(method, buffer) then
        vim.keymap.set("n", lhs, rhs, { buffer = buffer, desc = desc })
    end
end

local function show_please_help(client, buffer)
    local symbol = vim.fn.expand("<cword>")
    if symbol == "" then
        vim.notify("No Please rule under the cursor", vim.log.levels.WARN)
        return
    end

    vim.system({ "plz", "help", symbol }, {
        cwd = client.root_dir,
        text = true,
    }, function(result)
        vim.schedule(function()
            if not vim.api.nvim_buf_is_valid(buffer) or vim.api.nvim_get_current_buf() ~= buffer then
                return
            end

            local output = vim.trim(result.stdout or "")
            if result.code ~= 0 or output == "" then
                local message = vim.trim(result.stderr or "")
                if message == "" then
                    message = ("No Please help found for %q"):format(symbol)
                end
                vim.notify(message, vim.log.levels.WARN)
                return
            end

            vim.lsp.util.open_floating_preview(vim.split(output, "\n", { plain = true }), "text", {
                border = "rounded",
                focusable = true,
                max_height = math.max(vim.o.lines - 4, 1),
                max_width = math.max(math.floor(vim.o.columns * 0.8), 1),
                wrap = true,
            })
        end)
    end)
end

-- LSP Attach Autocommand for buffer-local keymaps
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if not client then
            return
        end

        -- Buffer local mappings
        -- See `:help vim.lsp.*` for docs on any of the below functions
        set_lsp_keymap(client, "textDocument/declaration", "gD", vim.lsp.buf.declaration, ev.buf, "LSP: Go to declaration")
        set_lsp_keymap(client, "textDocument/definition", "gd", vim.lsp.buf.definition, ev.buf, "LSP: Go to definition")
        set_lsp_keymap(client, "textDocument/references", "gr", vim.lsp.buf.references, ev.buf, "LSP: References")
        set_lsp_keymap(client, "textDocument/implementation", "gi", vim.lsp.buf.implementation, ev.buf, "LSP: Implementation")

        if client.name == "please" then
            vim.keymap.set("n", "<leader>i", function()
                show_please_help(client, ev.buf)
            end, { buffer = ev.buf, desc = "Please: Rule help" })
        else
            set_lsp_keymap(client, "textDocument/hover", "<leader>i", vim.lsp.buf.hover, ev.buf, "LSP: Hover info")
        end

        set_lsp_keymap(client, "textDocument/rename", "<leader>cr", vim.lsp.buf.rename, ev.buf, "LSP: Rename symbol")
        set_lsp_keymap(client, "textDocument/codeAction", "<leader>ca", vim.lsp.buf.code_action, ev.buf, "LSP: Code action")

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
    "please",
})
