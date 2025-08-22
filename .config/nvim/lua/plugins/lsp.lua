return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"mason-org/mason.nvim",
			{ "mason-org/mason-lspconfig.nvim", config = function() end },
		},
		opts = function()
			---@class PluginLspOpts
			local ret = {
				---@type vim.diagnostic.Opts

				underline = { severity = vim.diagnostic.severity.ERROR },
				update_in_insert = false,
				severity_sort = true,
				virtual_text = {
					spacing = 2,
					source = "if_many",
					prefix = "●",
				},
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = "󰅚 ",
						[vim.diagnostic.severity.WARN] = "󰀪 ",
						[vim.diagnostic.severity.INFO] = "󰋽 ",
						[vim.diagnostic.severity.HINT] = "󰌶 ",
					},
				},

				inlay_hints = { enabled = true },

				codelens = { enabled = false },

				capabilities = {
					workspace = {
						fileOperations = {
							didRename = true,
							willRename = true,
						},
					},
				},
				-- options for vim.lsp.buf.format
				-- `bufnr` and `filter` is handled by the LazyVim formatter,
				-- but can be also overridden when specified
				format = {
					formatting_options = nil,
					timeout_ms = nil,
				},

				-- LSP Server Settings
				---@type lspconfig.options
				servers = {
					lua_ls = {
						-- mason = false, -- set to false if you don't want this server to be installed with mason
						-- Use this to add any additional keymaps
						-- for specific lsp servers
						-- ---@type LazyKeysSpec[]
						-- keys = {},
						settings = {
							Lua = {
								workspace = {
									checkThirdParty = false,
								},
								codeLens = {
									enable = true,
								},
								completion = {
									callSnippet = "Replace",
								},
								doc = {
									privateName = { "^_" },
								},
								hint = {
									enable = true,
									setType = false,
									paramType = true,
									paramName = "Disable",
									semicolon = "Disable",
									arrayIndex = "Disable",
								},
							},
						},
					},
					tsgo = { mason = false },
				},
				-- you can do any additional lsp server setup here
				-- return true if you don't want this server to be setup with lspconfig
				---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
				setup = {
					-- example to setup with typescript.nvim
					-- tsserver = function(_, opts)
					--   require("typescript").setup({ server = opts })
					--   return true
					-- end,
					-- Specify * to use this function as a fallback for any server
					-- ["*"] = function(server, opts) end,
				},
			}
			return ret
		end,
	},
	config = function(_, opts)
			vim.api.nvim_create_autocmd("LspAttach", {
      callback = function ()
        
      end
    },

		-- diagnostics
		vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

		-- capabilities
		local capabilities = require("blink.cmp").get_lsp_capabilities()
	end,
}
