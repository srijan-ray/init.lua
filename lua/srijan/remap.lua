vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.keymap.set

map("n", "<leader>pv", vim.cmd.Ex, { desc = "Open netrw file explorer" })

-- Move selected lines up/down
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Join lines but keep the cursor put
map("n", "J", "mzJ`z", { desc = "Join line below (keep cursor)" })

-- Half-page jumps and search results stay centered
map("n", "<c-d>", "<C-d>zz", { desc = "Half page down (centered)" })
map("n", "<c-u>", "<C-u>zz", { desc = "Half page up (centered)" })
map("n", "n", "nzzzv", { desc = "Next search result (centered)" })
map("n", "N", "Nzzzv", { desc = "Prev search result (centered)" })

-- greatest remap ever: paste over selection without clobbering the register
map("x", "<leader>p", [["_dP]], { desc = "Paste over selection (keep register)" })

-- next greatest remap ever : asbjornHaland — yank to system clipboard
map({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to system clipboard" })
map("n", "<leader>Y", [["+Y]], { desc = "Yank line to system clipboard" })

-- Delete to the void register (don't overwrite the yank)
-- NOTE: moved off <leader>d so it doesn't collide with the debug (<leader>d…) group
map({ "n", "v" }, "<leader>D", [["_d]], { desc = "Delete to void register" })

-- Disable Ex mode
map("n", "Q", "<nop>", { desc = "Disabled (Ex mode)" })

-- Format the current buffer (via conform.nvim, falls back to LSP)
map("n", "<leader>f", function()
    require("conform").format({ async = true, lsp_format = "fallback" })
end, { desc = "Format buffer" })

-- Quickfix / location list navigation
map("n", "<leader>qn", "<cmd>cnext<CR>zz", { desc = "Quickfix: next" })
map("n", "<leader>qp", "<cmd>cprev<CR>zz", { desc = "Quickfix: prev" })
map("n", "<leader>k", "<cmd>lnext<CR>zz", { desc = "Loclist: next" })
map("n", "<leader>j", "<cmd>lprev<CR>zz", { desc = "Loclist: prev" })

-- Search & replace the word under the cursor
map("n", "<leader>sx", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Replace word under cursor" })

-- Make the current file executable
-- NOTE: moved off <leader>x so it doesn't collide with the Trouble (<leader>x…) group
map("n", "<leader>X", "<cmd>!chmod +x %<CR>", { silent = true, desc = "Make file executable" })

-- Doc previews
map("n", "<leader>vmd", vim.cmd.MarkdownPreview, { desc = "Markdown preview" })
map("n", "<leader>vtx", vim.cmd.VimtexView, { desc = "VimTeX view PDF" })

-- Re-source the current file
map("n", "<leader><leader>", "<cmd>so<CR>", { desc = "Source current file" })

-- Clear search highlight
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

-- Save file
map({ "n", "i", "x", "s" }, "<C-s>", "<cmd>w<CR><Esc>", { desc = "Save file" })

-- Window navigation (LazyVim-style)
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- Resize windows with arrow keys
map("n", "<C-Up>", "<cmd>resize +2<CR>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<CR>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<CR>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<CR>", { desc = "Increase window width" })

-- Stay in visual mode while indenting
map("v", "<", "<gv", { desc = "Indent left (keep selection)" })
map("v", ">", ">gv", { desc = "Indent right (keep selection)" })
