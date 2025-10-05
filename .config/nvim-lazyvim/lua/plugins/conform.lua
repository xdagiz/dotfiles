return {
  "stevearc/conform.nvim",
  event = "VeryLazy",
  ---@type conform.setupOpts
  opts = {
    default_format_opts = { stop_after_first = true, timeout_ms = 4000 },
    formatters_by_ft = {
      javascript = { "biome", "prettier", "prettierd" },
      typescript = { "biome", "prettier", "prettierd" },
      javascriptreact = { "biome", "prettier" },
      typescriptreact = { "biome", "prettier" },
      go = { "goimports", "gofumpt" },
    },
  },
}
