# Neovim Config

My personal Neovim configuration — a lazy.nvim setup modelled loosely on LazyVim
(borrowing its optimizations and plugin choices) but hand-rolled, for Python,
Java, Rust, C/C++, Go, and web (JS/TS/Vue/Astro) development, plus Markdown,
LaTeX, and notebook/data-science work.

> **Leader key:** `<Space>` (local leader is also `<Space>`)

---

## Requirements

- **Neovim 0.11+** (built/tested on 0.12).
- **`tree-sitter` CLI** — `brew install tree-sitter` (needed to build parsers; nvim-treesitter is on the `main` branch).
- **A C compiler** (`cc`/clang) — comes with the Xcode command-line tools.
- **ripgrep** (`rg`) and **fd** — for fzf-lua grep/file search.
- **Node.js** — for some LSPs/formatters (prettier, vtsls, etc.).
- **lazygit** — for the git UI (`<leader>gs`).
- LSP servers, formatters, linters, and debug adapters are installed
  automatically by **Mason** / **mason-lspconfig** / **mason-nvim-dap** on first use.

---

## First-run notes

- On first launch, plugins install automatically, and **treesitter parsers**
  compile in the background (you'll briefly see `Downloading… / Compiling…`).
- Run `:Mason` to watch/trigger LSP + tool installs; `:checkhealth` to diagnose.

---

## Keybindings

### General / editing
| Key | Action |
|-----|--------|
| `<leader>pv` | Open netrw file explorer |
| `-` | Open parent directory (oil.nvim) |
| `<C-s>` | Save file (normal/insert/visual) |
| `<leader>f` | Format buffer (conform, LSP fallback) |
| `<Esc>` | Clear search highlight |
| `<leader><leader>` | Source the current file |
| `J` / `K` (visual) | Move selection down / up |
| `J` (normal) | Join line below, keep cursor |
| `<C-d>` / `<C-u>` | Half-page down / up (centered) |
| `n` / `N` | Next / prev search result (centered) |
| `<leader>y` / `<leader>Y` | Yank (line) to system clipboard |
| `<leader>p` (visual) | Paste over selection without clobbering register |
| `<leader>D` | Delete to the void register |
| `<leader>sx` | Search & replace the word under the cursor |
| `<leader>X` | Make current file executable (`chmod +x`) |
| `<` / `>` (visual) | Indent left / right, keep selection |

### Windows & navigation
| Key | Action |
|-----|--------|
| `<C-h/j/k/l>` | Move to left/down/up/right window |
| `<C-Up/Down>` | Resize window height |
| `<C-Left/Right>` | Resize window width |
| `<leader>qn` / `<leader>qp` | Quickfix next / prev |
| `<leader>k` / `<leader>j` | Location-list next / prev |
| `'` | Arrow.nvim bookmarks menu |
| `m` | Arrow.nvim per-buffer bookmarks |
| `<leader>u` | Toggle Undotree |
| `<leader>?` | Show buffer-local keymaps (which-key) |

### Search (fzf-lua)
| Key | Action |
|-----|--------|
| `<leader>sf` | Find files |
| `<leader>sg` | Live grep |
| `<leader>sb` | Buffers |
| `<leader>sh` | Help tags |
| `<leader>sk` | Keymaps |
| `<leader>sr` | Recent files |
| `<leader>ss` | Resume last picker |
| `<leader>st` | Search TODOs |
| `<leader>/` | Fuzzy-search current buffer |

### LSP
| Key | Action |
|-----|--------|
| `K` | Hover documentation |
| `<C-f>` / `<C-b>` | Scroll the hover / docs popup down / up |
| `<leader>gd` | Go to definition |
| `<leader>gD` | Go to declaration |
| `<leader>gr` | References |
| `<leader>gi` | Implementations |
| `<leader>gt` | Type definition |
| `<leader>ds` | Document symbols |
| `<leader>ws` | Workspace symbols |
| `<leader>ca` | Code actions |
| `<leader>rn` | Rename symbol |
| `<leader>e` | Show diagnostic float |
| `[d` / `]d` | Previous / next diagnostic |
| `<leader>wd` | Workspace diagnostics |
| `<leader>th` | Toggle inlay hints |
| `<leader>lse` / `<leader>lsd` | Enable / disable diagnostics |

### Completion (blink.cmp — insert mode)
| Key | Action |
|-----|--------|
| `<C-Space>` | Open menu / show docs (toggles the LSP documentation window) |
| `<C-f>` / `<C-b>` | Scroll the documentation window down / up |
| `<C-k>` | Toggle signature help |
| `<C-n>` / `<C-p>` | Next / previous item |
| `<C-y>` | Accept selected item |
| `<C-e>` | Cancel / close menu |
| `<Tab>` / `<S-Tab>` | Jump forward / backward in snippet |

### Git
| Key | Action |
|-----|--------|
| `<leader>gs` | Open LazyGit |
| `]h` / `[h` | Next / previous hunk |
| `<leader>ghs` / `<leader>ghr` | Stage / reset hunk |
| `<leader>ghS` / `<leader>ghR` | Stage / reset buffer |
| `<leader>ghu` | Undo stage hunk |
| `<leader>ghp` | Preview hunk inline |
| `<leader>ghb` | Blame line |
| `<leader>ghd` / `<leader>ghD` | Diff this / diff against `~` |
| `ih` (operator/visual) | Select hunk text object |

### Diffview (multi-file review)
Best for reviewing a **whole changeset at once** (e.g. after a big multi-file
edit) instead of diff-by-diff — gives you a file panel you tab through like a PR.

| Key | Action |
|-----|--------|
| `<leader>gvo` | Open Diffview (review all pending changes) |
| `<leader>gvc` | Close Diffview |
| `<leader>gvf` | Toggle the file panel |
| `<leader>gvh` | File history of the current file |
| `<leader>gvH` | File history of the whole repo |

### Diagnostics / Trouble
| Key | Action |
|-----|--------|
| `<leader>xw` | Workspace diagnostics (Trouble) |
| `<leader>xb` | Buffer diagnostics (Trouble) |
| `<leader>xs` | Symbols (Trouble) |
| `<leader>xl` | LSP definitions/references (Trouble) |
| `<leader>xL` | Location list (Trouble) |
| `<leader>xq` | Quickfix list (Trouble) |

### Debugging (nvim-dap)
| Key | Action |
|-----|--------|
| `<leader>dt` | Toggle breakpoint |
| `<leader>dB` | Conditional breakpoint |
| `<leader>dc` | Continue / start |
| `<leader>di` / `<leader>do` / `<leader>dO` | Step into / over / out |
| `<leader>dr` | Toggle REPL |
| `<leader>dl` | Run last |
| `<leader>dx` | Terminate |
| `<leader>du` | Toggle DAP UI |
| `<leader>de` | Evaluate (normal/visual) |

### Java (in `.java` buffers — nvim-java)
| Key | Action |
|-----|--------|
| `<leader>jr` / `<leader>js` | Run / stop main app |
| `<leader>jl` | Toggle run logs |
| `<leader>jt` / `<leader>jT` | Test current class / method |
| `<leader>jd` / `<leader>jD` | Debug test class / method |
| `<leader>jv` | View last test report |

### Treesitter motions & TODOs
| Key | Action |
|-----|--------|
| `]f` / `[f` | Next / previous function start |
| `]c` / `[c` | Next / previous class start |
| `[C` | Jump to context (scroll into the sticky context line) |
| `<C-Space>` (normal/visual) | Start / expand incremental selection |
| `]t` / `[t` | Next / previous TODO comment |

### REPL / Notebooks (iron.nvim)
| Key | Action |
|-----|--------|
| `<Space>rs` / `<Space>rr` | Open / restart REPL |
| `<Space>rf` / `<Space>rh` | Focus / hide REPL |
| `<Space>isl` / `<Space>isp` / `<Space>isf` | Send line / paragraph / file |
| `<Space>isc` | Send motion or visual selection |

### AI (Claude Code)
| Key | Action |
|-----|--------|
| `<leader>ac` | Toggle Claude |
| `<leader>af` | Focus Claude |
| `<leader>ar` / `<leader>aC` | Resume / continue session |
| `<leader>am` | Select model |
| `<leader>ab` | Add current buffer to context |
| `<leader>as` | Send selection (visual) / add file (from a tree) |
| `<leader>aa` / `<leader>ad` | Accept / deny diff |

### Docs / misc
| Key | Action |
|-----|--------|
| `<leader>vmd` | Markdown preview (in browser) |
| `<leader>vtx` | VimTeX view PDF |
| `<leader>pi` | Paste image from clipboard |
| `<leader>;` | Pick symbol in winbar (dropbar) |
| `[;` / `];` | Dropbar: context start / next context |

---

## Useful commands

| Command | Purpose |
|---------|---------|
| `:Lazy` | Plugin manager (install/update/clean/profile) |
| `:Mason` | Install/manage LSP servers, formatters, linters, DAP adapters |
| `:TSUpdate` / `:TSInstall <lang>` | Update / install treesitter parsers |
| `:ConformInfo` | Show formatters available for the buffer |
| `:LazyGit` | Git TUI |
| `:MarkdownPreview` / `:MarkdownPreviewToggle` | Markdown live preview |
| `:Trouble` | Diagnostics/symbols list |
| `:UndotreeToggle` | Undo history tree |
| `:Leet` | LeetCode (uses fzf-lua picker) |
| `:VimBeGood` | Vim practice game |
| `:ClaudeCode` | Toggle the Claude Code terminal |
| `:checkhealth` | Diagnose config/plugin/LSP issues |

---

## Adding a language

1. **LSP:** add the server name to `ensure_installed` in
   `lua/plugins/lsp-tooling.lua` and `vim.lsp.enable("<server>")`.
2. **Treesitter:** add the parser to `ensure_installed` in
   `lua/plugins/treesitter.lua` (or run `:TSInstall <lang>`).
3. **Formatter:** add it under `formatters_by_ft` in
   `lua/plugins/lintandformat.lua`.
4. **Debugger:** add the adapter to `mason-nvim-dap`'s `ensure_installed` in
   `lua/plugins/debug.lua`.

---

## Layout

```
init.lua                 -- bootstraps lazy.nvim + loads lua/srijan
lua/srijan/
  set.lua                -- options
  remap.lua              -- core keymaps
  autocmds.lua           -- autocommands
lua/plugins/             -- one file per plugin/topic (auto-loaded by lazy)
after/lsp/               -- per-server LSP overrides (vtsls, vue_ls)
```
