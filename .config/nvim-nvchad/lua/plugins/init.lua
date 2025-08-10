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
    dependencies = {
      "L3MON4D3/LuaSnip",
      config = function(_, conf)
        local ls = require "luasnip"

        vim.keymap.set({ "i", "s" }, "<Tab>", function()
          if ls.expand_or_jumpable() then
            ls.expand_or_jump()
          else
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, true, true), "n", true)
          end
        end, { silent = true })

        vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
          if ls.jumpable(-1) then
            ls.jump(-1)
          else
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<S-Tab>", true, true, true), "n", true)
          end
        end, { silent = true })
      end,
    },
    opts = function(_, conf)
      local cmp = require "cmp"
      local luasnip = require "luasnip"

      conf.mapping = {
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.confirm { select = true } -- confirm completion
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump() -- jump to next snippet placeholder
          else
            fallback() -- insert real tab
          end
        end, { "i", "s" }),

        -- Smart Shift+Tab (go backwards in snippets or cmp menu)
        ["<S-Tab>"] = cmp.mapping(function()
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            cmp.select_next_item()
          end
        end, { "i", "s" }),

        ["<C-n>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          else
            fallback()
          end
        end, { "i", "c" }),

        ["<C-p>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          else
            fallback()
          end
        end, { "i", "c" }),

        ["<CR>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            fallback() -- no confirm, just newline
          else
            fallback()
          end
        end, { "i", "s" }),

        ["<C-Space>"] = cmp.mapping.complete(),
      }
      return conf
    end,
  },
  -- test new blink
  -- { import = "nvchad.blink.lazyspec", opts = { keymap = { preset = "" } } },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
        "typescript",
        "javascript",
        "rust",
        "tsx",
        "zig",
      },
    },
  },
}
