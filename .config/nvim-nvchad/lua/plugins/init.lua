return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    opts = function(_, conf)
      local cmp = require "cmp"
      local luasnip = require "luasnip"

      -- Load snippets from friendly-snippets
      require("luasnip.loaders.from_vscode").lazy_load()
      require("luasnip.loaders.from_vscode").lazy_load { paths = { "./snippets" } }
      require("luasnip.loaders.from_vscode").lazy_load { paths = { "./snippets/typescript" } }
      require("luasnip.loaders.from_vscode").lazy_load { paths = { "./snippets/javascript" } }
      require("luasnip.loaders.from_vscode").lazy_load { paths = { "./snippets/html" } }
      require("luasnip.loaders.from_vscode").lazy_load { paths = { "./snippets/css" } }

      conf.sources = {
        { name = "copilot" },
        { name = "nvim_lsp" },
        { name = "luasnip" }, -- Snippets
        { name = "buffer" }, -- Buffer words
        { name = "path" }, -- File paths
      }
      conf.completion = {
        completeopt = "menu,menuone,noinsert", -- Show menu, select one, no insert
      }
      conf.window = {
        completion = {
          border = "rounded", -- Rounded borders for completion menu
          -- winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
        },
        documentation = {
          border = "rounded", -- Rounded borders for documentation popup
          -- winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
        },
      }

      conf.formatting = {
        format = function(entry, item)
          item.menu = ({
            nvim_lsp = "[LSP]",
            luasnip = "[Snip]",
            buffer = "[Buf]",
            path = "[Path]",
          })[entry.source.name] or ""
          return item
        end,
      }
      -- autocomplete for copilot.lua

      conf.snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body) -- Use luasnip to expand snippets
        end,
      }

      conf.experimental = {
        ghost_text = {
          hl_group = "LspCodeLens", -- Highlight group for ghost text
        },
      }

      conf.confirm_opts = {
        behavior = cmp.ConfirmBehavior.Replace, -- Replace text on confirm
        select = false, -- Do not select item on confirm
      }

      conf.mapping = {
        ["<C-d>"] = cmp.mapping.scroll_docs(-4), -- Scroll documentation up
        ["<C-f>"] = cmp.mapping.scroll_docs(4), -- Scroll documentation down
        ["<C-e>"] = cmp.mapping.abort(), -- Abort completion
      }
      conf.mapping["<C-Space>"] = cmp.mapping(function()
        cmp.complete()
      end, { "i", "n" })
      -- conf.mapping["<C-y>"] = cmp.mapping.confirm { select = true } -- confirm completion with Ctrl+y
      conf.mapping["<C-n>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        else
          fallback() -- Fallback to default behavior
        end
      end, { "i", "c" })

      conf.mapping["<C-p>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        else
          fallback() -- Fallback to default behavior
        end
      end, { "i", "c" })

      -- -- Smart Tab (confirm completion or jump to next snippet placeholder)
      -- conf.mapping["<Tab>"] = cmp.mapping(function(fallback)
      --   if cmp.visible() then
      --     cmp.confirm { select = true } -- confirm completion
      --   elseif luasnip.expand_or_jumpable() then
      --     luasnip.expand_or_jump() -- jump to next snippet placeholder
      --   else
      --     fallback() -- insert real tab
      --   end
      -- end, { "i", "s" })
      --
      -- Smart Shift+Tab (go backwards in snippets or cmp menu)
      conf.mapping["<S-Tab>"] = cmp.mapping(function()
        if cmp.visible() then
          cmp.select_prev_item() -- select previous item in completion menu
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1) -- jump to previous snippet placeholder
        else
          cmp.select_next_item() -- select next item in completion menu
        end
      end, { "i", "s" })

      conf.mapping["<M-]>"] = cmp.mapping(function()
        if require("copilot.suggestion").is_visible() then
          require("copilot.suggestion").next()
        else
          cmp.select_next_item()
        end
      end, { "i", "c" })

      conf.mapping["<M-[>"] = cmp.mapping(function()
        if require("copilot.suggestion").is_visible() then
          require("copilot.suggestion").prev()
        else
          cmp.select_next_item()
        end
      end, { "i", "c" })

      conf.mapping["<M-Tab>"] = cmp.mapping(function(fallback)
        if require("copilot.suggestion").is_visible() then
          require("copilot.suggestion").accept_line()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump() -- jump to next snippet placeholder
        else
          fallback() -- insert real tab
        end
      end, { "i", "s" })

      conf.mapping["<Tab>"] = cmp.mapping(function(fallback)
        -- if require("copilot.suggestion").is_visible() then
        --   require("copilot.suggestion").accept_line()
        if cmp.visible() then
          cmp.confirm { select = true } -- confirm completion
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump() -- jump to next snippet placeholder
        else
          fallback() -- insert real tab
        end
      end, { "i", "s" })

      conf.mapping["<C-y>"] = cmp.mapping(function(fallback)
        -- if require("copilot.suggestion").is_visible() then
        --   require("copilot.suggestion").accept()
        if cmp.visible() then
          cmp.confirm { select = true } -- confirm completion
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump() -- jump to next snippet placeholder
        else
          fallback() -- insert real tab
        end
      end, { "i", "s" })

      conf.mapping["<CR>"] = cmp.mapping(function(fallback)
        -- if cmp.visible() then
        --   cmp.confirm { select = true } -- confirm completion
        if luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump() -- jump to next snippet placeholder
        else
          fallback()
        end
      end, { "i", "c" })

      return conf
    end,
  },

  -- test new blink
  -- { import = "nvchad.blink.lazyspec", opts = { keymap = { preset = "" } } },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "c",
        "diff",
        "html",
        "lua",
        "luadoc",
        "markdown",
        "markdown_inline",
        "typescript",
        "javascript",
        "tsx",
        "query",
        "zig",
      },
      auto_install = false,
      highlight = {
        enable = true,
        use_languagetree = true,
        additional_vim_regex_highlighting = { "ruby" },
      },
      indent = { enable = true, disable = { "ruby" } },
    },
  },
}
