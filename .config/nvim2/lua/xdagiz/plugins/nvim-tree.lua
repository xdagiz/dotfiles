return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	lazy = false, -- Load on startup (or you can use event = "BufAdd" if you prefer lazy)
	dependencies = {
		"nvim-tree/nvim-web-devicons", -- required for file icons
	},
	config = function()
		require("nvim-tree").setup({
			disable_netrw = true,
			update_focused_file = {
				enable = true,
				update_root = true,
			},
			renderer = {
				group_empty = true,
				highlight_git = true,
				icons = {
					glyphs = {
						default = "",
						folder = {
							arrow_open = "",
							arrow_closed = "",
							default = "",
							open = "",
							empty = "",
							empty_open = "",
						},
						git = {
							unstaged = "✗",
							staged = "✓",
							unmerged = "",
							renamed = "➜",
							untracked = "",
							deleted = "",
							ignored = "",
						},
					},
				},
			},
			actions = {
				open_file = {
					quit_on_open = true,
				},
			},
			view = {
				width = 30,
				preserve_window_proportions = true,
				number = true,
				relativenumber = true,
				signcolumn = "yes",
				adaptive_size = false,
				side = "left",
				float = {
					enable = false,
					quit_on_focus_loss = true,
					open_win_config = {
						relative = "editor",
						border = "rounded",
						width = 60,
						height = 30,
						row = nil,
						col = nil,
					},
				},
			},
		})

		-- Keymaps for nvim-tree
		local map = vim.api.nvim_set_keymap
		local opts = { noremap = true, silent = true }
		map("n", "<leader>nf", ":NvimTreeToggle<CR>", opts) -- Toggle NvimTree
		map("n", "<leader>nt", ":NvimTreeFindFile<CR>", opts) -- Find current file in NvimTree
		map("n", "<leader>np", ":NvimTreeFocus<CR>", opts) -- Focus NvimTree window
	end,
}
