require "nvchad.options"

-- add yours here!

local o = vim.o
o.cursorlineopt = "both" -- to enable cursorline!
o.relativenumber = true
o.number = true
-- o.colorcolumn = "150"
o.guicursor = "n-v-c-sm:block,i-ci-ve:block,r-cr-o:hor20"
o.swapfile = false
o.termguicolors = true -- True color support
o.timeoutlen = vim.g.vscode and 1000 or 300 -- Lower than default (1000) to quickly trigger which-key
o.undofile = true
o.undolevels = 10000
o.virtualedit = "block" -- Allow cursor to move where there is no text in visual block mode
o.wildmode = "longest:full,full" -- Command-line completion mode
o.wrap = false -- Disable line wrap
o.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
o.smartcase = true -- Don't ignore case with capitals
o.conceallevel = 2
