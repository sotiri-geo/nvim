# Neovim Configuration

This configuration is optimized for efficient window management and development workflow.

## ⌨️ Custom Keymaps

### Window Navigation & Management
Use the **<leader>w** prefix followed by an arrow key to jump directly to the window in that direction.

Using a leader mapping rather than a `Ctrl` pair is deliberate: inside `tmux` with `extended-keys` off, `<C-i>` and `<C-m>` are byte-identical to `Tab` and `Enter`, so binding them would break `Tab` completion and the picker preview toggle.

| Key | Action | Description |
|-----|--------|-------------|
| `<leader>w<Left>` | Focus window **Left** | Navigate to the window on the left |
| `<leader>w<Right>` | Focus window **Right** | Navigate to the window on the right |

### Window Split
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>v` | Split window **Vertically** | Action |
| `<leader>h` | Split window **Horizontally** | Action |

### Global Actions
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>e` | File Explorer | Toggle `mini.files` (relative to current file) |
| `<leader>E` | File Explorer | Toggle `mini.files` (cwd) |
| `<leader>sg` | Copy Link | Copy Sourcegraph link to clipboard |
| `<leader>yp` | Copy Path | Copy relative filepath to clipboard |

### Picker (`fzf-lua`)
| Key | Action |
|-----|--------|
| `<leader>ff` | Find Files |
| `<leader>fg` | Live Grep |
| `<leader>fb` | Find Buffers |
| `<leader>fh` | Help Tags |
| `<leader>fv` | Recent Visited Files (current cwd/project) |
| `<leader>fw` | Live Grep word under cursor (or selection, in visual mode) |
| `<leader>fy` | Live Grep the last yank |

`fzf-lua` is pinned to a specific commit rather than a version range, because upstream has no
maintained stable branch and no releases - its newest tag is 872 commits behind `main`. Bumping it
is a deliberate edit to `lua/plugins/init.lua`, not something `vim.pack.update()` does.

#### Filtering grep by file extension
Append ` -- ` to the query, then one or more glob patterns:

| Query | Effect |
|-------|--------|
| `handleRequest` | Search everything |
| `handleRequest -- *.go` | Only Go files |
| `handleRequest -- *.py` | Only Python files |
| `handleRequest -- *.go !*_test.go` | Go files, excluding tests |
| `handleRequest -- lua/**` | Only under `lua/` |

Globs are translated to ripgrep `--iglob` arguments (case-insensitive; `!` negates). This works in
every grep picker, not just `<leader>fg` - `rg_glob` is enabled by default.

#### Useful keys while searching

| Key | Action |
|-----|--------|
| `<F4>` | Toggle the preview pane |
| `<F1>` | Toggle the help / show all bindings |
| `<F2>` | Toggle fullscreen |
| `<C-n>` / `<C-p>` | Next / previous result |
| `<C-d>` / `<C-u>` | Half page down / up in the result list (matches `mini.files`) |
| `<C-f>` / `<C-b>` | Half page down / up in the result list (same thing) |
| `<C-r>` | Clear the query line (fzf's `ctrl-u` default, moved aside) |
| `<S-Down>` / `<S-Up>` | Page down / up **in the preview** |
| `<Tab>` | Toggle multi-select on the focused result |
| `<C-g>` | Toggle between live grep and fuzzy-filtering the current results |
| `<CR>` | Open |
| `<C-s>` / `<C-v>` / `<C-t>` | Open in split / vsplit / tab |
| `<M-q>` | Send results to the quickfix list |

`<C-g>` is worth knowing: live grep re-runs ripgrep on every keystroke, so it matches literally.
Press `<C-g>` to freeze the current result set and fuzzy-filter within it instead.

Reference: `:help fzf-lua`, and `:FzfLua` with no arguments to browse every available picker.

#### Pasting into the prompt
`fzf` runs in a terminal buffer, so a register cannot be pasted straight into the query prompt
(`<C-v>` opens in a vertical split here). Instead the search term is seeded before the picker
opens:

| Key | Searches for |
|-----|--------------|
| `<leader>fy` | The last yank (register `0`) |
| `<leader>fw` | The word under the cursor (normal mode) |
| `<leader>fw` | The visual selection (visual mode) |

Example: yank text with `y`, then press `<leader>fy` to grep for it. Add ` -- *.go` to narrow.

### Buffer Management
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>.` | Next Buffer | Cycles to the next open buffer |
| `<leader>,` | Previous Buffer | Cycles to the previous open buffer |
| `<leader>x` | Delete Buffer | Closes the current buffer |

### Terminal Management
| Key | Action | Description |
|-----|--------|-------------|
| `<Esc><Esc>` | Exit Terminal Mode | Switch back to normal mode from terminal |
| `<leader>t` | Terminal Split | Open terminal in a vertical split |
| `<leader>X` | Kill Terminal | Force delete the current terminal buffer |

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
2.  **Navigate to the new split**: Use `<leader>w<Left>` / `<leader>w<Right>` to hop into the split you just created.
3.  **Open a file**:
    *   Press `<leader>ff` to search for a file and open it in the active split.
    *   Press `<leader>e` (relative to current file) or `<leader>E` (cwd) to open the file explorer and navigate to a file.
    *   Press `<leader>fb` to pick from already open buffers.
4.  **Jump between them**: Use `<leader>w<Left>` and `<leader>w<Right>` to bounce between your side-by-side buffers.
5.  **Save and Close**:
    *   When you are done editing a side-by-side buffer, make sure you save your changes by typing **`:w`** and pressing Enter.
    *   To close the active split/window, type **`:q`** and press Enter. This will hide the split without closing your other windows.
    *   *(Note: You can also combine these into `:wq` to save and quit the window simultaneously, or use `:qa` to quit all windows).*

### Advanced Split Tips
*   **Maximized View**: To quickly close all other splits and focus ONLY on the current one, type `:only` and press Enter.
*   **Resize Splits**: Use Neovim's default resize commands if needed:
    *   `:vertical resize +5` (make vertical split wider)
    *   `:resize +5` (make horizontal split taller)
*   **Close Buffer (Not just Window)**: If you want to close a file completely so it doesn't show up in `<leader>fb` anymore, press **`<leader>x`**.

### Terminal Integration
1.  **Open a Terminal**: Press **`<leader>t`** to instantly open a new terminal in a vertical split next to your code.
2.  **Exit Terminal Mode**: When typing in the terminal, you are in Terminal-Mode. To navigate back to your code, you must exit this mode by pressing **`<Esc><Esc>`** (double-tap Escape).
3.  **Navigate**: Once back in Normal mode, press `<leader>w<Left>` to move back to your code window. You can interact with the terminal buffer just like any other file!

### Autocomplete & Documentation
This config uses `blink.cmp` for autocomplete and LSP for documentation.

*   **Completion Menu**: Documentation is **not** shown automatically to keep the UI clean.
    *   While the completion menu is open, press **`<C-space>`** to toggle the documentation window.
*   **Accept Selection**: While the completion menu is open, press **`<Tab>`** to select and accept the current suggestion.
*   **LSP Hover**: To see documentation/type info for the symbol under your cursor in normal mode, press **`<leader>i`**.


### Go Formatting
Formatting and import organization are applied automatically on save for Go buffers via the native LSP client.

*   **Format-on-Save**: Saving a Go file (`:w`) synchronously runs `gopls` to organize imports and format the buffer.


### Commenting Code
Neovim 0.10+ has native commenting built-in. It automatically detects the language and applies the correct comment syntax (e.g., `//` for Go, `--` for Lua, `#` for Python).

*   **Visual Mode (`Shift + V`)**: Select the lines you want to comment/uncomment and press **`gc`**.
*   **Normal Mode (`gcc`)**: Toggle comment on the current line.
*   **Normal Mode (`gc` + motion)**: Comment a text object or motion (e.g., **`gc4j`** to comment the current line and the 4 below it, or **`gcip`** to comment an inner paragraph).


### Surrounding Text (`mini.surround`)
Add, delete, or replace the delimiters (quotes, brackets, tags) wrapped around a text object.

| Key | Action |
|-----|--------|
| `sa` + object + delimiter | Add surrounding |
| `sd` + delimiter | Delete surrounding |
| `sr` + delimiter + new delimiter | Replace surrounding |
| `sf` / `sF` | Find surrounding (search right/left) |

**Add** (`sa` + a text object + the delimiter to add):

| Command | Before | After |
|---------|--------|-------|
| `saiw"` | `hello` | `"hello"` |
| `saiw(` | `hello` | `( hello )` (padded automatically) |
| `viw` then `sa'` | `hello` (visual selection) | `'hello'` |
| `sap<` (prompts for tag name, e.g. `div<CR>`) | `hello` | `<div>hello</div>` |

**Delete** (`sd` + the delimiter to remove):

| Command | Before | After |
|---------|--------|-------|
| `sd"` | `"hello"` | `hello` |
| `sd)` | `(hello)` | `hello` |
| `sdb` | `[hello]` (any bracket) | `hello` |
| `sdt` | `<div>hello</div>` | `hello` |

**Replace** (`sr` + delimiter to find + delimiter to replace it with):

| Command | Before | After |
|---------|--------|-------|
| `sr"'` | `"hello"` | `'hello'` |
| `sr)]` | `(hello)` | `[hello]` |
| `srb}` | `[hello]` (any bracket → `}`) | `{hello}` |
| `srt` (prompts twice, e.g. `div<CR>span<CR>`) | `<div>hello</div>` | `<span>hello</span>` |

**Find** (`sf` / `sF` — jumps the cursor to the matching delimiter without changing anything, useful before an operator like `d` or `c`):

| Command | Cursor starts | Cursor ends up |
|---------|----------------|----------------|
| `sf)` | inside `(hello)`, before `)` | on the closing `)` |
| `sF(` | inside `(hello)`, after `(` | on the opening `(` |

Reference: `:help MiniSurround`.

### Smarter Text Objects (`mini.ai`)
Extends the native `a`/`i` (around/inside) text objects to be treesitter-aware, and adds new ones.

| id | Targets |
|----|---------|
| `( ) [ ] { } < >` | Balanced brackets |
| `b` | Alias for any closing bracket |
| `' " `` ` `` | Quotes |
| `q` | Alias for any quote |
| `t` | HTML/XML tag |
| `f` | Function call |
| `a` | Function argument |

Works like any native text object — `<operator><a|i><id>` — with `d` (delete), `c` (change), `y` (yank), or `v` (select):

| Command | Cursor in / near | Before | After |
|---------|-------------------|--------|-------|
| `di"` | `say "hello world"` | between the quotes | `say ""` |
| `da"` | `say "hello world"` | between the quotes | `say` |
| `di(` | `foo(bar(1, 2))`, cursor on `1` | innermost parens resolved automatically | `foo(bar())` |
| `daf` | `foo(bar(1, 2))`, cursor on `bar` | whole call incl. its own parens | `foo()` |
| `dif` | `foo(bar(1, 2))`, cursor on `bar` | just the call's arguments | `foo(bar())` |
| `cia` | `foo(bar, baz)`, cursor on `baz` | the argument under the cursor | `foo(bar, )` then insert mode |
| `dat` | `<div>hello</div>` | whole tag incl. `<div>`/`</div>` | (removed entirely) |
| `dit` | `<div>hello</div>` | just the tag's inner content | `<div></div>` |
| `yiq` | `'hello'` (any quote style) | text inside nearest quote | yanks `hello` |

Append `n`/`l` after `a`/`i` to target the **n**ext/**l**ast occurrence without moving the cursor there first:

| Command | Effect |
|---------|--------|
| `din"` | Delete inside the next `"..."` ahead of the cursor |
| `dal(` | Delete around the last `(...)` before the cursor |
| `2din(` | Delete inside the 2nd next `(...)` ahead of the cursor |

Reference: `:help MiniAi`.

Reference: `:help MiniAi`.

### File System Management (`mini.files`)
*   **Toggle**: Press `<leader>e` to open relative to the current file, or `<leader>E` to open from the project root (cwd).
*   **Navigation**: Use standard movement keys. It includes a **preview window** on the right.
*   **Editing**: You can rename, create, or move files by editing the text in the explorer buffer and saving it (**`:w`**).

### Recent Files (`fzf-lua`)
Recent files come from Neovim's own oldfiles list (`v:oldfiles`, persisted via shada), surfaced
through `fzf.oldfiles`.

*   **Project Recent Files**: Press `<leader>fv` to show recent files for the current working directory/project.
*   **Ordering**: Most recently used first.
*   **Scope**: `cwd_only = true` filters out anything that lies physically outside the current working directory. To change projects, start Neovim in the project directory or use `:cd /path/to/project`.
*   **Current session**: `include_current_session = true` is set deliberately. `v:oldfiles` is only populated from the shada file at startup and is *not* updated as you work, so without this flag files opened during the current session would never appear.
*   **Note on semantics**: this lists "recently opened files that live under the cwd", which is not quite the same as "files opened while working in this project" - a file belonging to this project but opened from elsewhere still counts.

### Statusline (`mini.statusline`)
A minimal statusline showing the current mode, git branch, diff summary (via `mini.diff`), LSP diagnostics, filename, filetype, and cursor location. No keymaps — it renders automatically once the buffer has content.

### Animations (`mini.animate`)
Cursor movement, scrolling, and window resize/open/close are animated automatically. No keymaps or setup required day-to-day; if the animations aren't to your taste, adjust or disable them in `lua/plugins/animate.lua`.

### 📋 Remote Clipboard Sync (SSH + Tmux)
This configuration implements automatic, high-performance clipboard synchronization from this remote headless Neovim session to your local system clipboard over SSH and Tmux using **OSC 52 escape sequences**.

#### Behavior
- **Explicit Yanks Only**: Pressing **`y`** (e.g., `yy`, `yw`, `y$`) in normal or visual mode automatically copies the yanked text to your local macOS/system clipboard.
- **Deletions Ignored**: Deletions (`d`, `c`, `x`, etc.) do **not** sync to your local clipboard. This prevents your local clipboard manager (e.g., Maccy, Alfred, Clipy) from being flooded with transient edits.
- **Sourcegraph Link Keymap**: Pressing **`<leader>sg`** copies the corrected Sourcegraph URL for the current file directly to your local clipboard using the OSC 52 pipeline.

#### Mandatory Local Setup Requirements

1. **iTerm2 Settings (Local Machine)**:
   - Open iTerm2 Preferences (`Cmd + ,`).
   - Go to **General** -> **Selection**.
   - Under the **Clipboard** header, check **"Applications in terminal may access clipboard"**.

2. **Tmux Configuration (Remote Host)**:
   - Add this setting to your `~/.tmux.conf`:
     ```tmux
     set -s set-clipboard on
     ```
   - Reload your Tmux configuration: `tmux source-file ~/.tmux.conf`.
