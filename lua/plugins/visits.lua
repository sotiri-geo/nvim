require("mini.visits").setup()
require("mini.extra").setup()

local map = vim.keymap.set

map("n", "<leader>fv", function()
    MiniExtra.pickers.visit_paths({
        recency_weight = 1,
        preserve_order = true,
    })
end, { desc = "Find visited files" })
