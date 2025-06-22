return {
    {
        "mason-org/mason.nvim",
        opts = {}
    },
    {
        "mason-org/mason-lspconfig.nvim",
        opts = {
            ensure_installed = {
                "lua_ls",
                "ruff",
                "ts_ls",
                "vue_ls",
                "astro",
            }
        },
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            {
                "folke/lazydev.nvim",
                ft = "lua", -- only load on lua files
                opts = {
                    library = {
                        -- See the configuration section for more details
                        -- Load luvit types when the `vim.uv` word is found
                        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                    },
                },
            },
            { "j-hui/fidget.nvim", opts = {} },
        },
        config = function()
            -- Some UI edits
            vim.lsp.inlay_hint.enable()
            vim.diagnostic.config({
                virtual_lines = true,
                signs = {
                    text = {
                        [vim.diagnostic.severity.ERROR] = '',
                        [vim.diagnostic.severity.WARN] = '',
                        [vim.diagnostic.severity.HINT] = '󰛨',
                        [vim.diagnostic.severity.INFO] = '󰋼',
                    },
                    linehl = {
                        [vim.diagnostic.severity.ERROR] = 'ErrorMsg',
                    },
                    numhl = {
                        [vim.diagnostic.severity.WARN] = 'WarningMsg',
                    },
                },
            })
            vim.lsp.set_log_level("off");

            -- Lua
            vim.lsp.enable('lua_ls')

            -- Python
            vim.lsp.config('basedpyright', {
                settings = {
                    basedpyright = {
                        disableOrganizeImports = true,
                        analysis = {
                            typeCheckingMode = "basic"
                        }
                    },
                    python = {
                        analysis = {
                            -- Ignore all files for analysis to exclusively use Ruff for linting
                            ignore = { '*' },
                        },
                    },
                },
            })
            vim.lsp.enable('basedpyright')
            vim.lsp.enable('ruff')

            -- JavaScript
            vim.lsp.enable('tailwindcss')
            vim.lsp.config('ts_ls', {
                init_options = {
                    plugins = {
                        {
                            name = "@vue/typescript-plugin",
                            location = "/usr/local/lib/node_modules/@vue/typescript-plugin",
                            languages = { "javascript", "typescript", "vue" },
                        },
                    },
                },
                filetypes = {
                    "javascript",
                    "typescript",
                    "vue",
                },
            })
            vim.lsp.enable('ts_ls')
            vim.lsp.enable('vue_ls')
            vim.lsp.enable('astro')

            -- Keymaps
            local fzf = require("fzf-lua")
            vim.keymap.set("n", '<leader>ca', fzf.lsp_code_actions, { desc = "[C]ode [A]ctions" })
            vim.keymap.set("n", '<leader>gr', fzf.lsp_references, { desc = "[G]o to [R]eferences" })
            vim.keymap.set("n", '<leader>gd', fzf.lsp_declarations, { desc = "[G]o to [D]eclarations" })
            vim.keymap.set("n", '<leader>wd', fzf.diagnostics_workspace, { desc = "[W]orkspace [D]iagnostics" })
            vim.keymap.set("n", '<leader>lse', ":lua vim.diagnostic.enable()<CR>", { desc = "Enable diagnostics" })
            vim.keymap.set("n", '<leader>lsd', ":lua vim.diagnostic.enable(false)<CR>", { desc = "Disable diagnostics" })
        end
    }
}
