return {
	"stevearc/oil.nvim",
	opts = {
    delete_to_trash = true,
    skip_confirm_for_simple_edits = true,
		float = {
			padding = 4,
			max_width = 0.5,
			max_height = 0.5,
			override = function(conf)
				return conf
			end,
		},
	},
	dependencies = { { "echasnovski/mini.icons", opts = {} } },
	lazy = false,
	keys = {
		{ "<leader>e", "<cmd>Oil<cr>", desc = "Open Oil" },
		{ "<leader>o", "<cmd>Oil --float<cr>", desc = "Open Oil Float" },
	},
}
