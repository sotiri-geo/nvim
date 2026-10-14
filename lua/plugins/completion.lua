local group = vim.api.nvim_create_augroup("BlinkCmpLazyLoad", { clear = true })

vim.api.nvim_create_autocmd("InsertEnter", {
	pattern = "*",
	group = group,
	once = true,
	callback = function()
		require("blink.cmp").setup({
            keymap = { 
                preset = "default",
                -- VSCode-style: accept when the menu is open, otherwise jump to the next snippet field
                ["<Tab>"] = { "select_and_accept", "snippet_forward", "fallback" },
                ["<S-Tab>"] = { "snippet_backward", "fallback" },
            },
            sources = {
                default = { "lsp", "path", "buffer" },
            },
            completion = {
                documentation = { auto_show = true, auto_show_delay_ms = 600 },
                -- Highlight the first item but only insert it on accept
                list = { selection = { preselect = true, auto_insert = false } },
                -- Inline preview of the selected item
                ghost_text = { enabled = true },
                -- Add () for servers that don't send call snippets (e.g. pyright)
                accept = { auto_brackets = { enabled = true } },
                menu = {
                    draw = {
                        treesitter = { "lsp" },
                        components = {
                            kind_icon = {
                                text = function(ctx)
                                    local icon = require("mini.icons").get("lsp", ctx.kind)
                                    return icon .. ctx.icon_gap
                                end,
                                highlight = function(ctx)
                                    local _, hl = require("mini.icons").get("lsp", ctx.kind)
                                    return hl
                                end,
                            },
                        },
                    },
                },
            },
            signature = {
                enabled = true,
                trigger = {
                    show_on_keyword = false,
                    show_on_trigger_character = true,
                    show_on_insert = false,
                    show_on_insert_on_trigger_character = true,
                    show_on_accept = true,
                }
            },
            fuzzy = { implementation = "prefer_rust_with_warning" },
		})
	end,
})

