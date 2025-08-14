return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			flavour = "mocha",
			transparent_background = true,
			float = {
				transparent = true,
				solid = false,
			},
			term_colors = true,
			styles = {
				comments = { "italic" },
				functions = { "bold" },
				conditionals = { "italic" },
				loops = { "italic" },
			},
			auto_integrations = true,
		})
		vim.cmd("colorscheme catppuccin")
	end,
}
