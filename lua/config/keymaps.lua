local map = vim.keymap.set

map("n", "<leader>w", "<cmd>write<cr>", { desc = "Save file" })
map("n", "<leader>q", "<cmd>quit<cr>", { desc = "Quit window" })

-- Colemak-DH/Miryoku window using navigation layer 
map("n", "<C-m>", "<C-w>h", { desc = "Window left" })
map("n", "<C-n>", "<C-w>j", { desc = "Window down" })
map("n", "<C-e>", "<C-w>k", { desc = "Window up" })
map("n", "<C-o>", "<C-w>l", { desc = "Window right" })
map("n", "<leader>v", "<C-w>v", { desc = "Split window vertically" })
map("n", "<leader>h", "<C-w>s", { desc = "Split window horizontally" })
-- Buffer navigation
map("n", "<leader>bn", ":bnext<CR>", { desc = "Next buffer", silent = true })
map("n", "<leader>bp", ":bprevious<CR>", { desc = "Next previous", silent = true })
map("n", "<leader>bd", ":bdelete<CR>", { desc = "Delete buffer", silent = true })
-- Terminal navigation
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
map("n", "<leader>t", "<C-w>v<cmd>term<cr>", { desc = "Open terminal vertically" })

-- Toggle mini.files
map("n", "<leader>e", function()
    if not require("mini.files").close() then
        require("mini.files").open()
    end
end, { desc = "Toggle mini.files (cwd)" })
