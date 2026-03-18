vim.pack.add({
	{ src = "https://github.com/mrcjkb/rustaceanvim" },
})

vim.diagnostic.config({
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = " ",
			[vim.diagnostic.severity.WARN] = " ",
			[vim.diagnostic.severity.INFO] = " ",
			[vim.diagnostic.severity.HINT] = " ",
		},
		texthl = {
			[vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
			[vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
			[vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
			[vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
		},
		numhl = {},
	},
	virtual_text = false,
	jump = { float = true },
	underline = true,
	severity_sort = true,
})

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local buf = args.buf

		vim.lsp.inlay_hint.enable(true, { bufnr = buf })
		vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)
		vim.keymap.set("n", "gd", vim.lsp.buf.definition)
		vim.keymap.set("n", "K", vim.lsp.buf.hover)
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename)
		vim.keymap.set("n", "<leader>wd", vim.diagnostic.open_float)
		vim.keymap.set("n", "<leader>ss", vim.lsp.buf.workspace_symbol)
		vim.keymap.set("n", "<leader>cf", vim.lsp.buf.format)
	end,
})

vim.lsp.config("vtsls", {
	settings = {
		complete_function_calls = true,
		vtsls = {
			enableMoveToFileCodeAction = true,
			autoUseWorkspaceTsdk = true,
			experimental = {
				maxInlayHintLength = 30,
				completion = {
					enableServerSideFuzzyMatch = true,
				},
			},
		},
		typescript = {
			tsserver = {
				maxTsServerMemory = 1024,
			},
			updateImportsOnFileMove = { enabled = "always" },
			suggest = {
				completeFunctionCalls = true,
			},
			inlayHints = {
				enumMemberValues = { enabled = true },
				functionLikeReturnTypes = { enabled = true },
				parameterNames = { enabled = "literals" },
				parameterTypes = { enabled = true },
				propertyDeclarationTypes = { enabled = true },
				variableTypes = { enabled = false },
			},
		},
	},
})

vim.lsp.config("lua_ls", { settings = { Lua = { hint = true } } })
vim.lsp.config("gopls", {
	settings = {
		gopls = {
			gofumpt = true,
			codelenses = {
				gc_details = false,
				generate = true,
				regenerate_cgo = true,
				run_govulncheck = true,
				test = true,
				tidy = true,
				upgrade_dependency = true,
				vendor = true,
			},
			hints = {
				assignVariableTypes = true,
				compositeLiteralFields = true,
				compositeLiteralTypes = true,
				constantValues = true,
				functionTypeParameters = true,
				parameterNames = true,
				rangeVariableTypes = true,
			},
			analyses = {
				nilness = true,
				unusedparams = true,
				unusedwrite = true,
				useany = true,
			},
			maxMemory = 700,
			usePlaceholders = true,
			completeUnimported = true,
			staticcheck = true,
			directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
			semanticTokens = true,
		},
	},
})

vim.lsp.enable({
	-- "lua_ls",
	"gopls",
	"oxlint",
	"bacon_ls",
	-- "rust_analyzer",
	-- "tailwindcss",
	-- "tsgo",
	-- "vtsls",
	-- "zls",
})

vim.g.rustaceanvim = {
	server = {
		on_attach = function(_, bufnr)
			vim.keymap.set("n", "<leader>cR", function()
				vim.cmd.RustLsp("codeAction")
			end, { desc = "Code Action", buffer = bufnr })
			vim.keymap.set("n", "<leader>dr", function()
				vim.cmd.RustLsp("debuggables")
			end, { desc = "Rust Debuggables", buffer = bufnr })
		end,
		default_settings = {
			["rust-analyzer"] = {
				cargo = {
					allFeatures = false,
					loadOutDirsFromCheck = false,
					buildScripts = { enable = false },
					runBuildScripts = false,
				},
				checkOnSave = false,
				diagnostics = { enable = false },
				procMacro = { enable = false },
				files = {
					exclude = {
						".direnv",
						".git",
						".jj",
						".github",
						".gitlab",
						"bin",
						"node_modules",
						"target",
						"venv",
						".venv",
					},
					watcher = "client",
				},
				linkedProjects = {},
			},
		},
	},
}
