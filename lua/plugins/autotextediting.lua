return {
	{
		"altermo/ultimate-autopair.nvim",
		event = { "InsertEnter", "CmdlineEnter" },
		branch = "v0.6", --recomended as each new version will have breaking changes
		opts = {
		},
	},
	{
		"windwp/nvim-ts-autotag",
		event = "InsertEnter",
		ft = { "html", "javascript", "javascriptreact", "typescriptreact", "svelte", "vue", "astro", "markdown" },
		autotag = {
			enable = true,
		},
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	},
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "InsertEnter",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			require("ibl").setup()
		end,
	},
	{
		"echasnovski/mini.bracketed",
		version = false,
		config = function()
			require("mini.bracketed").setup()
		end,
	},
}
