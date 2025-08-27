-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "catppuccin",
  transparency = true,
  theme_toggle = {
    "catppuccin",
    "rosepine",
  },

  -- hl_override = {
  -- 	Comment = { italic = true },
  -- 	["@comment"] = { italic = true },
  -- },
}

M.nvdash = {
  load_on_startup = true,
  header = {
    "██╗  ██╗██████╗  █████╗  ██████╗ ██╗███████╗",
    "╚██╗██╔╝██╔══██╗██╔══██╗██╔════╝ ██║╚══███╔╝",
    " ╚███╔╝ ██║  ██║███████║██║  ███╗██║  ███╔╝ ",
    " ██╔██╗ ██║  ██║██╔══██║██║   ██║██║ ███╔╝  ",
    "██╔╝ ██╗██████╔╝██║  ██║╚██████╔╝██║███████╗",
    "╚═╝  ╚═╝╚═════╝ ╚═╝  ╚═╝ ╚═════╝ ╚═╝╚══════╝",
    "                                            ",
  },
  buttons = {
    { txt = "  Find File", keys = "ff", cmd = "Telescope find_files" },
    { txt = "  Recent Files", keys = "fo", cmd = "Telescope oldfiles" },
    { txt = "󰒲  Lazy", icon = "󰒲", keys = "l", cmd = "Lazy" },
    { txt = "󰒳  Mason", icon = "󰒳", keys = "m", cmd = "Mason" },
    { txt = "󰒵  NvCheatsheet", icon = "󰒵", keys = "c", cmd = "NvCheatsheet" },
    { txt = "󰒱  Quit", icon = "󰒱", keys = "q", cmd = "qa" },
  },
}

M.ui = {
  tabufline = {
    lazyload = false,
  },
  statusline = {
    theme = "default",
    separator_style = "round",
  },
}

return M
