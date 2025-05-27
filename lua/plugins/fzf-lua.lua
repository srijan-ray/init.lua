return {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
    config = function()
        local fzf = require("fzf-lua")
        fzf.setup({
            "max-perf",
            winopts = {
                border = "rounded",
                preview = { layout = "vertical" },
            },
            keymap = {
                fzf = {
                    ["ctrl-q"] = "select-all+accept",
                }
            },
        })
        vim.keymap.set("n", "<leader>sf", fzf.files, { desc = "[S]earch [F]iles (fzf-lua)" })
        vim.keymap.set("n", "<leader>sg", fzf.live_grep, { desc = "[S]earch by [G]rep (fzf-lua)" })
        vim.keymap.set("n", "<leader>sb", fzf.buffers, { desc = "[S]earch [B]uffers (fzf-lua)" })
        vim.keymap.set("n", "<leader>sh", fzf.help_tags, { desc = "[S]earch [H]elp (fzf-lua)" })
        vim.keymap.set("n", "<leader>sk", fzf.keymaps, { desc = "[S]earch [K]eymaps" })
        vim.keymap.set("n", "<leader>sr", fzf.oldfiles, { desc = "[S]earch [R]ecent" })
        vim.keymap.set("n", "<leader>/", fzf.lgrep_curbuf, { desc = "[/] Fuzzy Search current buffer" })
    end,
}
