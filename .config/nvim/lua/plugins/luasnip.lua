return {
	"L3MON4D3/LuaSnip",
	version = "2.*",
	build = "make install_jsregexp",
	dependencies = {
		"rafamadriz/friendly-snippets",
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load()
		end,
	},
	opts = { history = true },
	config = function()
		require("luasnip.loaders.from_snipmate").lazy_load()
	end,
}
