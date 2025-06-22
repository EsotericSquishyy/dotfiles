-- General Config
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.list = true
vim.opt.listchars = {
  -- eol = "↵",
  trail = "·",
  tab = ">-",
  nbsp = "␣"
}
vim.opt.signcolumn = "number" -- Stops lsp warning from moving numbers
vim.opt.scrolloff = 7
vim.opt.swapfile = false

-- Leaders
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.opt.termguicolors = true
require("config.lazy")

-- Lua execution
vim.keymap.set("n", "<leader><leader>x", "<cmd>source %<CR>")
vim.keymap.set("n", "<leader>x", ":.lua<CR>")
vim.keymap.set("v", "<leader>x", ":lua<CR>")

-- Movement
vim.keymap.set("n", "<C-S-H>", ":wincmd H<CR>", { silent = true })
vim.keymap.set("n", "<C-S-J>", ":wincmd J<CR>", { silent = true })
vim.keymap.set("n", "<C-S-K>", ":wincmd K<CR>", { silent = true })
vim.keymap.set("n", "<C-S-L>", ":wincmd L<CR>", { silent = true })

-- Quickfix list
vim.keymap.set("n", "<M-j>", "<cmd>cnext<CR>")
vim.keymap.set("n", "<M-k>", "<cmd>cprev<CR>")

