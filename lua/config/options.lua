-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.g.autoformat = false

vim.opt.clipboard = "unnamedplus"

vim.g.snacks_animate = false

vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.showbreak = "↪ "
vim.opt.breakindent = true

vim.opt.sidescroll = 5
vim.opt.sidescrolloff = 8

vim.opt.listchars = {
  extends = "›",
  precedes = "‹",
  tab = "→ ",
  trail = "·",
}

-- Enable true color support
-- vim.opt.termguicolors = true
