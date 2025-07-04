return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      local capabilities = require('blink.cmp').get_lsp_capabilities()

      require("lspconfig").lua_ls.setup { capabilites = capabilities }
      require("lspconfig").pyright.setup { capabilites = capabilities }
      require("lspconfig")["tinymist"].setup {
        capabilites = capabilities,
        settings = {
          formatterMode = "typstyle",
          exportPdf = "onType",
          semanticTokens = "disable"
        }
      }

      vim.keymap.set("n", "<leader>F", function() vim.lsp.buf.format() end)
    end,
  },

  {
    'saghen/blink.cmp',
    dependencies = {
      "L3MON4D3/LuaSnip",
      dependencies = "rafamadriz/friendly-snippets";
      version = "v2.*",
      build = "make install_jsregexp",
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
        require("luasnip.loaders.from_lua").load({ paths = { vim.fn.stdpath 'config' .. '/snippets' } })
        vim.api.nvim_set_keymap("i", "<C-n>", "<Plug>luasnip-next-choice", {})
        vim.api.nvim_set_keymap("i", "<C-p>", "<Plug>luasnip-prev-choice", {})
        vim.api.nvim_set_keymap("s", "<C-n>", "<Plug>luasnip-next-choice", {})
        vim.api.nvim_set_keymap("s", "<C-p>", "<Plug>luasnip-prev-choice", {})
      end,
    },
    version = '*',
    opts = {
      keymap = {
        ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
        ['<C-e>'] = { 'hide', 'fallback' },

        ['<Tab>'] = {
          function(cmp)
            if cmp.snippet_active() then return cmp.accept()
            else return cmp.select_and_accept() end
          end,
          'fallback'
        },

        ['<M-Tab>'] = { 'snippet_forward', 'fallback' },
        ['<M-S-Tab>'] = { 'snippet_backward', 'fallback' },

        ['<Up>'] = { 'select_prev', 'fallback' },
        ['<Down>'] = { 'select_next', 'fallback' },
        ['<C-p>'] = { 'select_prev', 'fallback' },
        ['<C-n>'] = { 'select_next', 'fallback' },

        ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
        ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },

        ['<C-k>'] = { 'show_signature', 'hide_signature', 'fallback' },
      },
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = 'mono'
      },
      signature = { enabled = true },
      snippets = { preset = 'luasnip' },
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer'},
      },
    },
  }
}
