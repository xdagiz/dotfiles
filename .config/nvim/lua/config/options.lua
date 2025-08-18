vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local opt = vim.opt

-- Ui
vim.opt.number = true -- Absolute line numbers
vim.opt.relativenumber = true -- Relative line numbers
vim.opt.cursorline = true -- Highlight current line
vim.opt.cursorcolumn = false -- Highlight current column
vim.opt.termguicolors = true -- True colors
-- vim.opt.signcolumn = "yes" -- Always show gutter
-- vim.opt.colorcolumn = "80" -- Column guide
vim.opt.wrap = false -- Don't wrap lines
vim.opt.showmode = false -- Don't show -- INSERT --
vim.opt.showcmd = true -- Show partial commands
vim.opt.ruler = true -- Show cursor position
vim.opt.laststatus = 3 -- Global statusline
vim.opt.cmdheight = 1 -- Command line height
vim.opt.fillchars = { eob = " " } -- No ~ at end of buffer
vim.opt.scrolloff = 8 -- Keep cursor away from top/bottom
vim.opt.sidescrolloff = 8 -- Keep cursor away from sides
-- vim.opt.list = true -- Show invisible chars
-- vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.opt.splitbelow = true -- Horizontal splits below
vim.opt.splitright = true -- Vertical splits right
vim.opt.splitkeep = "screen" -- Keep text stable during splits
vim.opt.linebreak = true -- Break on whole words
vim.opt.breakindent = true -- Maintain indent when wrapping
opt.guicursor = "n-v-c-sm:block,i-ci-ve:block,r-cr-o:hor20"

-- Editing & Navigation
vim.opt.ignorecase = true -- Case-insensitive search
vim.opt.smartcase = true -- ... unless capital letters
vim.opt.hlsearch = true -- Highlight search matches
vim.opt.incsearch = true -- Show match while typing
vim.opt.inccommand = "split" -- Live preview of :s
vim.opt.iskeyword:append("-") -- Treat dash as part of word
vim.opt.whichwrap:append("<,>,[,],h,l") -- Allow wrap with arrow keys
vim.opt.backspace = { "indent", "eol", "start" }
vim.opt.joinspaces = false -- No double space after periods
vim.opt.mouse = "a" -- Enable mouse in all modes
vim.opt.virtualedit = "block" -- Allow cursor beyond end in visual block
vim.opt.startofline = false -- Keep cursor column when scrolling
vim.opt.shortmess:append("c") -- Less verbose messages
vim.opt.smoothscroll = true -- Smooth scrolling (0.11+)

-- Indentation & Tabs
vim.opt.tabstop = 2 -- Tab width
vim.opt.shiftwidth = 2 -- Indent width
vim.opt.softtabstop = 2 -- Tabs feel like spaces
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.autoindent = true -- Keep indent from prev line
vim.opt.smartindent = true -- Smart autoindenting
vim.opt.shiftround = true -- Round indent to multiple of shiftwidth

-- Performance & Responsiveness
vim.opt.updatetime = 200 -- Faster CursorHold events
vim.opt.timeoutlen = 400 -- Keymap timeout
vim.opt.ttimeoutlen = 50 -- Keycode timeout
vim.opt.redrawtime = 1500 -- Syntax redraw timeout
vim.opt.history = 10000 -- Command history
vim.opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize" }
vim.opt.hidden = true -- Allow background buffers
vim.opt.synmaxcol = 300 -- Stop syntax highlight after column 300

-- Files & Backup
vim.opt.undofile = true -- Persistent undo
vim.opt.undolevels = 10000 -- Huge undo history
vim.opt.backup = false -- No backup file
vim.opt.writebackup = false -- No write backup
vim.opt.swapfile = false -- No swap file
vim.opt.confirm = true -- Confirm before closing unsaved

-- Clipboard & Input
vim.opt.clipboard = "unnamedplus" -- Use system clipboard
vim.opt.paste = false -- Disable paste mode by default
vim.opt.keymodel:append("startsel") -- Shift+Arrow starts selection
vim.opt.wildmenu = true -- Command-line completion
vim.opt.wildmode = { "list", "longest" }
vim.opt.completeopt = { "menu", "menuone", "noselect" }

-- Search & Command Line
vim.opt.wildignore = { "*.swp", "*.bak", "*.tmp", "*.o", "*.obj", "*.exe", "*.dll" } -- Ignore these files in wildmenu
vim.opt.wildignorecase = true -- Ignore case in wildmenu
vim.opt.wildoptions = "pum" -- Use popup menu for wildmenu
vim.opt.showtabline = 2 -- Always show tabline
vim.opt.cmdwinheight = 5 -- Height of command window
vim.opt.scrolloff = 5 -- Lines to keep above/below cursor

-- UI Polishing
vim.opt.showtabline = 2 -- Always show tabline
vim.opt.tabline = "" -- Custom in statusline plugin
vim.opt.guifont = "FiraCode Nerd Font:h14"
vim.opt.title = true -- Show filename in titlebar
vim.opt.titlestring = "%F - NVIM"
vim.opt.matchpairs:append("<:>") -- Highlight <> pairs
vim.opt.cursorlineopt = "number" -- Highlight line number only
vim.opt.wildignore:append({ "node_modules", "*.pyc", "*.o", "*.obj", "*.dll" })
vim.opt.conceallevel = 2 -- Hide markdown formatting
vim.opt.spell = false -- Disable spellcheck
vim.opt.spelllang = { "en_us" } -- Spellcheck language

-- Advanced
vim.opt.modeline = true -- Allow modeline in files
vim.opt.modelines = 5
vim.opt.wrapscan = true -- Wrap searches around end
vim.opt.autoread = true -- Auto reload changed files
vim.opt.formatoptions:remove("o") -- Don't auto-comment on 'o'
vim.opt.formatoptions:append("r") -- Continue comments with Enter
vim.opt.errorbells = false -- No error sounds
vim.opt.visualbell = false -- No visual flash
vim.opt.belloff = "all" -- Disable bells
vim.opt.magic = true -- Enhanced regex
vim.opt.exrc = false -- Local config files
vim.opt.secure = true -- No unsafe commands in modelines
vim.opt.sessionoptions:append("globals") -- Save globals in sessions
vim.opt.signcolumn = "yes" -- Reserve space for 2 columns
