return {
	"windwp/nvim-ts-autotag",
	event = "VeryLazy",
	enabled = false,
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-treesitter/nvim-treesitter-textobjects",
	},
	ft = { "html", "javascriptreact", "typescriptreact", "tsx" },
	opts = {},
}
