require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

-- map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- Normal mode: move line down/up
map("n", "<M-j>", ":m .+1<CR>==", { noremap = true, silent = true })
map("n", "<M-k>", ":m .-2<CR>==", { noremap = true, silent = true })

-- Visual mode: move selection down/up
map("v", "<M-j>", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
map("v", "<M-k>", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })

map("n", "<C-c>", "<ESC>", { desc = "general copy whole file" })

map("n", "<leader>bn", "<cmd>enew<CR>", { desc = "buffer new" })
map("n", "L", function()
  require("nvchad.tabufline").next()
end, { desc = "buffer goto next" })

map("n", "H", function()
  require("nvchad.tabufline").prev()
end, { desc = "buffer goto prev" })

map("n", "<leader>bd", function()
  require("nvchad.tabufline").close_buffer()
end, { desc = "buffer close" })

map("n", "<leader>ba", function()
  require("nvchad.tabufline").closeAllBufs(true)
end, { desc = "buffer close all" })

map("n", "<C-q>", "<C-v>")
map("n", "<leader>l", "<cmd>Lazy<cr>")
map("n", "<leader>cm", "<cmd>Mason<cr>")
vim.api.nvim_del_keymap("n", "<leader>x")
vim.api.nvim_del_keymap("n", "<Tab>")
vim.api.nvim_del_keymap("n", "<S-Tab>")
