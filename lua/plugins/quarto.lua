return {

	-- { -- requires plugins in lua/plugins/treesitter.lua and lua/plugins/lsp.lua
	-- 	-- for complete functionality (language features)
	-- 	"quarto-dev/quarto-nvim",
	-- 	ft = { "quarto", "ipynb" },
	-- 	dev = false,
	-- 	opts = {},
	-- 	dependencies = {
	-- 		-- for language features in code cells
	-- 		-- configured in lua/plugins/lsp.lua and
	-- 		-- added as a nvim-cmp source in lua/plugins/completion.lua
	-- 		"jmbuhr/otter.nvim",
	-- 		opts = {},
	-- 	},
	-- },
	{
		"goerz/jupytext.nvim",
		opts = {
			format = "py:hydrogen",
		}, -- see Options
	},
	{
		"echasnovski/mini.hipatterns",
		event = "VeryLazy",
		dependencies = { "GCBallesteros/NotebookNavigator.nvim" },
		opts = function()
			local nn = require("notebook-navigator")

			local opts = { highlighters = { cells = nn.minihipatterns_spec } }
			return opts
		end,
	},
	{
		"echasnovski/mini.ai",
		event = "VeryLazy",
		dependencies = { "GCBallesteros/NotebookNavigator.nvim" },
		opts = function()
			local nn = require("notebook-navigator")

			local opts = { custom_textobjects = { h = nn.miniai_spec } }
			return opts
		end,
	},
	{
		"Vigemus/iron.nvim",
		config = function()
			local iron = require("iron.core")

			iron.setup({
				config = {
					-- Whether a repl should be discarded or not
					scratch_repl = true,
					-- Your repl definitions come here
					repl_definition = {
						sh = {
							-- Can be a table or a function that
							-- returns a table (see below)
							command = { "zsh" },
						},
						python = {
							command = { "python3" }, -- or { "ipython", "--no-autoindent" }
							format = require("iron.fts.common").bracketed_paste_python,
						},
					},
					-- How the repl window will be displayed
					-- See below for more information
					repl_open_cmd = require("iron.view").right(50),
				},
				-- Iron doesn't set keymaps by default anymore.
				-- You can set them here or manually add keymaps to the functions in iron.core
				keymaps = {
					send_motion = "<space>isc",
					visual_send = "<space>isc",
					send_file = "<space>isf",
					send_line = "<space>isl",
					send_paragraph = "<space>isp",
					send_until_cursor = "<space>isu",
					send_mark = "<space>ism",
					mark_motion = "<space>imc",
					mark_visual = "<space>imc",
					remove_mark = "<space>imd",
					cr = "<space>is<cr>",
					interrupt = "<space>is<space>",
					exit = "<space>isq",
					clear = "<space>icl",
				},
				-- If the highlight is on, you can change how it looks
				-- For the available options, check nvim_set_hl
				highlight = {
					italic = true,
				},
				ignore_blank_lines = true, -- ignore blank lines when sending visual select lines
			})

			-- iron also has a list of commands, see :h iron-commands for all available commands
			vim.keymap.set("n", "<space>rs", "<cmd>IronRepl<cr>")
			vim.keymap.set("n", "<space>rr", "<cmd>IronRestart<cr>")
			vim.keymap.set("n", "<space>rf", "<cmd>IronFocus<cr>")
			vim.keymap.set("n", "<space>rh", "<cmd>IronHide<cr>")
		end,
	},
}
