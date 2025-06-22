return {
  {
    "neovim/nvim-lspconfig",
    -- dependencies = {
    --   'saghen/blink.cmp',
    --   {
    --     "folke/lazydev.nvim",
    --     opts = {
    --       library = {
    --         { path = "${3rd}/luv/library", words = { "vim%.uv" } },
    --       },
    --     },
    --   },
    -- },
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
      -- vim.api.nvim_create_autocmd('LspAttach', {
      --   callback = function(args)
      --     local c = vim.lsp.get_client_by_id(args.data.client_id)
      --     if not c then return end
      --
      --     if vim.bo.filetype == "lua" then
      --       -- Format the current buffer on save
      --       vim.api.nvim_create_autocmd('BufWritePre', {
      --         buffer = args.buf,
      --         callback = function()
      --           vim.lsp.buf.format({ bufnr = args.buf, id = c.id })
      --         end,
      --       })
      --     end
      --   end,
      -- })
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

        -- For debugging
        -- vim.keymap.set({"i", "s"}, "<return>",
        --   function()
        --       if require("luasnip").expand_or_jumpable() then
        --           require("luasnip").expand_or_jump()
        --       end
        --   end)

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
