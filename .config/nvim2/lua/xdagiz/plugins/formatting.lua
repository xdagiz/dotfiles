return {
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		opts = {
			notify_on_error = false,
			formatters_by_ft = {
				lua = { "stylua" },
				javascript = { "prettierd", "prettier", "eslint_d" },
				javascriptreact = { "prettierd", "prettier", "eslint_d" },
				typescript = { "prettierd", "prettier", "eslint_d" },
				typescriptreact = { "prettierd", "prettier", "eslint_d" },
				css = { "prettierd", "prettier" },
				json = { "jq", "prettierd", "prettier" },
				rust = { "rustfmt" },
			},
			format_on_save = function(bufnr)
				local disable_ft = { "sql" }
				if vim.tbl_contains(disable_ft, vim.bo[bufnr].filetype) then
					return
				end
				return { timeout_ms = 5000, lsp_fallback = true }
			end,
		},
	},
}
