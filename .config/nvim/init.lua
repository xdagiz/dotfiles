require("xdagiz.keymaps")
require("xdagiz.options")
require("xdagiz.autocmds")

vim.pack.add({
  { src = "https://github.com/stevearc/oil.nvim" },
  { src = "https://github.com/nvim-tree/nvim-web-devicons" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter",       version = "master" },
  { src = "https://github.com/nvim-telescope/telescope.nvim" },
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  { src = "https://github.com/L3MON4D3/LuaSnip" },
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/mason-org/mason.nvim" },
  { src = "https://github.com/catppuccin/nvim",                       name = "catppuccin" },
  { src = "https://github.com/folke/lazydev.nvim" },
  { src = "https://github.com/saghen/blink.cmp" },
  { src = "https://github.com/stevearc/conform.nvim" },
  { src = "https://github.com/nvim-lualine/lualine.nvim" },
  { src = "https://github.com/folke/noice.nvim" },
  { src = "https://github.com/rachartier/tiny-inline-diagnostic.nvim" },
  { src = "https://github.com/akinsho/nvim-bufferline.lua" },
  { src = "https://github.com/nvim-tree/nvim-web-devicons" },
  { src = "https://github.com/MunifTanjim/nui.nvim" },
  { src = "https://github.com/lewis6991/gitsigns.nvim" },
  { src = "https://github.com/MagicDuck/grug-far.nvim" },
  { src = "https://github.com/mrcjkb/rustaceanvim" },
  { src = "https://github.com/lukas-reineke/indent-blankline.nvim" }
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

vim.keymap.set("n", "<leader>uw", function()
  vim.wo.wrap = not vim.wo.wrap
end, { desc = "Toggle wrap" })

require("mason").setup()
vim.keymap.set("n", "<leader>cm", "<Cmd>Mason<CR>")

require("ibl").setup({
  indent = { char = "▏" },
  scope = {
    show_start = false,
    show_end = false,
  },
})

vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.INFO] = " ",
      [vim.diagnostic.severity.HINT] = " ",
    },
    texthl = {
      [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
      [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
      [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
      [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
    },
    numhl = {},
  },
  virtual_text = true,
  underline = true,
  severity_sort = true,
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local buf = args.buf

    vim.lsp.inlay_hint.enable(true, { bufnr = buf })
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = buf })
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = buf })
    vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = buf })
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = buf })
    vim.keymap.set("n", "<leader>wd", vim.diagnostic.open_float, { buffer = buf })
    vim.keymap.set("n", "<leader>ss", vim.lsp.buf.workspace_symbol, { buffer = buf })
    vim.keymap.set("n", "<leader>cf", vim.lsp.buf.format, { buffer = buf })
  end,
})

vim.lsp.config("vtsls", {
  settings = {
    complete_function_calls = true,
    vtsls = {
      enableMoveToFileCodeAction = true,
      autoUseWorkspaceTsdk = true,
      experimental = {
        maxInlayHintLength = 30,
        completion = {
          enableServerSideFuzzyMatch = true,
        },
      },
    },
    typescript = {
      tsserver = {
        maxTsServerMemory = 500,
      },
      updateImportsOnFileMove = { enabled = "always" },
      suggest = {
        completeFunctionCalls = true,
      },
      inlayHints = {
        enumMemberValues = { enabled = true },
        functionLikeReturnTypes = { enabled = true },
        parameterNames = { enabled = "literals" },
        parameterTypes = { enabled = true },
        propertyDeclarationTypes = { enabled = true },
        variableTypes = { enabled = false },
      },
    },
  },
})

vim.lsp.config("lua_ls", { settings = { Lua = { hint = true } } })
vim.lsp.config("gopls", {
  settings = {
    gopls = {
      gofumpt = true,
      codelenses = {
        gc_details = false,
        generate = true,
        regenerate_cgo = true,
        run_govulncheck = true,
        test = true,
        tidy = true,
        upgrade_dependency = true,
        vendor = true,
      },
      hints = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
        compositeLiteralTypes = true,
        constantValues = true,
        functionTypeParameters = true,
        parameterNames = true,
        rangeVariableTypes = true,
      },
      analyses = {
        nilness = true,
        unusedparams = true,
        unusedwrite = true,
        useany = true,
      },
      maxMemory = 700,
      usePlaceholders = true,
      completeUnimported = true,
      staticcheck = true,
      directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
      semanticTokens = true,
    },
  },
})

vim.lsp.enable({
  "lua_ls",
  "gopls",
  -- "rust_analyzer",
  "tailwindcss",
  -- "tsgo",
  -- "vtsls",
  "zls",
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

vim.g.rustaceanvim = {
  server = {
    on_attach = function(_, bufnr)
      vim.keymap.set("n", "<leader>cR", function()
        vim.cmd.RustLsp("codeAction")
      end, { desc = "Code Action", buffer = bufnr })
      vim.keymap.set("n", "<leader>dr", function()
        vim.cmd.RustLsp("debuggables")
      end, { desc = "Rust Debuggables", buffer = bufnr })
    end,
    default_settings = {
      ["rust-analyzer"] = {
        cargo = {
          allFeatures = false,
          loadOutDirsFromCheck = false,
          buildScripts = { enable = false },
          runBuildScripts = false,
        },
        checkOnSave = false,
        diagnostics = { enable = false },
        procMacro = { enable = false },
        files = {
          exclude = {
            ".direnv",
            ".git",
            ".jj",
            ".github",
            ".gitlab",
            "bin",
            "node_modules",
            "target",
            "venv",
            ".venv",
          },
          watcher = "client",
        },
        linkedProjects = {},
      },
    },
  },
}

require("conform").setup({
  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },
  default_format_opts = { stop_after_first = true, timeout_ms = 1000 },
  formatters_by_ft = {
    javascript = { "oxfmt" },
    typescript = { "oxfmt" },
    javascriptreact = { "oxfmt" },
    typescriptreact = { "oxfmt" },
    -- markdown = { "prettier" },
    go = { "goimports", "gofumpt" },
  },
})

require("noice").setup({
  cmdline = {
    view = "cmdline",
  },
  lsp = {
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true,
    },
  },
  routes = {
    {
      filter = {
        event = "msg_show",
        any = {
          { find = "%d+L, %d+B" },
          { find = "; after #%d+" },
          { find = "; before #%d+" },
        },
      },
      view = "mini",
    },
  },
  presets = {
    bottom_search = true,
    command_palette = true,
    long_message_to_split = true,
    lsp_doc_border = true,
  },
})

function root_dir(opts)
  opts = vim.tbl_extend("force", {
    cwd = false,
    subdirectory = true,
    parent = true,
    other = true,
    icon = "󱉭",
  }, opts or {})

  local function get()
    local cwd = vim.uv.cwd()
    local root = vim.fs.root(0, { ".git", "lua" }) or cwd
    local name = vim.fs.basename(root)

    if root == cwd then
      return opts.cwd and name
    elseif root:find(cwd, 1, true) == 1 then
      return opts.subdirectory and name
    elseif cwd:find(root, 1, true) == 1 then
      return opts.parent and name
    else
      return opts.other and name
    end
  end

  color = function()
    local c = require("catppuccin.palettes").get_palette()
    return { fg = c.pink, gui = "bold" }
  end

  return {
    function()
      local dir = get()
      if not dir then
        return ""
      end
      return (opts.icon and (opts.icon .. " ")) .. dir
    end,
    cond = function()
      return get() ~= nil
    end,
    color = color,
  }
end

require("lualine").setup({
  options = {
    theme = "auto",
    component_separators = "",
    section_separators = { left = "", right = "" },
    globalstatus = vim.o.laststatus == 3,
    disabled_filetypes = { statusline = { "dashboard", "alpha", "ministarter", "snacks_dashboard" } },
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch" },

    lualine_c = {
      root_dir(),
      {
        "diagnostics",
        symbols = {
          error = " ",
          warn = " ",
          info = " ",
          hint = " ",
        },
      },
      { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
    },
    lualine_x = {
      {
        "diff",
        source = function()
          local gitsigns = vim.b.gitsigns_status_dict
          if gitsigns then
            return {
              added = " ",
              modified = " ",
              removed = " ",
            }
          end
        end,
      },
    },
    lualine_y = {
      { "progress", separator = " ",                  padding = { left = 1, right = 0 } },
      { "location", padding = { left = 0, right = 1 } },
    },
    lualine_z = {
      function()
        return os.date("%I:%M %p")
      end,
    },
  },
})

require("gitsigns").setup({
  signs = {
    add = { text = "▎" },
    change = { text = "▎" },
    delete = { text = "" },
    topdelete = { text = "" },
    changedelete = { text = "▎" },
    untracked = { text = "▎" },
  },
  signs_staged = {
    add = { text = "▎" },
    change = { text = "▎" },
    delete = { text = "" },
    topdelete = { text = "" },
    changedelete = { text = "▎" },
  },
  on_attach = function(buffer)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, desc)
      vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc, silent = true })
    end

    map("n", "]h", function()
      if vim.wo.diff then
        vim.cmd.normal({ "]c", bang = true })
      else
        gs.nav_hunk("next")
      end
    end, "Next Hunk")
    map("n", "[h", function()
      if vim.wo.diff then
        vim.cmd.normal({ "[c", bang = true })
      else
        gs.nav_hunk("prev")
      end
    end, "Prev Hunk")
    map("n", "]H", function()
      gs.nav_hunk("last")
    end, "Last Hunk")
    map("n", "[H", function()
      gs.nav_hunk("first")
    end, "First Hunk")
    map({ "n", "x" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
    map({ "n", "x" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
    map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
    map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
    map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
    map("n", "<leader>ghp", gs.preview_hunk_inline, "Preview Hunk Inline")
    map("n", "<leader>ghb", function()
      gs.blame_line({ full = true })
    end, "Blame Line")
    map("n", "<leader>ghB", function()
      gs.blame()
    end, "Blame Buffer")
    map("n", "<leader>ghd", gs.diffthis, "Diff This")
    map("n", "<leader>ghD", function()
      gs.diffthis("~")
    end, "Diff This ~")
    map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
  end,
})

require("tiny-inline-diagnostic").setup()
vim.diagnostic.config({
  virtual_text = false,
  jump = { float = true },
})

require("bufferline").setup({
  options = {
    mode = "buffers",
    separator_style = "thin",
    show_buffer_close_icons = true,
    show_close_icon = true,
  },
  highlights = require("catppuccin.special.bufferline").get_theme(),
})

require("catppuccin").setup({
  auto_integrations = true,
  lsp_styles = {
    underlines = {
      errors = { "undercurl" },
      hints = { "undercurl" },
      warnings = { "undercurl" },
      information = { "undercurl" },
    },
    integrations = {
      blink_cmp = true,
      flash = true,
      grug_far = true,
      gitsigns = true,
      indent_blankline = {
        enabled = true,
      },
      lsp_trouble = true,
      mason = true,
      mini = true,
      navic = { enabled = true, custom_bg = "lualine" },
      noice = true,
      notify = true,
      snacks = true,
      -- telescope = true,
      treesitter_context = true,
    },
  },
  transparent_background = true,
  float = {
    solid = true,
    transparent = true,
  },
})
vim.cmd("colorscheme catppuccin-mocha")

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

require("lazydev").setup({
  library = { { path = "${3rd}/luv/library", words = { "vim%.uv" } } },
})

require("luasnip").setup({ enable_autosnippets = true })
require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/snippets/" })

local map = vim.keymap.set

map({ "n" }, "<leader>ff", builtin.find_files, { desc = "Telescope live grep" })
map({ "n" }, "<leader>sg", builtin.live_grep)
map({ "n" }, "<leader>/", builtin.live_grep)
map({ "n" }, "<leader>fb", builtin.buffers)
map({ "n" }, "<leader>fg", "<cmd>Telescope git_files<cr>")
map({ "v" }, "<leader>sw", builtin.grep_string)
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
-- { '<leader>s"', "<cmd>Telescope registers<cr>", desc = "Registers" },
-- { "<leader>s/", "<cmd>Telescope search_history<cr>", desc = "Search History" },
-- { "<leader>sa", "<cmd>Telescope autocommands<cr>", desc = "Auto Commands" },
-- { "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer Lines" },
-- { "<leader>sc", "<cmd>Telescope command_history<cr>", desc = "Command History" },
-- { "<leader>sC", "<cmd>Telescope commands<cr>", desc = "Commands" },
-- { "<leader>sd", "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics" },
-- { "<leader>sD", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Buffer Diagnostics" },
-- { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
-- { "<leader>sH", "<cmd>Telescope highlights<cr>", desc = "Search Highlight Groups" },
-- { "<leader>sj", "<cmd>Telescope jumplist<cr>", desc = "Jumplist" },
-- { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
-- { "<leader>sl", "<cmd>Telescope loclist<cr>", desc = "Location List" },
-- { "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
-- { "<leader>sm", "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },
-- { "<leader>so", "<cmd>Telescope vim_options<cr>", desc = "Options" },
-- { "<leader>sR", "<cmd>Telescope resume<cr>", desc = "Resume" },
-- { "<leader>sq", "<cmd>Telescope quickfix<cr>", desc = "Quickfix List" },
