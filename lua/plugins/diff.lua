require("mini.diff").setup()

-- Make diff more noticeable
vim.api.nvim_set_hl(0, 'MiniDiffSignChange', { fg = '#e5c07b', bold = true })
vim.api.nvim_set_hl(0, 'MiniDiffSignDelete', { fg = '#e06c75', bold = true })
vim.api.nvim_set_hl(0, 'MiniDiffSignAdd', { fg = '#98c379', bold = true })
