require("mini.animate").setup({
    -- Cursor animation lags behind fast movement rather than looking smooth,
    -- so disable it; scroll animation stays on for smooth up/down movement.
    cursor = { enable = false },
})
