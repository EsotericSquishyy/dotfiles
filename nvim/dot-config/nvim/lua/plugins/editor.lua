vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>")
vim.keymap.set("n", "-", "<cmd>Oil<CR>")

return {
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        -- config = function()
        --   require('telescope').load_extension('fzf')
        -- end,
      }
    },
    config = function()
      require('telescope').load_extension('fzf')
      require('telescope').setup {
        pickers = {
          find_files = {
            theme = "ivy"
          },
          extensions = {
            fzf = {}
          }
        }
      }

      vim.keymap.set("n", "<leader>fm", require('telescope.builtin').builtin) -- Find builtins
      vim.keymap.set("n", "<leader>fh", require('telescope.builtin').help_tags) -- Find help tags
      vim.keymap.set("n", "<leader>ff", require('telescope.builtin').find_files) -- Find files
      vim.keymap.set("n", "<leader>fb", require('telescope.builtin').buffers) -- Find buffers
      vim.keymap.set("n", "<leader>fc", function() -- Find config
        local opts = require('telescope.themes').get_dropdown({
          cwd = vim.fn.stdpath("config")
        })
        require('telescope.builtin').find_files(opts)
      end)

      require('telescope.multigrep').setup()
    end
  },

  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
      "TmuxNavigatorProcessList",
    },
    keys = {
      { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
      { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    },
  },

  {
    'stevearc/oil.nvim',
    opts = {},
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
  },

  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },
}
