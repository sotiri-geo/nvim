-- Autocommands are defined here

local clipboard_utils = require("config.clipboard_utils")

-- Create an autocommand group for OSC 52 clipboard syncing
local osc52_group = vim.api.nvim_create_augroup("OSC52Clipboard", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
    group = osc52_group,
    callback = function()
        -- ONLY copy if the operator is an explicit yank ('y').
        -- This ignores deletions ('d'), modifications ('c'), and character cuts ('x').
        if vim.v.event.operator == "y" then
            -- Join the yanked lines into a single string with newlines
            local text = table.concat(vim.v.event.regcontents, "\n")
            clipboard_utils.copy_osc52(text)
        end
    end,
    desc = "Automatically sync explicit yanks to local clipboard via OSC 52 over SSH/Tmux"
})

local comment_continuation_group = vim.api.nvim_create_augroup("CommentContinuation", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
    group = comment_continuation_group,
    callback = function()
        vim.opt_local.formatoptions:append("r")
    end,
    desc = "Continue comment leaders after pressing Enter in insert mode"
})
