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
| `<C-i>` | Focus window **Right** | Pinky |

> [!WARNING]
> **Terminal Keycode Overlap:** 
> In most terminal emulators, `<C-m>` sends the same keycode as `Enter` (`<CR>`), and `<C-i>` sends the same keycode as `Tab`. 
>
> To prevent these global window navigation maps from breaking `Enter` in specific windows, buffer-local overrides are applied:
> - **Quickfix / References:** `Enter` is restored to its default jump-to-file behavior (see `lua/config/autocmds.lua`).

### Window Split
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>v` | Split window **Vertically** | Action |
| `<leader>h` | Split window **Horizontally** | Action |

### Global Actions
| Key | Action | Description |
|-----|--------|-------------|
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
| `<leader>.` | Next Buffer | Cycles to the next open buffer |
| `<leader>,` | Previous Buffer | Cycles to the previous open buffer |
| `<leader>c` | Delete Buffer | Closes the current buffer |

### Terminal Management
| Key | Action | Description |
|-----|--------|-------------|
| `<Esc><Esc>` | Exit Terminal Mode | Switch back to normal mode from terminal |
| `<leader>t` | Terminal Split | Open terminal in a vertical split |
| `<leader>tx` | Kill Terminal | Force delete the current terminal buffer |

### LSP Actions
| Key | Action | Description |
|-----|--------|-------------|
| `gd` | Go to definition | Jumps to the definition |
| `gD` | Go to declaration | Jumps to the declaration |
| `gr` | References | List all references |
| `gi` | Implementation | Go to implementation |
| `<leader>i` | Hover Info | Show documentation/type info |
| `<leader>cr` | Rename | Rename symbol workspace-wide |
| `<leader>ca` | Code Action | Show available code actions |
| `<leader>dn` | Next Diagnostic | Jump to next error/warning |
| `<leader>dp` | Prev Diagnostic | Jump to previous error/warning |
| `<leader>df` | Floating Diagnostic | Show diagnostic in a floating window |

---

## 🚀 Workflows

### Side-by-Side Editing & Buffer Management
To work on two or more files simultaneously:

1.  **Split the window**: Press `<leader>v` (vertical split) or `<leader>h` (horizontal split).
2.  **Navigate to the new split**: Use your directional keys (e.g., `<C-i>` to move right into a new vertical split).
3.  **Open a file**:
    *   Press `<leader>ff` to search for a file and open it in the active split.
    *   Press `<leader>e` to open the file explorer and navigate to a file.
    *   Press `<leader>fb` to pick from already open buffers.
4.  **Jump between them**: Use `<C-m>` and `<C-i>` to bounce between your side-by-side buffers.
5.  **Save and Close**:
    *   When you are done editing a side-by-side buffer, make sure you save your changes by typing **`:w`** and pressing Enter.
    *   To close the active split/window, type **`:q`** and press Enter. This will hide the split without closing your other windows.
    *   *(Note: You can also combine these into `:wq` to save and quit the window simultaneously, or use `:qa` to quit all windows).*

### Advanced Split Tips
*   **Maximized View**: To quickly close all other splits and focus ONLY on the current one, type `:only` and press Enter.
*   **Resize Splits**: Use Neovim's default resize commands if needed:
    *   `:vertical resize +5` (make vertical split wider)
    *   `:resize +5` (make horizontal split taller)
*   **Close Buffer (Not just Window)**: If you want to close a file completely so it doesn't show up in `<leader>fb` anymore, press **`<leader>c`**.

### Terminal Integration
1.  **Open a Terminal**: Press **`<leader>t`** to instantly open a new terminal in a vertical split next to your code.
2.  **Exit Terminal Mode**: When typing in the terminal, you are in Terminal-Mode. To navigate back to your code, you must exit this mode by pressing **`<Esc><Esc>`** (double-tap Escape).
3.  **Navigate**: Once back in Normal mode, use `<C-m>` to move back to your code window. You can interact with the terminal buffer just like any other file!

### Autocomplete & Documentation
This config uses `blink.cmp` for autocomplete and LSP for documentation.

*   **Completion Menu**: Documentation is **not** shown automatically to keep the UI clean.
    *   While the completion menu is open, press **`<C-space>`** to toggle the documentation window.
*   **Accept Selection**: While the completion menu is open, press **`<Tab>`** to select and accept the current suggestion.
*   **LSP Hover**: To see documentation/type info for the symbol under your cursor in normal mode, press **`<leader>i`**.


### File System Management (`mini.files`)
*   **Toggle**: Press `<leader>e`.
*   **Navigation**: Use standard movement keys. It includes a **preview window** on the right.
*   **Editing**: You can rename, create, or move files by editing the text in the explorer buffer and saving it (**`:w`**).
