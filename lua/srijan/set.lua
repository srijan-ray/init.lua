-- Line numbers
vim.opt.nu = true
vim.opt.relativenumber = true

-- Indentation (4-space, expand tabs)
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true
vim.opt.breakindent = true

vim.opt.wrap = true

-- Persistent undo, no swap/backup
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- Search
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.ignorecase = true -- case-insensitive searching...
vim.opt.smartcase = true  -- ...unless a capital letter is used

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"
vim.opt.showmode = false

vim.opt.cursorline = true
vim.opt.laststatus = 3 -- global statusline

-- Sync with the system clipboard
vim.opt.clipboard = "unnamedplus"

-- Sensible split behaviour
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Mouse support (handy for resizing splits / scrolling)
vim.opt.mouse = "a"

-- Better completion UX (used by blink.cmp)
vim.opt.completeopt = "menu,menuone,noselect"

-- Live preview of :substitute and friends in a split
vim.opt.inccommand = "split"

-- Prompt to save instead of erroring out on unsaved changes
vim.opt.confirm = true

-- Show a few invisible characters
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Keep the which-key popup responsive
vim.opt.timeoutlen = 400

-- Default border for floating windows that don't set their own: a slightly
-- thicker "bold" (heavy single-line) border. Note that the cmp/hover/fzf-lua
-- floats override this to be borderless in their own specs.
vim.opt.winborder = "bold"

-- Faster keyword lookups; treat these files as owned by the session
vim.opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }
