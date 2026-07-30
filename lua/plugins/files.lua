local minifiles = require("mini.files")

minifiles.setup({
    content = {
        filter = nil,
        sort = nil,
    },
    windows = {
        -- Max no. columns to show at the same time
        max_number = math.huge,
        -- Whether to show preview of file/directory under cursor
        preview = true,
        width_focus = 30, 
        width_preview = 45,
    },
    options = {
        -- Whether to delete permanently or move into a module-specific trash
        permanent_delete = false,
        use_as_default_explorer = true,
    },
})

-- Map keys dynamically when a mini.files buffer is created
vim.api.nvim_create_autocmd("User", {
    pattern = "MiniFilesBufferCreate",
    callback = function(args)
        local buf_id = args.data.buf_id

        -- Helper to scroll active directory list by moving cursor
        local scroll_explorer = function(direction)
            local win = vim.api.nvim_get_current_win()
            local height = vim.api.nvim_win_get_height(win)
            local lines = math.floor(height / 4)
            local key = direction == "down" and "j" or "k"
            -- Move cursor to trigger mini.files update events cleanly
            vim.cmd("normal! " .. lines .. key)
        end

        vim.keymap.set("n", "<C-d>", function() scroll_explorer("down") end, { buffer = buf_id, desc = "Scroll explorer down" })
        vim.keymap.set("n", "<C-u>", function() scroll_explorer("up") end, { buffer = buf_id, desc = "Scroll explorer up" })
    end,
})

