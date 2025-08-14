return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	opts = {
		indent = { char = "│" }, -- VS Code–style line
		scope = { enabled = true, show_start = false, show_end = false }, -- Disable scope highlighting if you don't want it
	},
	config = function()
		local hooks = require("ibl.hooks")
		hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
			vim.api.nvim_set_hl(0, "IblScope", { fg = "#aaaaaa", nocombine = true })
		end)
	end,
}
