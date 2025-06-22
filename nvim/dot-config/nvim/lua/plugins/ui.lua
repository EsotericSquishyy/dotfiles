return {
  -- Tab styling
  {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup()
    end
  },

  -- Cursor smearing
  {
    "sphamba/smear-cursor.nvim",
    opts = {
      -- https://github.com/sphamba/smear-cursor.nvim/blob/main/lua/smear_cursor/config.lua
      smear_to_cmd = true,

      stiffness = 0.8, -- 0 (slow) - 1 (fast)
      trailing_stiffness = 0.5,
      distance_stop_animating = 0.5,
    },
  },

  {
    -- Using snacks instead
    "goolord/alpha-nvim",
    enabled = false,
    dependencies = { 'echasnovski/mini.icons' },
    config = function()
      local startify = require("alpha.themes.startify")
      startify.file_icons.provider = "mini"
      require("alpha").setup(require("alpha.themes.theta").config)
    end,
  },

  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,

    opts = {
      dashboard = { enabled = true },
      scope = { enabled = true },
    },
  },

  {
    "rcarriga/nvim-notify",
    config = function()
      vim.notify = require('notify')
      require('notify').setup{
        background_colour = "#000000"
      }
    end
  },

  {
    "RRethy/base16-nvim",
    config = function()
      vim.cmd.colorscheme "base16-atelier-forest"
    end
  },

  {
    "xiyaowong/transparent.nvim",
    enabled = true,
    config = function()
      require("transparent").setup {
        groups = {
          'Normal', 'NormalNC', 'Comment', 'Constant', 'Special', 'Identifier',
          'Statement', 'PreProc', 'Type', 'Underlined', 'Todo', 'String', 'Function',
          'Conditional', 'Repeat', 'Operator', 'Structure', 'LineNr', 'NonText',
          'SignColumn', 'CursorLine', 'CursorLineNr', 'StatusLine', 'StatusLineNC',
          'EndOfBuffer',
          'TabLine', 'TabLineFill', 'TabLineSel',
        },
        extra_groups = {},
        exclude_groups = {},
        on_clear = function() end,
      }
      -- :TransparentEnable
    end,
  },

  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      local base16 = require('lualine.themes.base16')
      base16.normal.c.bg = 'none' -- removes main background

      require('lualine').setup{
        options = {
          theme = base16,
          globalstatus = true,
          always_show_tabline = true,
        },
        tabline = {
          lualine_a = {
            {
              'tabs',
              mode = 1,
            }
          },
        },
      }
    end
  }
}
