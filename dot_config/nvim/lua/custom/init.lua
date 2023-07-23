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
    local metals_config = require('metals').bare_config()
    metals_config.settings = {
      showImplicitArguments = true,
      showInferredType = true,
    }
    metals_config.init_options.statusBarProvider = 'on'
    require("metals").initialize_or_attach(metals_config)
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

local bindkey = vim.keymap.set
vim.opt.rnu = true
vim.opt.swapfile = false
vim.opt.wrap = false
bindkey('n', '<leader>gd', function() vim.lsp.buf.definition() end)
bindkey('n', '<leader>gr', function() vim.lsp.buf.references() end)
bindkey('n', '<leader>gq', function() vim.lsp.buf.hover() end)
bindkey('n', '<leader>gi', function() vim.lsp.buf.implementation() end)
-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })
