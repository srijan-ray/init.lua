return {
	"mbbill/undotree",
	cmd = { "UndotreeToggle", "UndotreeShow", "UndotreeFocus" },
	keys = {
		{ "<leader>u", vim.cmd.UndotreeToggle, desc = "Toggle Undotree" },
	},
}
