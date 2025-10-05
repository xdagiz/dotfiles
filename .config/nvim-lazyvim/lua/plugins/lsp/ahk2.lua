local lspconfig = require("lspconfig")

lspconfig.ahk2 = lspconfig.ahk2 or {}

lspconfig.ahk2.setup({
  autostart = true,
  cmd = {
    "node",
    "~/.local/share/nvim-lazyvim/lsp_servers/ahk_lsp/server/dist/server.js",
    "--stdio",
  },
  filetypes = { "ahk", "autohotkey", "ah2" },
  init_options = {
    locale = "en-us",
  },
  single_file_support = true,
  flags = { debounce_text_changes = 500 },
})
