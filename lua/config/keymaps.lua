local map = vim.keymap.set

map("n", "<leader>w", "<cmd>write<cr>", { desc = "Save file" })
map("n", "<leader>q", "<cmd>quit<cr>", { desc = "Quit window" })

-- Colemak-DH/Miryoku window using navigation layer 
map("n", "<leader>wn", "<C-w>h", { desc = "Window left" })
map("n", "<leader>we", "<C-w>j", { desc = "Window down" })
map("n", "<leader>wi", "<C-w>k", { desc = "Window up" })
map("n", "<leader>wo", "<C-w>l", { desc = "Window right" })
