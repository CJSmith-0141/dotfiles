-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- smithy stuff
augroup("smithy-files", { clear = true })
autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.smithy" },
  callback = function()
    vim.cmd("setfiletype smithy")
  end,
  group = "smithy-files",
})
