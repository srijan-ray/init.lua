return {
	{
		"goerz/jupytext.nvim",
		ft = { "python", "markdown", "quarto" },
		opts = {
			format = "py:hydrogen",
		},
	},
	-- Molten: execute code through real Jupyter kernels and show output (text AND
	-- plots) inline under the cell — the piece that replaces VSCode notebooks.
	-- Requires the Neovim python provider (`pynvim`) + `jupyter_client` + a kernel
	-- (`ipykernel`); run `:UpdateRemotePlugins` after install. See README prereqs.
	{
		"benlubas/molten-nvim",
		ft = { "python", "quarto", "markdown" },
		build = ":UpdateRemotePlugins",
		dependencies = { "3rd/image.nvim" },
		init = function()
			vim.g.molten_image_provider = "image.nvim"
			vim.g.molten_output_win_max_height = 20
			vim.g.molten_auto_open_output = false
			vim.g.molten_wrap_output = true
			vim.g.molten_virt_text_output = true
			vim.g.molten_virt_lines_off_by_1 = true
		end,
		-- stylua: ignore
		keys = {
			{ "<leader>mi", "<cmd>MoltenInit<cr>",              desc = "Molten: init kernel" },
			{ "<leader>me", "<cmd>MoltenEvaluateOperator<cr>",  desc = "Molten: evaluate operator" },
			{ "<leader>ml", "<cmd>MoltenEvaluateLine<cr>",      desc = "Molten: evaluate line" },
			{ "<leader>mc", "<cmd>MoltenReevaluateCell<cr>",    desc = "Molten: re-evaluate cell" },
			{ "<leader>mv", ":<C-u>MoltenEvaluateVisual<cr>gv", mode = "v", desc = "Molten: evaluate selection" },
			{ "<leader>mo", "<cmd>MoltenShowOutput<cr>",        desc = "Molten: show output" },
			{ "<leader>mh", "<cmd>MoltenHideOutput<cr>",        desc = "Molten: hide output" },
			{ "<leader>md", "<cmd>MoltenDelete<cr>",            desc = "Molten: delete cell" },
			{ "<leader>mx", "<cmd>MoltenInterrupt<cr>",         desc = "Molten: interrupt kernel" },
			{ "<leader>mb", "<cmd>MoltenOpenInBrowser<cr>",     desc = "Molten: open output in browser" },
		},
	},
	-- Inline images (plots) for molten and markdown. Needs an image-capable
	-- terminal (kitty / wezterm / ghostty) + ImageMagick — see README prereqs.
	{
		"3rd/image.nvim",
		ft = { "markdown", "quarto", "python" },
		opts = {
			backend = "kitty",
			processor = "magick_cli", -- uses the ImageMagick CLI (no luarock needed)
			integrations = {
				markdown = {
					enabled = true,
					only_render_image_at_cursor = true,
				},
			},
			max_width_window_percentage = 40,
		},
	},
	-- Quarto + otter: LSP, completion, and diagnostics INSIDE code cells, plus
	-- running cells through molten. Works for .qmd and fenced code in markdown.
	{
		"quarto-dev/quarto-nvim",
		ft = { "quarto", "markdown" },
		dependencies = {
			{ "jmbuhr/otter.nvim", opts = {} },
			"nvim-treesitter/nvim-treesitter",
		},
		opts = {
			lspFeatures = {
				enabled = true,
				languages = { "python", "bash", "lua", "html" },
			},
			codeRunner = {
				enabled = true,
				default_method = "molten",
			},
		},
	},
	-- Notebook cell navigation + running, wired to use molten as the runner.
	{
		"GCBallesteros/NotebookNavigator.nvim",
		opts = { repl_provider = "molten" },
		-- stylua: ignore
		keys = {
			-- Cell nav on ]/[ + n (gitsigns owns ]h/[h, so we avoid those)
			{ "]n", function() require("notebook-navigator").move_cell("d") end, desc = "Next notebook cell" },
			{ "[n", function() require("notebook-navigator").move_cell("u") end, desc = "Prev notebook cell" },
			{ "<leader>mj", function() require("notebook-navigator").run_and_move() end, desc = "Run cell & move" },
			{ "<leader>mJ", function() require("notebook-navigator").run_cell() end, desc = "Run cell" },
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
