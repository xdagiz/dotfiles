return {
	"L3MON4D3/LuaSnip",
	version = "2.*",
	dependencies = {
		"rafamadriz/friendly-snippets",
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load()
		end,
	},
	opts = { history = true },
	config = function()
		require("luasnip").filetype_extend("typescriptreact", { "typescriptreact" })

		require("luasnip").add_snippets("typescriptreact", require("snippets.typescriptreact"))
	end,
}
