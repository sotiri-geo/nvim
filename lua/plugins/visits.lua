require("mini.visits").setup()
require("mini.extra").setup()

local map = vim.keymap.set

map("n", "<leader>fv", function()
    local cwd = vim.fn.getcwd()
    MiniExtra.pickers.visit_paths({
        filter = function(path_data)
            return vim.startswith(path_data.path, cwd)
        end,
        recency_weight = 1,
        preserve_order = true,
    })
end, { desc = "Find visited files" })
