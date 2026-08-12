return {
	{
		"goerz/jupytext.nvim",
		ft = { "python", "markdown", "quarto" },
		opts = {
			format = "py:hydrogen",
		},
	},
	{
		"echasnovski/mini.hipatterns",
		event = "VeryLazy",
		dependencies = { "GCBallesteros/NotebookNavigator.nvim" },
		opts = function()
			local nn = require("notebook-navigator")
			return { highlighters = { cells = nn.minihipatterns_spec } }
		end,
	},
	{
		"echasnovski/mini.ai",
		event = "VeryLazy",
		dependencies = { "GCBallesteros/NotebookNavigator.nvim" },
		opts = function()
			local nn = require("notebook-navigator")
			return { custom_textobjects = { h = nn.miniai_spec } }
		end,
	},
	{
		"Vigemus/iron.nvim",
		ft = { "python", "quarto", "markdown", "sh" },
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
				highlight = {
					italic = true,
				},
				ignore_blank_lines = true, -- ignore blank lines when sending visual select lines
			})

			-- iron also has a list of commands, see :h iron-commands for all available commands
			vim.keymap.set("n", "<space>rs", "<cmd>IronRepl<cr>", { desc = "Iron: open REPL" })
			vim.keymap.set("n", "<space>rr", "<cmd>IronRestart<cr>", { desc = "Iron: restart REPL" })
			vim.keymap.set("n", "<space>rf", "<cmd>IronFocus<cr>", { desc = "Iron: focus REPL" })
			vim.keymap.set("n", "<space>rh", "<cmd>IronHide<cr>", { desc = "Iron: hide REPL" })
		end,
	},
}
