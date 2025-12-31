vim.keymap.set("t", "<esc>", "<c-\\><c-n>")
vim.keymap.set ("n", "<space>tt", ":ToggleTerm size=70 direction=float<cr>", {silent = true})

return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {
      shade_terminals = false,
      highlights = {
          StatusLine = {guifg = "#ffffff", guibg = "#0E1018"},
          StatusLineNC = {guifg = "#ffffff", guibg = "#0E1018"}
      }
    }
  }
}
