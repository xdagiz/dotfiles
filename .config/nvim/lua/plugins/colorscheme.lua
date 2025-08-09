return {
	{
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
				auto_integrations = true,
			})
			vim.cmd("colorscheme catppuccin")
		end,
	},
	{
		"rose-pine/neovim",
		name = "rose-pine",
		priority = 2000,
		config = function()
			require("rose-pine").setup({
				styles = {
					transparency = true,
				},
			})
			-- vim.cmd("colorscheme rose-pine")
		end,
	},
}
