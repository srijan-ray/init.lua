-- LazyVim-style quality-of-life autocmds
local function augroup(name)
    return vim.api.nvim_create_augroup("srijan_" .. name, { clear = true })
end

-- Briefly highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
    group = augroup("highlight_yank"),
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- Resize splits when the terminal window is resized
vim.api.nvim_create_autocmd("VimResized", {
    group = augroup("resize_splits"),
    callback = function()
        local current_tab = vim.fn.tabpagenr()
        vim.cmd("tabdo wincmd =")
        vim.cmd("tabnext " .. current_tab)
    end,
})

-- Close these throwaway/utility buffers with just `q`
vim.api.nvim_create_autocmd("FileType", {
    group = augroup("close_with_q"),
    pattern = {
        "help",
        "man",
        "qf",
        "checkhealth",
        "lspinfo",
        "notify",
        "startuptime",
        "dap-float",
    },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
        vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
    end,
})

-- Jump to the last edit position when reopening a file
vim.api.nvim_create_autocmd("BufReadPost", {
    group = augroup("last_loc"),
    callback = function(event)
        local exclude = { "gitcommit" }
        local buf = event.buf
        if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].last_loc then
            return
        end
        vim.b[buf].last_loc = true
        local mark = vim.api.nvim_buf_get_mark(buf, '"')
        local lcount = vim.api.nvim_buf_line_count(buf)
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})

-- Don't continue comments onto the next line automatically
vim.api.nvim_create_autocmd("FileType", {
    group = augroup("no_auto_comment"),
    callback = function()
        vim.opt_local.formatoptions:remove({ "c", "r", "o" })
    end,
})

-- Automatically create missing parent directories when saving a file
vim.api.nvim_create_autocmd("BufWritePre", {
    group = augroup("auto_create_dir"),
    callback = function(event)
        if event.match:match("^%w%w+:[\\/][\\/]") then
            return
        end
        local file = vim.uv.fs_realpath(event.match) or event.match
        vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
    end,
})

-- Enable spell-check and wrapping for prose filetypes
vim.api.nvim_create_autocmd("FileType", {
    group = augroup("prose"),
    pattern = { "markdown", "gitcommit", "tex", "quarto" },
    callback = function()
        vim.opt_local.spell = true
        vim.opt_local.wrap = true
    end,
})
