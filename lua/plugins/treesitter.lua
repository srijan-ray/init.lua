-- nvim-treesitter on the `main` branch (the rewrite). This is the right fit for
-- Neovim 0.11+/0.12 and natively avoids the master-branch injection/directive
-- incompatibilities. It requires the external `tree-sitter` CLI to build parsers
-- (installed via `brew install tree-sitter`).
return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        build = ":TSUpdate",
        -- Load just before the first file's FileType fires so an empty-dashboard
        -- start stays fast, while highlighting still attaches to the first buffer.
        event = { "BufReadPre", "BufNewFile" },
        init = function()
            -- Insurance shim for Neovim 0.11+/0.12: some third-party query directive
            -- handlers pass `match[id]` (now a LIST of nodes) straight to
            -- get_node_text(), which then calls node:range() on a table and errors.
            -- Normalise a stray node-list back to a single node. Harmless otherwise.
            local get_node_text = vim.treesitter.get_node_text
            vim.treesitter.get_node_text = function(node, source, opts)
                if type(node) == "table" then
                    node = node[#node]
                end
                return get_node_text(node, source, opts)
            end
        end,
        config = function()
            require("nvim-treesitter").setup()

            local ensure_installed = {
                "bash",
                "c",
                "cpp",
                "css",
                "diff",
                "dockerfile",
                "gitcommit",
                "gitignore",
                "go",
                "gomod",
                "hcl",
                "html",
                "http",
                "java",
                "javascript",
                "jsdoc",
                "json",
                "latex",
                "lua",
                "luadoc",
                "markdown",
                "markdown_inline",
                "python",
                "query",
                "regex",
                "rust",
                "sql",
                "terraform",
                "toml",
                "tsx",
                "typescript",
                "vim",
                "vimdoc",
                "vue",
                "yaml",
            }

            -- Install any parsers we don't already have (async, non-blocking).
            local installed = require("nvim-treesitter.config").get_installed("parsers")
            local to_install = vim.tbl_filter(function(lang)
                return not vim.tbl_contains(installed, lang)
            end, ensure_installed)
            if #to_install > 0 then
                require("nvim-treesitter").install(to_install)
            end

            -- Enable highlighting + treesitter-based indentation for any buffer
            -- whose language has a parser available.
            vim.api.nvim_create_autocmd("FileType", {
                group = vim.api.nvim_create_augroup("srijan_treesitter", { clear = true }),
                callback = function(event)
                    -- start() errors if no parser is available, so guard it.
                    if not pcall(vim.treesitter.start, event.buf) then
                        return
                    end
                    local lang = vim.treesitter.language.get_lang(vim.bo[event.buf].filetype)
                    if lang and vim.treesitter.query.get(lang, "indents") then
                        vim.bo[event.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                    end
                end,
            })
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        branch = "main",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("nvim-treesitter-textobjects").setup({
                select = { lookahead = true },
                move = { set_jumps = true },
            })

            local move = require("nvim-treesitter-textobjects.move")
            local map = vim.keymap.set
            -- Jump between functions / classes (select textobjects like af/if are
            -- left to mini.ai to avoid clashes).
            map({ "n", "x", "o" }, "]f", function()
                move.goto_next_start("@function.outer", "textobjects")
            end, { desc = "Next function start" })
            map({ "n", "x", "o" }, "]c", function()
                move.goto_next_start("@class.outer", "textobjects")
            end, { desc = "Next class start" })
            map({ "n", "x", "o" }, "[f", function()
                move.goto_previous_start("@function.outer", "textobjects")
            end, { desc = "Prev function start" })
            map({ "n", "x", "o" }, "[c", function()
                move.goto_previous_start("@class.outer", "textobjects")
            end, { desc = "Prev class start" })
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            max_lines = 3,
            multiline_threshold = 1,
            trim_scope = "outer",
            mode = "cursor",
        },
        keys = {
            {
                "[C",
                function()
                    require("treesitter-context").go_to_context(vim.v.count1)
                end,
                desc = "Jump to context (upwards)",
            },
        },
    },
}
