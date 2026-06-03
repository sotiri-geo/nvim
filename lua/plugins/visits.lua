require("mini.visits").setup()

local map = vim.keymap.set

map("n", "<leader>fv", function()
    MiniVisits.select_path()
end, { desc = "Find visited files" })
