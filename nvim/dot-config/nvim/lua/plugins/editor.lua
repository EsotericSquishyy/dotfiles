vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>")
vim.keymap.set("n", "-", "<cmd>Oil<CR>")

return {
  {
    "ibhagwan/fzf-lua",
    dependencies = { "echasnovski/mini.icons" },
    opts = {},
    config = function()
      require('fzf-lua').setup({'fzf-vim'})

      vim.keymap.set("n", "<leader>fm", require('fzf-lua').builtin) -- Find builtins
      vim.keymap.set("n", "<leader>fh", require('fzf-lua').helptags) -- Find help tags
      vim.keymap.set("n", "<leader>ff", require('fzf-lua').files) -- Find files
      vim.keymap.set("n", "<leader>fg", require('fzf-lua').live_grep) -- Find text
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
}
