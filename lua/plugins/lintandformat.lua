return {
    { -- Autoformat
        "stevearc/conform.nvim",
        event = { "BufWritePre" },
        cmd = { "ConformInfo" },
        opts = {
            notify_on_error = false,
            format_on_save = function(bufnr)
                -- Let clangd/other LSPs own formatting for these; conform still
                -- runs its explicit formatters below when defined.
                local disable_filetypes = { c = true, cpp = true }
                local lsp_format_opt
                if disable_filetypes[vim.bo[bufnr].filetype] then
                    lsp_format_opt = "never"
                else
                    lsp_format_opt = "fallback"
                end
                return {
                    timeout_ms = 500,
                    lsp_format = lsp_format_opt,
                }
            end,
            formatters_by_ft = {
                lua = { "stylua" },
                python = { "ruff_format", "ruff_organize_imports" },
                java = { "astyle" },
                latex = { "latexindent" },
                go = { "gofumpt", "goimports-reviser", "golines" },
                markdown = { "prettierd", "prettier", stop_after_first = true },
                rust = { "rustfmt" },
                c = { "clang-format" },
                cpp = { "clang-format" },
                sh = { "shfmt" },
                -- Web: use whichever formatter is available first
                javascript = { "prettierd", "prettier", stop_after_first = true },
                javascriptreact = { "prettierd", "prettier", stop_after_first = true },
                typescript = { "prettierd", "prettier", stop_after_first = true },
                typescriptreact = { "prettierd", "prettier", stop_after_first = true },
                vue = { "prettierd", "prettier", stop_after_first = true },
                astro = { "prettierd", "prettier", stop_after_first = true },
                css = { "prettierd", "prettier", stop_after_first = true },
                scss = { "prettierd", "prettier", stop_after_first = true },
                html = { "prettierd", "prettier", stop_after_first = true },
                json = { "prettierd", "prettier", stop_after_first = true },
                jsonc = { "prettierd", "prettier", stop_after_first = true },
                yaml = { "prettierd", "prettier", stop_after_first = true },
            },
        },
    },
    { -- Linting
        "mfussenegger/nvim-lint",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            local lint = require("lint")
            -- Python linting is handled by the ruff LSP; Rust/C/C++/Go/TS by
            -- their language servers. These cover the gaps.
            lint.linters_by_ft = {
                java = { "checkstyle" },
            }

            -- Run the configured linters on the given events.
            local lint_augroup = vim.api.nvim_create_augroup("srijan_lint", { clear = true })
            vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
                group = lint_augroup,
                callback = function()
                    -- Only run on real, modifiable file buffers.
                    if not (vim.bo.modifiable and vim.bo.buftype == "") then
                        return
                    end
                    -- Only run linters whose executable is actually installed, so a
                    -- missing tool (e.g. checkstyle) doesn't spam ENOENT errors.
                    local names = lint.linters_by_ft[vim.bo.filetype] or {}
                    local runnable = {}
                    for _, name in ipairs(names) do
                        local linter = lint.linters[name]
                        local cmd = type(linter) == "table" and linter.cmd or nil
                        if type(cmd) == "function" then
                            cmd = cmd()
                        end
                        if cmd and vim.fn.executable(cmd) == 1 then
                            table.insert(runnable, name)
                        end
                    end
                    if #runnable > 0 then
                        lint.try_lint(runnable)
                    end
                end,
            })
        end,
    },
}
