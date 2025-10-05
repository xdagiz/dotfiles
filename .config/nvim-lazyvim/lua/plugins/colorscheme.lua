return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    ---@module 'catppuccin'
    ---@type CatppuccinOptions
    opts = {
      transparent_background = true,
      float = {
        solid = true,
        transparent = true,
      },
      flavour = "mocha",
      auto_integrations = true,
      integrations = {
        blink_cmp = true,
      },
    },
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    opts = {
      variant = "main",
      styles = {
        transparency = true,
        italic = false,
      },
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
