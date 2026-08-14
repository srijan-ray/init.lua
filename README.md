# Neovim Config

My personal Neovim configuration — a lazy.nvim setup modelled loosely on LazyVim
(borrowing its optimizations and plugin choices) but hand-rolled, for Python,
Java, Rust, C/C++, Go, and web (JS/TS/Vue/Astro) development. Also set up for
backend work (SQL via dadbod, HTTP/REST via kulala), AWS/IaC (CloudFormation &
SAM schemas via yamlls + SchemaStore, Terraform), and a full Jupyter notebook
experience (molten + jupytext + quarto/otter) — plus Markdown and LaTeX.

> **Leader key:** `<Space>` (local leader is also `<Space>`)

---

## Prerequisites (setting up on a new machine)

**Neovim 0.11+** is required (built/tested on 0.12). LSP servers, formatters,
linters, and debug adapters install themselves via **Mason** on first use, so the
lists below are just the system-level tools those depend on.

### 1. System packages

**macOS (Homebrew)**
```bash
brew install neovim git ripgrep fd node lazygit tree-sitter imagemagick fzf
brew install --cask font-jetbrains-mono-nerd-font   # any Nerd Font
```

**Fedora / RHEL / Amazon Linux (dnf)**
```bash
sudo dnf install -y neovim git ripgrep fd-find nodejs npm ImageMagick \
  gcc gcc-c++ make unzip xclip
# tree-sitter CLI + lazygit aren't always packaged — easiest via:
npm install -g tree-sitter-cli        # or: cargo install tree-sitter-cli
# lazygit: sudo dnf copr enable atim/lazygit -y && sudo dnf install lazygit
```

**Debian / Ubuntu (apt)**
```bash
sudo apt update && sudo apt install -y git ripgrep fd-find nodejs npm \
  imagemagick build-essential unzip xclip wl-clipboard curl
# Neovim: use the unstable PPA or the AppImage — distro nvim is usually too old:
#   sudo add-apt-repository ppa:neovim-ppa/unstable && sudo apt install neovim
npm install -g tree-sitter-cli        # tree-sitter CLI
# lazygit + a Nerd Font: install from their GitHub releases
```

> Notes: on apt, `fd` is `fdfind` (symlink it: `ln -s $(which fdfind) ~/.local/bin/fd`).
> A **C compiler** (`cc`/clang/gcc) is needed for some parsers/tools — Xcode CLT on
> macOS, `build-essential`/`gcc` on Linux. On Linux install a clipboard tool
> (`xclip`/`wl-clipboard`); macOS has `pbcopy` built in.

### 2. Python + Jupyter (for the notebook stack — molten)

```bash
python3 -m pip install --user pynvim jupyter jupyter-client ipykernel jupytext
python3 -m ipykernel install --user --name python3
```
Then inside Neovim once: **`:UpdateRemotePlugins`** and restart.

### 3. Inline plots (optional but recommended)

`image.nvim` renders plots inline, which needs **ImageMagick** (above) *and* an
image-capable terminal: **kitty**, **WezTerm**, or **Ghostty**. Without one,
notebooks still work — you just get text output instead of rendered images.

### 4. Language toolchains (only what you use)

Rust (`rustup`), Go (`go`), a JDK (for Java), etc. Mason installs the *servers*
(rust-analyzer, gopls, jdtls…), but they need the actual toolchain present.
For the database UI, install the client CLI for your engine (`psql`, `mysql`, …).

---

## First-run notes

- On first launch plugins install automatically and **treesitter parsers** compile
  in the background (you'll briefly see `Downloading… / Compiling…`).
- `:Mason` — watch/trigger LSP + tool installs. `:checkhealth` — diagnose anything
  red (check `vim.provider`, `molten`, `image`, `mason` sections).
- For notebooks: after installing `pynvim`, run `:UpdateRemotePlugins` once.

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

### Jupyter notebooks (molten) — real inline execution + plots
Open a `.ipynb` (jupytext turns it into an editable buffer) or a `.py`/`.qmd`.
Needs the Python provider + Jupyter — see Prerequisites. `]n` / `[n` jump between cells.

| Key | Action |
|-----|--------|
| `<leader>mi` | Initialise a Jupyter kernel |
| `<leader>ml` | Evaluate current line |
| `<leader>me` | Evaluate operator (motion) |
| `<leader>mv` | Evaluate visual selection |
| `<leader>mj` / `<leader>mJ` | Run cell & move / run cell |
| `<leader>mc` | Re-evaluate current cell |
| `<leader>mo` / `<leader>mh` | Show / hide output |
| `<leader>md` | Delete cell output |
| `<leader>mx` | Interrupt kernel |
| `<leader>mb` | Open output in browser |
| `]n` / `[n` | Next / previous cell |

### REPL (iron.nvim — lightweight, no kernel needed)
| Key | Action |
|-----|--------|
| `<Space>rs` / `<Space>rr` | Open / restart REPL |
| `<Space>rf` / `<Space>rh` | Focus / hide REPL |
| `<Space>isl` / `<Space>isp` / `<Space>isf` | Send line / paragraph / file |
| `<Space>isc` | Send motion or visual selection |

### Backend (databases + HTTP)
| Key | Action |
|-----|--------|
| `<leader>bd` | Toggle Database UI (dadbod) |
| `<leader>bf` | DB: find buffer |
| `<leader>br` / `<leader>bR` | HTTP: run request / run all (in a `.http` file) |
| `<leader>bn` / `<leader>bp` | HTTP: next / previous request |
| `<leader>bc` / `<leader>bi` | HTTP: copy as curl / inspect request |

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
