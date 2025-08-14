local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    css = { "prettier" },
    html = { "prettier" },
    javascript = { "prettier", "prettierd", stop_after_first = true },
    typescript = { "prettier", "prettierd", stop_after_first = true },
    tsx = { "prettier" },
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 4000,
    lsp_fallback = true,
    lsp_format = "fallback",
  },
  -- Change format keymap
  keymap = {
    format = "<leader>cf", -- Format the current buffer
    format_all = "<leader>cF", -- Format all buffers
  },
}

return options
