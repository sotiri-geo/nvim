local map = vim.keymap.set

-- Colemak-DH/Miryoku window using navigation layer 
map("n", "<C-m>", "<C-w>h", { desc = "Window left" })
map("n", "<C-n>", "<C-w>j", { desc = "Window down" })
map("n", "<C-e>", "<C-w>k", { desc = "Window up" })
map("n", "<C-i>", "<C-w>l", { desc = "Window right" })
map("n", "<leader>v", "<C-w>v", { desc = "Split window vertically" })
map("n", "<leader>h", "<C-w>s", { desc = "Split window horizontally" })
-- Buffer navigation
map("n", "<leader>.", ":bnext<CR>", { desc = "Next buffer", silent = true })
map("n", "<leader>,", ":bprevious<CR>", { desc = "Next previous", silent = true })
map("n", "<leader>c", ":bdelete<CR>", { desc = "Delete buffer", silent = true })
-- Terminal navigation
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
map("n", "<leader>t", "<C-w>v<cmd>term<cr>", { desc = "Open terminal vertically" })
map("n", "<leader>tx", ":bdelete!<CR>", { desc = "Kill current terminal buffer", silent = true })

-- Toggle mini.files
map("n", "<leader>e", function()
    if not require("mini.files").close() then
        require("mini.files").open()
    end
end, { desc = "Toggle mini.files (cwd)" })
