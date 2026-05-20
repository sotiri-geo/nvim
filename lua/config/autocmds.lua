-- Restore default Enter behavior in quickfix windows
-- This is needed because <C-m> is globally mapped to window navigation,
-- and <C-m> shares a keycode with <CR> (Enter) in most terminals.
vim.api.nvim_create_autocmd("FileType", {
	pattern = "qf",
	callback = function(ev)
		vim.keymap.set("n", "<CR>", "<CR>", { buffer = ev.buf, desc = "Jump to quickfix entry" })
	end,
})
