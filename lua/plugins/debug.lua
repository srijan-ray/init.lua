return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "nvim-neotest/nvim-nio",
        -- Inline variable values as virtual text while debugging
        { "theHamsta/nvim-dap-virtual-text", opts = {} },
        -- Auto-install debug adapters via mason
        {
            "jay-babu/mason-nvim-dap.nvim",
            dependencies = "mason-org/mason.nvim",
            opts = {
                automatic_installation = true,
                handlers = {},
                ensure_installed = {
                    "python",  -- debugpy
                    "codelldb", -- C / C++ / Rust
                },
            },
        },
        -- Python-specific DAP helper
        {
            "mfussenegger/nvim-dap-python",
            ft = "python",
            config = function()
                local mason_path = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python"
                require("dap-python").setup(mason_path)
            end,
        },
    },
    -- stylua: ignore
    keys = {
        { "<leader>dt", function() require("dap").toggle_breakpoint() end,                      desc = "Toggle Breakpoint" },
        { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input("Condition: ")) end, desc = "Conditional Breakpoint" },
        { "<leader>dc", function() require("dap").continue() end,                               desc = "Continue" },
        { "<leader>di", function() require("dap").step_into() end,                              desc = "Step Into" },
        { "<leader>do", function() require("dap").step_over() end,                              desc = "Step Over" },
        { "<leader>dO", function() require("dap").step_out() end,                               desc = "Step Out" },
        { "<leader>dr", function() require("dap").repl.toggle() end,                            desc = "Toggle REPL" },
        { "<leader>dl", function() require("dap").run_last() end,                               desc = "Run Last" },
        { "<leader>dx", function() require("dap").terminate() end,                              desc = "Terminate" },
        { "<leader>du", function() require("dapui").toggle() end,                               desc = "Toggle DAP UI" },
        { "<leader>de", function() require("dapui").eval() end,                                 desc = "Eval",                    mode = { "n", "v" } },
    },
    config = function()
        local dap = require("dap")
        local dapui = require("dapui")

        dapui.setup()

        dap.listeners.before.attach.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.launch.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated.dapui_config = function()
            dapui.close()
        end
        dap.listeners.before.event_exited.dapui_config = function()
            dapui.close()
        end

        -- Nicer breakpoint signs
        vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticError", linehl = "", numhl = "" })
        vim.fn.sign_define("DapStopped", { text = "", texthl = "DiagnosticWarn", linehl = "Visual", numhl = "" })
    end,
}
