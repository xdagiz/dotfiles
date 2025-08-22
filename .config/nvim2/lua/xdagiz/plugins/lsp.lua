return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"mason-org/mason.nvim",
			{ "mason-org/mason-lspconfig.nvim", config = function() end },
		},
		opts = function()
			---@class LspConfigOpts
			local ret = {
				---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
				setup = {},
				capabilities = vim.lsp.protocol.make_client_capabilities(),
			}

			return ret
		end,
		---@param opts LspConfigOpts
		config = function(opts)
			local map = vim.keymap.set

			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function()
					map("n", "gd", vim.lsp.buf.definition)
				end,
			})

			-- capabilities
			opts.capabilities = require("blink.cmp").get_lsp_capabilities({
				textDocument = {
					completion = {
						completionItem = {
							documentationFormat = { "markdown", "plaintext" },
							snippetSupport = true,
						},
					},
				},
			})

			-- setup
			require("lspconfig").setup(opts)
		end,
	},
}
