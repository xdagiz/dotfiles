vim.pack.add({
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "master" },
	{ src = "https://github.com/nvim-telescope/telescope.nvim" },
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/L3MON4D3/LuaSnip" },
	{ src = "https://github.com/saghen/blink.cmp" },
	{ src = "https://github.com/stevearc/conform.nvim" },
	{ src = "https://github.com/nvim-mini/mini.ai" },
	{ src = "https://github.com/rafamadriz/friendly-snippets" },
})

require("nvim-treesitter").setup()

require("nvim-treesitter.configs").setup({
	modules = {},
	indent = { enabled = true },
	folds = { enabled = true },
	sync_install = false,
	auto_install = true,
	ignore_install = {},
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
	ensure_installed = {},
})

require("luasnip").filetype_extend("javascriptreact", { "html" })
require("luasnip").filetype_extend("typescriptreact", { "html" })
require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/snippets/" })
require("luasnip").setup({ enable_autosnippets = true })

local ai = require("mini.ai")
require("mini.ai").setup({
	n_lines = 500,
	custom_textobjects = {
		o = ai.gen_spec.treesitter({ -- code block
			a = { "@block.outer", "@conditional.outer", "@loop.outer" },
			i = { "@block.inner", "@conditional.inner", "@loop.inner" },
		}),
		f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }), -- function
		c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }), -- class
		t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" }, -- tags
		d = { "%f[%d]%d+" }, -- digits
		e = { -- Word with case
			{ "%u[%l%d]+%f[^%l%d]", "%f[%S][%l%d]+%f[^%l%d]", "%f[%P][%l%d]+%f[^%l%d]", "^[%l%d]+%f[^%l%d]" },
			"^().*()$",
		},
		u = ai.gen_spec.function_call(), -- u for "Usage"
		U = ai.gen_spec.function_call({ name_pattern = "[%w_]" }), -- without dot in function name
	},
})

local telescope = require("telescope")
local actions = require("telescope.actions")
local builtin = require("telescope.builtin")

local find_files_no_ignore = function()
	local action_state = require("telescope.actions.state")

	local line = action_state.get_current_line()
	builtin.find_files({
		no_ignore = true,
		default_text = line,
	})
end

local find_files_with_hidden = function()
	local action_state = require("telescope.actions.state")

	local line = action_state.get_current_line()
	builtin.find_files({
		hidden = true,
		default_text = line,
	})
end

telescope.setup({
	defaults = {
		prompt_prefix = " ",
		selection_caret = " ",
		preview = { treesitter = true },
		color_devicons = true,
		sorting_strategy = "ascending",
		path_displays = { "smart" },
		layout_config = {
			-- height = 30,
			-- width = 100,
			prompt_position = "top",
			preview_cutoff = 40,
		},
		mappings = {
			i = {
				["<a-i>"] = find_files_no_ignore,
				["<a-h>"] = find_files_with_hidden,
				["<C-Down>"] = actions.cycle_history_next,
				["<C-Up>"] = actions.cycle_history_prev,
				["<C-f>"] = actions.preview_scrolling_down,
				["<C-b>"] = actions.preview_scrolling_up,
			},
			n = {
				["q"] = actions.close,
			},
		},
		pickers = {
			find_files = {
				find_command = { "rg", "--files", "--color", "never", "-g", "!.git" },
				hidden = true,
				theme = "dropdown",
			},
		},
	},
})

local map = vim.keymap.set
map({ "n" }, "<leader>ff", builtin.find_files, { desc = "Telescope live grep" })
map({ "n" }, "<leader>sg", builtin.live_grep)
map({ "n" }, "<leader>/", builtin.live_grep)
map({ "n" }, "<leader>fb", builtin.buffers)
map({ "n" }, "<leader>fg", "<cmd>Telescope git_files<cr>")
map({ "n", "v" }, "<leader>sw", builtin.grep_string)
map({ "n" }, "<leader>so", builtin.oldfiles)
map({ "n" }, "<leader>sh", builtin.help_tags)
map({ "n" }, "<leader>gr", builtin.lsp_references)
map({ "n" }, "<leader>sd", builtin.diagnostics)
map({ "n" }, "<leader>sT", builtin.lsp_type_definitions)
map({ "n" }, "<leader>sc", builtin.git_bcommits)
map({ "n" }, "<leader>sk", builtin.keymaps)
map({ "n" }, "<esc>", "<cmd>nohlsearch<cr>", { noremap = true })
map({ "n" }, "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", { desc = "Toggle Pin" })
map({ "n" }, "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", { desc = "Delete Non-Pinned Buffers" })
map({ "n" }, "<leader>br", "<Cmd>BufferLineCloseRight<CR>", { desc = "Delete Buffers to the Right" })
map({ "n" }, "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", { desc = "Delete Buffers to the Left" })
map({ "n" }, "<S-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev Buffer" })
map({ "n" }, "<S-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next Buffer" })
map({ "n" }, "[b", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev Buffer" })
map({ "n" }, "]b", "<cmd>BufferLineCycleNext<cr>", { desc = "Next Buffer" })
map({ "n" }, "[B", "<cmd>BufferLineMovePrev<cr>", { desc = "Move buffer prev" })
map({ "n" }, "]B", "<cmd>BufferLineMoveNext<cr>", { desc = "Move buffer next" })
map({ "n", "x" }, "<leader>sr", "<cmd>GrugFar<cr>")
map({ "n" }, "<leader>,", "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>")
map({ "n" }, "<leader>:", "<cmd>Telescope command_history<cr>")
map({ "n" }, "<leader>fb", "<cmd>Telescope buffers sort_mru=true sort_lastused=true ignore_current_buffer=true<cr>")
map({ "n" }, "<leader>gc", "<cmd>Telescope git_commits<CR>")
map({ "n" }, "<leader>gl", "<cmd>Telescope git_commits<CR>")
map({ "n" }, "<leader>gs", "<cmd>Telescope git_status<CR>")
map({ "n" }, "<leader>gS", "<cmd>Telescope git_stash<cr>")
map({ "n" }, "<leader>sr", "<cmd>Telescope registers<cr>", { desc = "Registers" })
map({ "n" }, "<leader>sa", "<cmd>Telescope autocommands<cr>", { desc = "Auto Commands" })
map({ "n" }, "<leader>sH", "<cmd>Telescope highlights<cr>", { desc = "Search Highlight Groups" })
map({ "n" }, "<leader>sj", "<cmd>Telescope jumplist<cr>", { desc = "Jumplist" })
map({ "n" }, "<leader>sl", "<cmd>Telescope loclist<cr>", { desc = "Location List" })
map({ "n" }, "<leader>sM", "<cmd>Telescope man_pages<cr>", { desc = "Man Pages" })
map({ "n" }, "<leader>sm", "<cmd>Telescope marks<cr>", { desc = "Jump to Mark" })
map({ "n" }, "<leader>sR", "<cmd>Telescope resume<cr>", { desc = "Resume" })
map({ "n" }, "<leader>sQ", "<cmd>Telescope quickfix<cr>", { desc = "Quickfix List" })

require("blink.cmp").setup({
	snippets = {
		preset = "default",
	},
	appearance = {
		use_nvim_cmp_as_default = false,
		nerd_font_variant = "mono",
	},
	completion = {
		accept = {
			auto_brackets = {
				enabled = true,
			},
		},
		menu = {
			draw = { treesitter = { "lsp" } },
			auto_show = true,
			border = "rounded",
			winhighlight = "Normal:None",
			max_height = 20,
			min_width = 16,
		},
		documentation = {
			auto_show = true,
			auto_show_delay_ms = 200,
		},
	},
	sources = {
		per_filetype = {
			lua = { inherit_defaults = true, "lazydev" },
		},
		providers = {
			lazydev = {
				name = "LazyDev",
				module = "lazydev.integrations.blink",
				score_offset = 100,
			},
		},
		default = { "lsp", "path", "snippets", "buffer" },
	},
	fuzzy = {
		implementation = "lua",
	},
	cmdline = {
		enabled = true,
		keymap = {
			preset = "cmdline",
			["<Right>"] = false,
			["<Left>"] = false,
		},
		completion = {
			list = { selection = { preselect = false } },
			menu = {
				auto_show = function(_)
					return vim.fn.getcmdtype() == ":"
				end,
			},
			ghost_text = { enabled = true },
		},
	},
	keymap = {
		preset = "super-tab",
		["<C-y>"] = { "select_and_accept" },
	},
})

require("conform").setup({
	format_on_save = {
		timeout_ms = 500,
		lsp_fallback = true,
	},
	default_format_opts = { stop_after_first = true, timeout_ms = 1000 },
	formatters_by_ft = {
		lua = { "stylua" },
		javascript = { "oxfmt" },
		typescript = { "oxfmt" },
		javascriptreact = { "oxfmt" },
		typescriptreact = { "oxfmt" },
		-- markdown = { "prettier" },
		go = { "goimports", "gofumpt" },
	},
})

require("oil").setup({
	lsp_file_methods = {
		enabled = true,
		timeout_ms = 1000,
		autosave_changes = true,
	},
	columns = {
		"icon",
	},
	float = {
		max_width = 0.4,
		max_height = 0.6,
		border = "rounded",
	},
})
