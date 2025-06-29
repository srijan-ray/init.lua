return {
	{
		"OXY2DEV/markview.nvim",
		lazy = false,
		dependencies = {
			-- You may not need this if you don't lazy load
			-- Or if the parsers are in your $RUNTIMEPATH
			"nvim-treesitter/nvim-treesitter",

			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("markview").setup({
				preview = {
					modes = { "n", "i" }, -- If you are using it in insert mode
					hybrid_modes = { "i" },
				},
                experimental = {
                    check_rtp = false
                }
			})
		end,
	},
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = "cd app && npm install",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	},
	{
		"lervag/vimtex",
	},
	{ "echasnovski/mini.align", version = false, opts = {} },
	{
		"HakonHarnes/img-clip.nvim",
		event = "VeryLazy",
		opts = {},
		keys = {
			-- suggested keymap
			{ "<leader>pi", "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard" },
		},
	},
}
