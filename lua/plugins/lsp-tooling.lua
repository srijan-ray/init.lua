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


            local vue_language_server_path = vim.fn.expand '$MASON/packages' .. '/vue-language-server' .. '/node_modules/@vue/language-server'

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
                filetypes = {
                    "javascript",
                    "typescript",
                },
            })
            -- local vue_plugin = {
            --     name = '@vue/typescript-plugin',
            --     location = vue_language_server_path,
            --     languages = { 'vue' },
            --     configNamespace = 'typescript',
            -- }
            -- local vtsls_config = {
            --     settings = {
            --         vtsls = {
            --             tsserver = {
            --                 globalPlugins = {
            --                     vue_plugin,
            --                 },
            --             },
            --         },
            --     },
            --     filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
            -- }
            -- local vue_ls_config = {
            --     on_init = function(client)
            --         client.handlers['tsserver/request'] = function(_, result, context)
            --             local clients = vim.lsp.get_clients({ bufnr = context.bufnr, name = 'vtsls' })
            --             if #clients == 0 then
            --                 vim.notify('Could not find `vtsls` lsp client, `vue_ls` would not work without it.', vim.log.levels.ERROR)
            --                 return
            --             end
            --             local ts_client = clients[1]
            --
            --             local param = unpack(result)
            --             local id, command, payload = unpack(param)
            --             ts_client:exec_cmd({
            --                 title = 'vue_request_forward', -- You can give title anything as it's used to represent a command in the UI, `:h Client:exec_cmd`
            --                 command = 'typescript.tsserverRequest',
            --                 arguments = {
            --                     command,
            --                     payload,
            --                 },
            --             }, { bufnr = context.bufnr }, function(_, r)
            --                     local response_data = { { id, r.body } }
            --                     ---@diagnostic disable-next-line: param-type-mismatch
            --                     client:notify('tsserver/response', response_data)
            --                 end)
            --         end
            --     end,
            -- }
            -- vim.lsp.config('vtsls', vtsls_config)
            -- vim.lsp.config('vue_ls', vue_ls_config)
            vim.lsp.enable({'vtsls', 'vue_ls'})
            vim.lsp.enable('ts_ls')
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
