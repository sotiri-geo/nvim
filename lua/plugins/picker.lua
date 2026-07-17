local pick = require("mini.pick")

local function paste_register(register)
    return function()
        local text = vim.fn.getreg(register):gsub("[\n\t]", " ")
        if text == "" then
            return
        end

        local query = MiniPick.get_picker_query() or {}

        for i = 1, vim.fn.strchars(text) do
            table.insert(query, vim.fn.strcharpart(text, i - 1, 1))
        end

        MiniPick.set_picker_query(query)
    end
end

pick.setup({
    mappings = {
        paste_yank = {
            char = "<C-y>",
            func = paste_register("0"),
        },
    },
})

local map = vim.keymap.set

map("n", "<leader>ff", "<cmd>Pick files<cr>", { desc = "Find files" })
map("n", "<leader>fg", "<cmd>Pick grep_live<cr>", { desc = "Live grep" })
map("n", "<leader>fb", "<cmd>Pick buffers<cr>", { desc = "Find buffers" })
map("n", "<leader>fh", "<cmd>Pick help<cr>", { desc = "Help tags" })
