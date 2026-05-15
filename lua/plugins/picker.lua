require("mini.pick").setup()

local map = vim.keymap.set

map("n", "<leader>ff", "<cmd>Pick files<cr>", { desc = "Find files" })
map("n", "<leader>fg", "<cmd>Pick grep_live<cr>", { desc = "Live grep" })
map("n", "<leader>fb", "<cmd>Pick buffers<cr>", { desc = "Find buffers" })
map("n", "<leader>fh", "<cmd>Pick help<cr>", { desc = "Help tags" })
