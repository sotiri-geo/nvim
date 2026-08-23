vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true

-- Editor
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.termguicolors = true
vim.opt.hidden = true
vim.opt.hlsearch = false
vim.opt.autoread = true
vim.opt.timeoutlen = 600
vim.opt.timeout = false -- wait indefinitely for a pending leader sequence instead of
                         -- racing timeoutlen; leader is bare <Space>, shared by ~13
                         -- mappings, so any pause after Space alone would otherwise
                         -- replay as a raw keypress (see git history for the repro)

