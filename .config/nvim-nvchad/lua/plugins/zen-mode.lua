return {
  "folke/zen-mode.nvim",
  event = "VeryLazy",
  opts = {
    window = {
      options = {
        signcolumn = "no", -- disable sign column
        cursorline = false, -- disable cursor line
        foldcolumn = "0", -- disable fold column
        list = false, -- disable whitespace characters
        wrap = true, -- enable line wrapping
        laststatus = 0,
      },
    },
  },
  config = function()
    require("zen-mode").setup {

      on_open = function()
        vim.cmd "!tmux set status off"
        vim.o.laststatus = 0
      end,

      on_close = function()
        vim.cmd "!tmux set status on"
        vim.o.laststatus = 3
      end,
    }
  end,
}
