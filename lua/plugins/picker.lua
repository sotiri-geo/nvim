local fzf = require("fzf-lua")

-- Glob filtering is on by default: `M.defaults.grep` already sets `rg_glob = 1`,
-- `glob_flag = "--iglob"` and `glob_separator = "%s%-%-"`, so every grep picker
-- splits the prompt on " -- " and passes the tail to ripgrep as --iglob args.
--   e.g.  handleRequest -- *.go !*_test.go
-- The `1` (rather than `true`) suppresses a warning when the tool is not rg;
-- setting `rg_glob = true` here would re-enable it. The "default" profile is
-- applied automatically when no profile is given.
-- NOTE: `keymap.fzf` REPLACES the default table rather than merging into it, so
-- the defaults have to be extended explicitly or the other 15 binds are lost.
fzf.setup({
    keymap = {
        fzf = vim.tbl_extend("force", fzf.defaults.keymap.fzf, {
            -- Match the <C-d>/<C-u> half-page scrolling used in mini.files.
            -- ctrl-f/ctrl-b keep working; they do the same thing.
            ["ctrl-d"] = "half-page-down",
            ["ctrl-u"] = "half-page-up",
            -- ctrl-u was fzf's "clear the query line" (unix-line-discard);
            -- moved to ctrl-r so the capability isn't lost.
            ["ctrl-r"] = "unix-line-discard",
        }),
    },
})

local map = vim.keymap.set

map("n", "<leader>ff", fzf.files, { desc = "Find files" })
map("n", "<leader>fg", fzf.live_grep, { desc = "Live grep" })
map("n", "<leader>fb", fzf.buffers, { desc = "Find buffers" })
map("n", "<leader>fh", fzf.helptags, { desc = "Help tags" })

-- Recent files, restricted to the current project.
--   cwd_only                -> drop anything outside the current working directory
--   include_current_session -> v:oldfiles is only populated from shada at startup, so
--                              without this, files opened in this session never appear
map("n", "<leader>fv", function()
    fzf.oldfiles({ cwd_only = true, include_current_session = true })
end, { desc = "Recent files (current project)" })

-- Replaces the old mini.pick <C-v> "paste last yank into the prompt" mapping.
-- fzf runs in a terminal buffer so there is no in-prompt register paste; instead
-- seed the ripgrep term directly via `opts.search`.
map("n", "<leader>fy", function()
    fzf.live_grep({ search = vim.fn.getreg("0") })
end, { desc = "Live grep last yank" })

map("n", "<leader>fw", fzf.grep_cword, { desc = "Live grep word under cursor" })
map("x", "<leader>fw", fzf.grep_visual, { desc = "Live grep selection" })
