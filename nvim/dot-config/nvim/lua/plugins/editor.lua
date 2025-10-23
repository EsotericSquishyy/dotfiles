vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>")
vim.keymap.set("n", "-", "<cmd>Oil<CR>")

return {
  {
    "ibhagwan/fzf-lua",
    dependencies = { "echasnovski/mini.icons" },
    opts = {},
    config = function()
      local actions = require("fzf-lua.actions")
      require("fzf-lua").setup({
        "fzf-vim",
        files = {
          git_icons = false,
          file_icons = false,
        },
        grep = {
          git_icons = false,
          file_icons = false,
          rg_glob = true,
          rg_opts = "--column --line-number --no-heading --color=always --smart-case "
            .. "--max-columns=4096 --pcre2 -e", -- Added -P for perl regex
        },
        keymap = {
          fzf = {
            -- https://man.archlinux.org/man/fzf.1.en#AVAILABLE_ACTIONS:
            ["ctrl-q"] = "select-all+accept",
          },
        },
      })

      vim.keymap.set("n", "<leader>fm", require('fzf-lua').builtin) -- Find builtins
      vim.keymap.set("n", "<leader>fh", require('fzf-lua').helptags) -- Find help tags
      vim.keymap.set("n", "<leader>ff", require('fzf-lua').files) -- Find files
      vim.keymap.set("n", "<leader>fr", require('fzf-lua').resume) -- Resume previous picker
      vim.keymap.set("n", "<leader>fg", require('fzf-lua').live_grep) -- Find text
      vim.keymap.set("n", "<leader>fq", require('fzf-lua').lgrep_quickfix) -- Find text
      vim.keymap.set("n", "<leader>fb", require('fzf-lua').buffers) -- Find buffers
      vim.keymap.set("n", "<leader>fc", function() -- Find config
        require('fzf-lua').files({ cwd = vim.fn.stdpath("config") })
      end, { desc = "Find config files" })
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

  {
    'NickvanDyke/opencode.nvim',
    dependencies = {
      { "folke/snacks.nvim", opts = { input = {} } },
    },
    config = function()
      vim.g.opencode_opts = {
        input = {
          prompt = "Ask",
          icon = "",
        },
        terminal = false, -- disable nvim opencode terminal
      }
      vim.o.autoread = true

      vim.keymap.set('n', '<leader>oA', function() require('opencode').ask("", { submit = true }) end, { desc = 'Ask opencode' })
      vim.keymap.set({'n', 'v'}, "<leader>oa", function() require("opencode").ask("@this: ", { submit = true }) end, { desc = "Ask about this" })
      vim.keymap.set('n', '<leader>oy', function() require('opencode').command('messages_copy') end, { desc = 'Copy last opencode response' })
    end,
  },
}
