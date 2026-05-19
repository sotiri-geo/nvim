# Neovim Configuration (Colemak-DH / Miryoku)

This configuration is optimized for a **Colemak-DH** keyboard layout using the **Miryoku** navigation cluster for window management.

## ⌨️ Custom Keymaps

### Window Navigation & Management (Colemak-DH)
Mapped to match the Miryoku navigation layer on the right hand.

| Key | Action | Miryoku Position / Description |
|-----|--------|-----------------|
| `<C-m>` | Focus window **Left** | Index |
| `<C-n>` | Focus window **Down** | Middle |
| `<C-e>` | Focus window **Up** | Ring |
| `<C-o>` | Focus window **Right** | Pinky |
| `<leader>v` | Split window **Vertically** | Action |
| `<leader>h` | Split window **Horizontally** | Action |

### Global Actions
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>w` | Save File | Writes current buffer to disk |
| `<leader>q` | Quit | Closes the current window |
| `<leader>e` | File Explorer | Toggle `mini.files` (cwd) |

### Picker (`mini.pick`)
| Key | Action |
|-----|--------|
| `<leader>ff` | Find Files |
| `<leader>fg` | Live Grep |
| `<leader>fb` | Find Buffers |
| `<leader>fh` | Help Tags |

### Buffer Management
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>bn` | Next Buffer | Cycles to the next open buffer |
| `<leader>bp` | Previous Buffer | Cycles to the previous open buffer |
| `<leader>bd` | Delete Buffer | Closes the current buffer |

### Terminal Management
| Key | Action | Description |
|-----|--------|-------------|
| `<Esc><Esc>` | Exit Terminal Mode | Switch back to normal mode from terminal |
| `<leader>t` | Terminal Split | Open terminal in a vertical split |

---

## 🚀 Workflows

### Side-by-Side Editing & Buffer Management
To work on two or more files simultaneously:

1.  **Split the window**: Press `<leader>v` (vertical split) or `<leader>h` (horizontal split).
2.  **Navigate to the new split**: Use your directional keys (e.g., `<C-o>` to move right into a new vertical split).
3.  **Open a file**:
    *   Press `<leader>ff` to search for a file and open it in the active split.
    *   Press `<leader>e` to open the file explorer and navigate to a file.
    *   Press `<leader>fb` to pick from already open buffers.
4.  **Jump between them**: Use `<C-m>` and `<C-o>` to bounce between your side-by-side buffers.
5.  **Save and Close**:
    *   When you are done editing a side-by-side buffer, make sure you save your changes by pressing `<leader>w`.
    *   To close the active split/window, press `<leader>q`. This will hide the split without closing your other windows.
    *   *(Note: You can also use standard Neovim commands like `:wq` to save and quit the window simultaneously, or `:qa` to quit all windows).*

### Advanced Split Tips
*   **Maximized View**: To quickly close all other splits and focus ONLY on the current one, type `:only` and press Enter.
*   **Resize Splits**: Use Neovim's default resize commands if needed:
    *   `:vertical resize +5` (make vertical split wider)
    *   `:resize +5` (make horizontal split taller)
*   **Close Buffer (Not just Window)**: If you want to close a file completely so it doesn't show up in `<leader>fb` anymore, press **`<leader>bd`**.

### Terminal Integration
1.  **Open a Terminal**: Press **`<leader>t`** to instantly open a new terminal in a vertical split next to your code.
2.  **Exit Terminal Mode**: When typing in the terminal, you are in Terminal-Mode. To navigate back to your code, you must exit this mode by pressing **`<Esc><Esc>`** (double-tap Escape).
3.  **Navigate**: Once back in Normal mode, use `<C-m>` to move back to your code window. You can interact with the terminal buffer just like any other file!

### Autocomplete & Documentation
This config uses `blink.cmp` for autocomplete and LSP for documentation.

*   **Completion Menu**: Documentation is **not** shown automatically to keep the UI clean.
    *   While the completion menu is open, press **`<C-space>`** to toggle the documentation window.
*   **LSP Hover**: To see documentation/type info for the symbol under your cursor in normal mode, press **`K`** (Shift + k).

### File System Management (`mini.files`)
*   **Toggle**: Press `<leader>e`.
*   **Navigation**: Use standard movement keys. It includes a **preview window** on the right.
*   **Editing**: You can rename, create, or move files by editing the text in the explorer buffer and saving it (`<leader>w`).
