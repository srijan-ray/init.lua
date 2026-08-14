return {
    -- Databases: browse/query SQL from inside Neovim (needs the DB client CLI,
    -- e.g. psql/mysql, installed for the engines you use).
    {
        "kristijanhusak/vim-dadbod-ui",
        dependencies = {
            { "tpope/vim-dadbod", lazy = true },
            { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
        },
        cmd = { "DBUI", "DBUIToggle", "DBUIAddConnection", "DBUIFindBuffer" },
        init = function()
            vim.g.db_ui_use_nerd_fonts = 1
            vim.g.db_ui_show_help = 0
        end,
        keys = {
            { "<leader>bd", "<cmd>DBUIToggle<cr>", desc = "Toggle Database UI" },
            { "<leader>bf", "<cmd>DBUIFindBuffer<cr>", desc = "DB: find buffer" },
        },
        config = function()
            -- SQL completion from dadbod inside sql buffers
            vim.api.nvim_create_autocmd("FileType", {
                pattern = { "sql", "mysql", "plsql" },
                callback = function()
                    vim.schedule(function()
                        pcall(vim.cmd, "packadd cmp-dadbod-completion")
                    end)
                end,
            })
        end,
    },

    -- HTTP / REST client: write requests in a `.http` file and run them in-editor
    -- (needs `curl`). Great for hitting backend/AWS APIs without leaving Neovim.
    {
        "mistweaverco/kulala.nvim",
        ft = { "http", "rest" },
        opts = {
            global_keymaps = false,
        },
        -- stylua: ignore
        keys = {
            { "<leader>br", function() require("kulala").run() end,      ft = "http", desc = "HTTP: run request" },
            { "<leader>bR", function() require("kulala").run_all() end,  ft = "http", desc = "HTTP: run all requests" },
            { "<leader>bn", function() require("kulala").jump_next() end, ft = "http", desc = "HTTP: next request" },
            { "<leader>bp", function() require("kulala").jump_prev() end, ft = "http", desc = "HTTP: prev request" },
            { "<leader>bc", function() require("kulala").copy() end,     ft = "http", desc = "HTTP: copy as curl" },
            { "<leader>bi", function() require("kulala").inspect() end,  ft = "http", desc = "HTTP: inspect request" },
        },
    },
}
