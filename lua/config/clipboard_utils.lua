local M = {}

--- Encodes text into Base64 and writes OSC 52 sequence directly to stdout.
---@param text string The raw text payload to copy.
function M.copy_osc52(text)
    -- 1. Base64 Serialization
    local b64
    if vim.base64 then
        b64 = vim.base64.encode(text)
    else
        -- Fallback using CLI base64 utility if running on older neovim
        b64 = vim.fn.system("base64", text):gsub("%s+", "")
    end

    -- 2. Build the standard OSC 52 sequence (c = clipboard)
    local osc = string.format("\27]52;c;%s\7", b64)

    -- 3. Wrap in DCS (Device Control String) if Tmux is active
    if vim.env.TMUX then
        osc = string.format("\27Ptmux;\27%s\27\\", osc)
    end

    -- 4. Write directly to active host PTY channel
    io.stdout:write(osc)
    io.stdout:flush()
end

return M
