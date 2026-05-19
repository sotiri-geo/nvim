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
            completion = { 
                documentation = { auto_show = false },
            },
            fuzzy = { implementation = "prefer_rust_with_warning" },
		})
	end,
})

