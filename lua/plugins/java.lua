-- nvim-java now VENDORS java-core / java-dap / java-test / async internally, so
-- the old standalone sub-plugins (nvim-java-core, nvim-java-dap, …) must NOT be
-- listed as dependencies — a stale pinned copy shadows the bundled one and breaks
-- with errors like "attempt to call field 'get_arch' (a nil value)".
--
-- Its setup() registers jdtls via `vim.lsp.config('jdtls', …)` but does NOT call
-- `vim.lsp.enable('jdtls')`, so we enable it ourselves right after setup. setup()
-- MUST run before jdtls is enabled, which is why this lives here (loaded on the
-- `java` filetype) rather than in lsp-tooling.lua.
return {
    "nvim-java/nvim-java",
    ft = "java",
    dependencies = {
        "MunifTanjim/nui.nvim",
        "neovim/nvim-lspconfig",
        "mfussenegger/nvim-dap",
        "saghen/blink.cmp",
        {
            "mason-org/mason.nvim",
            opts = {
                registries = {
                    "github:nvim-java/mason-registry",
                    "github:mason-org/mason-registry",
                },
            },
        },
    },
    config = function()
        require("java").setup({
            -- Spring Boot tooling needs the separate spring-boot.nvim plugin; leave
            -- it off so plain Java projects don't pull in an extra language server.
            spring_boot_tools = { enable = false },
        })

        -- Give jdtls blink.cmp capabilities, then start it.
        vim.lsp.config("jdtls", {
            capabilities = require("blink.cmp").get_lsp_capabilities(),
        })
        vim.lsp.enable("jdtls")

        -- Java run / test / debug keymaps (buffer-local to java files).
        -- NOTE: <leader>j here shadows the global loclist-prev in java buffers;
        -- use mini.bracketed's [l / ]l for the location list instead.
        vim.api.nvim_create_autocmd("FileType", {
            group = vim.api.nvim_create_augroup("srijan_java_keys", { clear = true }),
            pattern = "java",
            callback = function(event)
                local java = require("java")
                local function jmap(keys, fn, desc)
                    vim.keymap.set("n", keys, fn, { buffer = event.buf, desc = "Java: " .. desc })
                end
                jmap("<leader>jr", java.runner.built_in.run_app, "Run main app")
                jmap("<leader>js", java.runner.built_in.stop_app, "Stop running app")
                jmap("<leader>jl", java.runner.built_in.toggle_logs, "Toggle run logs")
                jmap("<leader>jt", java.test.run_current_class, "Test current class")
                jmap("<leader>jT", java.test.run_current_method, "Test current method")
                jmap("<leader>jd", java.test.debug_current_class, "Debug test class")
                jmap("<leader>jD", java.test.debug_current_method, "Debug test method")
                jmap("<leader>jv", java.test.view_last_report, "View last test report")
            end,
        })
    end,
}
