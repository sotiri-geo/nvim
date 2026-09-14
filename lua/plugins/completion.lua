local group = vim.api.nvim_create_augroup("BlinkCmpLazyLoad", { clear = true })

vim.api.nvim_create_autocmd("InsertEnter", {
	pattern = "*",
	group = group,
	once = true,
	callback = function()
		require("blink.cmp").setup({
            keymap = { 
                preset = "default",
                ["<Tab>"] = { "select_and_accept", "fallback" },
            },
            sources = {
                default = { "lsp", "path", "buffer" },
            },
            completion = { documentation = { auto_show = true, auto_show_delay_ms = 600 },
            },
            signature = {
                enabled = true,
                trigger = {
                    show_on_keyword = false,
                    show_on_trigger_character = true,
                    show_on_insert = false,
                    show_on_insert_on_trigger_character = true,
                }
            },
            fuzzy = { implementation = "prefer_rust_with_warning" },
		})
	end,
})

