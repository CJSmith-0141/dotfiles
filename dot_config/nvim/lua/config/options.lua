-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.o.background = "dark"

vim.opt.rnu = true
vim.opt.swapfile = false
vim.opt.wrap = false
vim.highlight.priorities.semantic_tokens = 95 -- Or any number lower than 100, treesitter's priority level
vim.opt.spell = true
vim.opt.spelllang = "en_us"

if vim.g.neovide then
  vim.g.neovide_position_animation_length = 0.02
  vim.g.neovide_scroll_animation_length = 0.3
end
