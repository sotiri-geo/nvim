require("sidekick").setup({
    -- No Copilot seat: next edit suggestions (and its status tracking) need the
    -- Copilot LSP, so only the CLI half of sidekick is used.
    nes = { enabled = false },
    copilot = { status = { enabled = false } },
    cli = {
        -- A real tmux pane rather than a Neovim :term, so Claude receives <Esc> directly
        -- (the global t-mode <Esc><Esc> map + timeout=false would swallow it), and the
        -- session outlives Neovim. Falls back to a Neovim terminal outside tmux.
        mux = {
            enabled = true,
            backend = "tmux",
            create = "split",
            split = { vertical = true, size = 0.4 },
        },
        -- Default is snacks, which isn't installed
        picker = "fzf-lua",
        tools = { claude = {}, gemini = {} },
    },
})

local map = vim.keymap.set
local cli = require("sidekick.cli")

-- local helper to use in filters for selecting only installed CLIs
local function installed()
    return { installed = true }
end

map("n", "<leader>aa", function() cli.toggle({ filter = installed() }) end, { desc = "AI: Toggle CLI" })
map("n", "<leader>ac", function() cli.toggle({ name = "claude", focus = true }) end, { desc = "AI: Toggle Claude" })
map("n", "<leader>as", function() cli.select({ filter = installed() }) end, { desc = "AI: Select CLI" })
map("n", "<leader>ad", function() cli.close() end, { desc = "AI: Detach CLI session" })
-- {this} is the cursor position in normal mode, the selection in visual mode
map({ "n", "x" }, "<leader>at", function() cli.send({ msg = "{this}", filter = installed() }) end, { desc = "AI: Send this" })
map("n", "<leader>af", function() cli.send({ msg = "{file}", filter = installed() }) end, { desc = "AI: Send file" })
map({ "n", "x" }, "<leader>ap", function()
    cli.prompt({
        cb = function(_, text)
            if text then cli.send({ text = text, filter = installed() }) end
        end,
    })
end, { desc = "AI: Select prompt" })
