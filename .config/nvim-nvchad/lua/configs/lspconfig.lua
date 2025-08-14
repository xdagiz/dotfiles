require("nvchad.configs.lspconfig").defaults()

local servers = {
  html = {},
  -- awk_ls = {},
  bashls = {},

  -- pyright = {
  --   settings = {
  --     python = {
  --       analysis = {
  --         autoSearchPaths = true,
  --         typeCheckingMode = "basic",
  --       },
  --     },
  --   },
  -- },
  cssls = {},
  -- ts_ls = { cmd = { "tsserver", "--stdio", "--tsserver-max-memory", "512" } },
  -- ts_ls = {},

  -- tsgo = {},
  tsgo = {
    cmd = { "tsgo", "--lsp", "--stdio", "--tsgo-max-memory", "512" },
  },
}

for name, opts in pairs(servers) do
  vim.lsp.enable(name) -- nvim v0.11.0 or above required
  vim.lsp.config(name, opts) -- nvim v0.11.0 or above required
end

-- vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers
