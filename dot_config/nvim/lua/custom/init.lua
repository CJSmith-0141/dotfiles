local autocmd = vim.api.nvim_create_autocmd
autocmd(
  {"WinLeave"},
  {
  callback = function ()
    if vim.bo.ft == "TelescopePrompt" and vim.fn.mode() == "i" then
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "i", false)
    end
  end
})

local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
autocmd("FileType", {
  pattern = { "scala", "sbt"},
  callback = function()
    require("metals").initialize_or_attach({})
  end,
  group = nvim_metals_group,
})

local highlight_yank = vim.api.nvim_create_augroup('highlight_yank', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  pattern = '*',
  callback = function ()
    require'vim.highlight'.on_yank()
  end,
  group = highlight_yank,
})
-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })
