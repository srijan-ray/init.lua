return {
	{
		"OXY2DEV/markview.nvim",
		ft = { "markdown", "quarto", "rmd", "codecompanion" },
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
		opts = {
			preview = {
				modes = { "n", "i" }, -- If you are using it in insert mode
				hybrid_modes = { "i" },
			},
			experimental = {
				check_rtp = false,
			},
		},
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
		-- vimtex owns tex filetype detection & compilation, so load it lazily on
		-- the relevant filetypes rather than at startup.
		ft = { "tex", "plaintex", "bib" },
	},
	{
		"echasnovski/mini.align",
		version = false,
		keys = {
			{ "ga", mode = { "n", "v" }, desc = "Align" },
			{ "gA", mode = { "n", "v" }, desc = "Align with preview" },
		},
		opts = {},
	},
	{
		"HakonHarnes/img-clip.nvim",
		event = "VeryLazy",
		opts = {},
		keys = {
			{ "<leader>pi", "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard" },
		},
	},
}
