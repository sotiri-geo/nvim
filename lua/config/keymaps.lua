local map = vim.keymap.set
local clipboard_utils = require("config.clipboard_utils")

-- Window navigation
map("n", "<leader>w<Left>", "<C-w>h", { desc = "Window left" })
map("n", "<leader>w<Down>", "<C-w>j", { desc = "Window down" })
map("n", "<leader>w<Up>", "<C-w>k", { desc = "Window up" })
map("n", "<leader>w<Right>", "<C-w>l", { desc = "Window right" })

map("n", "<leader>v", "<C-w>v", { desc = "Split window vertically" })
map("n", "<leader>h", "<C-w>s", { desc = "Split window horizontally" })
-- Buffer navigation
map("n", "<leader>.", ":bnext<CR>", { desc = "Next buffer", silent = true })
map("n", "<leader>,", ":bprevious<CR>", { desc = "Next previous", silent = true })
map("n", "<leader>x", ":bdelete<CR>", { desc = "Delete buffer", silent = true })
-- Terminal navigation
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
map("n", "<leader>t", "<C-w>v<cmd>term<cr>", { desc = "Open terminal vertically" })
map("n", "<leader>tx", ":bdelete!<CR>", { desc = "Kill current terminal buffer", silent = true })

-- Toggle mini.files: Explorer relative to current file
map("n", "<leader>e", function()
    local buf_name = vim.api.nvim_buf_get_name(0)
    if not require("mini.files").close() then
        require("mini.files").open(buf_name ~="" and buf_name or nil)
    end
end, { desc = "Files: current file" })

-- Explorer from project root
map("n", "<leader>E", function ()
    require("mini.files").open()
end, { desc = "Files: cwd"})

-- File navigation
map("n", "<leader>sg", function()
    local url = "https://sourcegraph.iap.tmachine.io/r/git.tmachine.io/diffusion/CORE/-/blob/" .. vim.fn.expand('%:.')
    clipboard_utils.copy_osc52(url)
    print("Sourcegraph link copied!")
end, { desc = 'Copy Sourcegraph link to clipboard' })

-- Copy path
map("n", "<leader>yp", function ()
    clipboard_utils.copy_osc52(vim.fn.expand('%:.'))
    print("Filepath copied to clipboard!")
end, { desc = "Copy filepath to clipboard" })
