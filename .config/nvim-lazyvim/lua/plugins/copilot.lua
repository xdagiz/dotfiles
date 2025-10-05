return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  build = ":Copilot auth",
  enabled = false,
  opts = {
    suggestion = {
      enabled = false,
      auto_trigger = false,
    },
  },
}
