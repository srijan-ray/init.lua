return {
    {
        "mason-org/mason.nvim",
        cmd = { "Mason", "MasonInstall", "MasonUpdate", "MasonUninstall" },
        opts = {
            ui = { border = "none" },
        },
    },
    {
        "mason-org/mason-lspconfig.nvim",
        -- Load with the first real file rather than at startup; it only needs to
        -- run before a server would attach.
        event = { "BufReadPre", "BufNewFile" },
        dependencies = { "mason-org/mason.nvim" },
        opts = {
            ensure_installed = {
                -- Lua
                "lua_ls",
                -- Python
                "basedpyright",
                "ruff",
                -- Frontend / JS / TS
                "vtsls",
                "vue_ls",
                "astro",
                "tailwindcss",
                "html",
                "cssls",
                "jsonls",
                "eslint",                 -- JS/TS linting
                "emmet_language_server",  -- HTML/JSX/CSS expansion
                -- Systems languages
                "clangd",        -- C / C++
                "rust_analyzer", -- Rust
                "gopls",         -- Go
                -- Backend / AWS / IaC
                "yamlls",     -- YAML + CloudFormation/SAM/k8s/Actions (via SchemaStore)
                "terraformls", -- Terraform / HCL
                -- NOTE: Java (jdtls) is managed by nvim-java, so it is intentionally
                -- not listed here.
            },
        },
    },
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            {
                "folke/lazydev.nvim",
                ft = "lua", -- only load on lua files
                opts = {
                    library = {
                        -- Load luvit types when the `vim.uv` word is found
                        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                    },
                },
            },
            { "j-hui/fidget.nvim", opts = {} },
            "saghen/blink.cmp",
            "b0o/SchemaStore.nvim", -- JSON/YAML schemas (CloudFormation, Actions, k8s, package.json…)
        },
        config = function()
            -- Some UI edits
            vim.lsp.inlay_hint.enable()
            vim.diagnostic.config({
                virtual_lines = true,
                severity_sort = true,
                float = { border = "bold" },
                signs = {
                    text = {
                        [vim.diagnostic.severity.ERROR] = "",
                        [vim.diagnostic.severity.WARN] = "",
                        [vim.diagnostic.severity.HINT] = "󰛨",
                        [vim.diagnostic.severity.INFO] = "󰋼",
                    },
                    linehl = {
                        [vim.diagnostic.severity.ERROR] = "ErrorMsg",
                    },
                    numhl = {
                        [vim.diagnostic.severity.WARN] = "WarningMsg",
                    },
                },
            })

            -- Give every server blink.cmp's completion capabilities.
            vim.lsp.config("*", {
                capabilities = require("blink.cmp").get_lsp_capabilities(),
            })

            -- Lua
            vim.lsp.enable("lua_ls")

            -- Python (basedpyright for types, ruff for lint/format)
            vim.lsp.config("basedpyright", {
                settings = {
                    basedpyright = {
                        disableOrganizeImports = true,
                        analysis = {
                            typeCheckingMode = "basic",
                        },
                    },
                    python = {
                        analysis = {
                            -- Ignore all files for analysis to exclusively use Ruff for linting
                            ignore = { "*" },
                        },
                    },
                },
            })
            vim.lsp.enable("basedpyright")
            vim.lsp.enable("ruff")

            -- Frontend / JS / TS (settings live in after/lsp/*.lua)
            vim.lsp.enable("tailwindcss")
            vim.lsp.enable("vtsls")
            vim.lsp.enable("vue_ls")
            vim.lsp.enable("astro")
            vim.lsp.enable("html")
            vim.lsp.enable("cssls")
            vim.lsp.enable("emmet_language_server")
            vim.lsp.enable("eslint")

            -- JSON with SchemaStore catalogue (package.json, tsconfig, etc.)
            vim.lsp.config("jsonls", {
                settings = {
                    json = {
                        schemas = require("schemastore").json.schemas(),
                        validate = { enable = true },
                    },
                },
            })
            vim.lsp.enable("jsonls")

            -- YAML with SchemaStore (CloudFormation/SAM, GitHub Actions, k8s,
            -- docker-compose, …). Disable yamlls' built-in schema store so the
            -- richer SchemaStore catalogue is used instead.
            vim.lsp.config("yamlls", {
                settings = {
                    yaml = {
                        schemaStore = { enable = false, url = "" },
                        schemas = require("schemastore").yaml.schemas(),
                        keyOrdering = false,
                    },
                },
            })
            vim.lsp.enable("yamlls")

            -- Terraform / HCL
            vim.lsp.enable("terraformls")

            -- Systems languages
            vim.lsp.enable("clangd")
            vim.lsp.enable("gopls")
            vim.lsp.config("rust_analyzer", {
                settings = {
                    ["rust-analyzer"] = {
                        checkOnSave = { command = "clippy" },
                        cargo = { allFeatures = true },
                    },
                },
            })
            vim.lsp.enable("rust_analyzer")

            -- Global (non buffer-local) LSP pickers via fzf-lua
            local fzf = require("fzf-lua")
            vim.keymap.set("n", "<leader>ca", fzf.lsp_code_actions, { desc = "[C]ode [A]ctions" })
            vim.keymap.set("n", "<leader>gr", fzf.lsp_references, { desc = "[G]o to [R]eferences" })
            vim.keymap.set("n", "<leader>gd", fzf.lsp_definitions, { desc = "[G]o to [D]efinition" })
            vim.keymap.set("n", "<leader>gD", fzf.lsp_declarations, { desc = "[G]o to [D]eclaration" })
            vim.keymap.set("n", "<leader>gi", fzf.lsp_implementations, { desc = "[G]o to [I]mplementation" })
            vim.keymap.set("n", "<leader>gt", fzf.lsp_typedefs, { desc = "[G]o to [T]ype definition" })
            vim.keymap.set("n", "<leader>ds", fzf.lsp_document_symbols, { desc = "[D]ocument [S]ymbols" })
            vim.keymap.set("n", "<leader>ws", fzf.lsp_live_workspace_symbols, { desc = "[W]orkspace [S]ymbols" })
            vim.keymap.set("n", "<leader>wd", fzf.diagnostics_workspace, { desc = "[W]orkspace [D]iagnostics" })
            vim.keymap.set("n", "<leader>lse", vim.diagnostic.enable, { desc = "Enable diagnostics" })
            vim.keymap.set("n", "<leader>lsd", function()
                vim.diagnostic.enable(false)
            end, { desc = "Disable diagnostics" })

            -- Buffer-local keymaps set when a server attaches
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("srijan_lsp_attach", { clear = true }),
                callback = function(event)
                    local buf = event.buf
                    local function bmap(keys, fn, desc)
                        vim.keymap.set("n", keys, fn, { buffer = buf, desc = "LSP: " .. desc })
                    end

                    bmap("K", vim.lsp.buf.hover, "Hover documentation")
                    bmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame symbol")
                    bmap("[d", function()
                        vim.diagnostic.jump({ count = -1 })
                    end, "Previous diagnostic")
                    bmap("]d", function()
                        vim.diagnostic.jump({ count = 1 })
                    end, "Next diagnostic")
                    bmap("<leader>e", vim.diagnostic.open_float, "Show diagnostic (float)")

                    -- Toggle inlay hints for this buffer
                    local client = vim.lsp.get_client_by_id(event.data.client_id)
                    if client and client:supports_method("textDocument/inlayHint") then
                        bmap("<leader>th", function()
                            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = buf }), { bufnr = buf })
                        end, "[T]oggle inlay [H]ints")
                    end
                end,
            })
        end,
    },
}
