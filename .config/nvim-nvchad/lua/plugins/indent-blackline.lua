return {
  "lukas-reineke/indent-blankline.nvim",
  event = "BufReadPre",
  opts = function()
    local hooks = require "ibl.hooks"
    hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
      -- Set the highlight groups for indent lines
      vim.api.nvim_set_hl(0, "IndentBlanklineIndent1", { fg = "#808080" })
    end)

    return {
      indent = {
        char = "│",
        tab_char = "│",
      },
      scope = { show_end = true, highlight = { "IndentBlanklineIndent1" } },
      exclude = {
        filetypes = {
          "Trouble",
          "alpha",
          "help",
          "lazy",
          "mason",
          "NvimTree",
          "notify",
          "toggleterm",
          "trouble",
        },
      },
    }
  end,
  main = "ibl",
}
