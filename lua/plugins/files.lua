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
