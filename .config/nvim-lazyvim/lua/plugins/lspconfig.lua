return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      ts_ls = {
        enabled = false,
        settings = {
          typescript = {
            tsserver = {
              maxTsServerMemory = 500,
            },
            format = {
              enable = false,
            },
          },
        },
      },
      tsgo = { enabled = false, settings = {} },
      tailwindcss = { enabled = false },
      lua_ls = { enabled = false },
      gopls = { enabled = false },
      eslint = { enabled = false },
    },
  },
}
