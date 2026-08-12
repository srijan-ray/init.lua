return {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = "FzfLua",
    -- stylua: ignore
    keys = {
        { "<leader>sf", function() require("fzf-lua").files() end,        desc = "[S]earch [F]iles (fzf-lua)" },
        { "<leader>sg", function() require("fzf-lua").live_grep() end,    desc = "[S]earch by [G]rep (fzf-lua)" },
        { "<leader>sb", function() require("fzf-lua").buffers() end,      desc = "[S]earch [B]uffers (fzf-lua)" },
        { "<leader>sh", function() require("fzf-lua").help_tags() end,    desc = "[S]earch [H]elp (fzf-lua)" },
        { "<leader>sk", function() require("fzf-lua").keymaps() end,      desc = "[S]earch [K]eymaps" },
        { "<leader>sr", function() require("fzf-lua").oldfiles() end,     desc = "[S]earch [R]ecent" },
        { "<leader>ss", function() require("fzf-lua").resume() end,       desc = "Resume Search" },
        { "<leader>/",  function() require("fzf-lua").lgrep_curbuf() end, desc = "[/] Fuzzy Search current buffer" },
    },
    config = function()
        require("fzf-lua").setup({
            "max-perf",
            fzf_colors = true, -- inherit colors from the active colorscheme
            winopts = {
                -- Match the Mason UI: a borderless, backdrop-dimmed float on the
                -- mantle background (FzfLuaNormal links to the same NormalFloat that
                -- MasonNormal uses), sized like Mason (0.8 x 0.9).
                width = 0.8,
                height = 0.9,
                row = 0.5,
                col = 0.5,
                border = "none",
                backdrop = 60, -- same backdrop opacity Mason uses
                title_pos = "center",
                preview = {
                    layout = "flex",
                    border = "none",
                    scrollbar = "float",
                    title = true,
                    title_pos = "center",
                },
            },
            fzf_opts = {
                -- Thin, unobtrusive separators between fzf's internal sections
                ["--info"] = "inline-right",
                ["--layout"] = "reverse",
            },
            keymap = {
                fzf = {
                    ["ctrl-q"] = "select-all+accept",
                },
            },
        })
    end,
}
