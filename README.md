# Neovim Configuration (Colemak-DH / Miryoku)

This configuration is optimized for a **Colemak-DH** keyboard layout using the **Miryoku** navigation cluster for window management.

## ⌨️ Custom Keymaps

### Window Navigation (Colemak-DH)
Mapped to match the Miryoku navigation layer on the right hand.

| Key | Action | Miryoku Position |
|-----|--------|-----------------|
| `<C-m>` | Focus window **Left** | Index |
| `<C-n>` | Focus window **Down** | Middle |
| `<C-e>` | Focus window **Up** | Ring |
| `<C-o>` | Focus window **Right** | Pinky |

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

---

## 🚀 Workflows

### Side-by-Side Editing
To work on two files simultaneously:

1.  **Split the window**: Press `<C-w>v` (vertical) or `<C-w>s` (horizontal).
2.  **Navigate to the new split**: Use your directional keys (e.g., `<C-o>` to move right into a new vertical split).
3.  **Open a file**:
    *   Press `<leader>ff` to search for a file and open it in the active split.
    *   Press `<leader>e` to open the file explorer and navigate to a file.
4.  **Jump between them**: Use `<C-m>` and `<C-o>` to bounce between your side-by-side buffers.

### Autocomplete & Documentation
This config uses `blink.cmp` for autocomplete and LSP for documentation.

*   **Completion Menu**: Documentation is **not** shown automatically to keep the UI clean.
    *   While the completion menu is open, press **`<C-space>`** to toggle the documentation window.
*   **LSP Hover**: To see documentation/type info for the symbol under your cursor in normal mode, press **`K`** (Shift + k).

### File System Management (`mini.files`)
*   **Toggle**: Press `<leader>e`.
*   **Navigation**: Use standard movement keys. It includes a **preview window** on the right.
*   **Editing**: You can rename, create, or move files by editing the text in the explorer buffer and saving it (`<leader>w`).
