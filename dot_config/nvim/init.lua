-- load plugins
require('plugins')

local opt = vim.opt
local opt_global = vim.opt
local vim_g = vim.g
local bindkey = vim.keymap.set

HOME = os.getenv("HOME")
opt_global.shortmess:remove('F')
vim_g.mapleader = [[ ]] -- map space to the leader key
opt.guicursor = ''
opt.showmatch = false
opt.relativenumber = true
opt.hlsearch = false
opt.hidden = true
opt.errorbells = false
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true
opt.nu = true
opt.wrap = false
opt.smartcase = true
opt.swapfile = false
opt.backup = false
opt.undodir = HOME .. [[/.vim/undodir]] -- string concat
opt.undofile = true
opt.incsearch = true
opt.termguicolors = true
opt.scrolloff = 8
opt.completeopt = { 'menu', 'menuone', 'noselect' }

-- loaded python provider = 0 means no python 2
vim_g.loaded_python_provider = 0

bindkey('n', '<leader><CR>', ':so ' .. HOME .. '/.config/nvim/init.lua<CR>')
bindkey('n', '<leader>u', ':UndotreeToggle<CR>')

bindkey('n', '<leader>h', ':wincmd h<CR>', {silent = true})
bindkey('n', '<leader>j', ':wincmd j<CR>', {silent = true})
bindkey('n', '<leader>k', ':wincmd k<CR>', {silent = true})
bindkey('n', '<leader>l', ':wincmd l<CR>', {silent = true})

local theme = require'telescope.themes'.get_dropdown()
bindkey('n', '<leader>fz', function() require('telescope.builtin').find_files(theme) end)
bindkey('n', '<leader>fg', function() require('telescope.builtin').live_grep(theme) end)
bindkey('n', '<leader>fb', function() require('telescope.builtin').buffers(theme) end)
bindkey('n', '<leader>fh', function() require('telescope.builtin').help_tags(theme) end)

bindkey('n', '<leader>rl', function() opt.relativenumber = not opt.relativenumber:get() end)

-- this loads the theme
require('colorscheme')

-- setup treesitter
require'nvim-treesitter.configs'.setup {
    ensure_installed = {'scala', 'json', 'c', 'rust', 'hcl', 'lua'},
    sync_install = false,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
}

-- lsp config
vim_g.coq_settings = { auto_start = 'shut-up' }
local servers = {
    'jsonls',
    'sqlls',
    'sumneko_lua',
    'tflint',
    'tsserver',
    'svelte',
    'bashls',
    'cmake',
    'html',
    'rust_analyzer',
    'pyright',
    'terraformls',
    'yamlls',
    'clangd',
    'dotls',
    'jdtls',
}

require'nvim-lsp-installer'.setup {
    ensure_installed = servers
}

local lsp = require "lspconfig"
local coq = require "coq"


for _, server in pairs(servers) do
    if server == 'sumneko_lua' then
        lsp.sumneko_lua.setup {
            settings = {
                Lua = {
                    diagnostics = {
                        globals = {'vim'},
                    },
                },
            },
        }
    else
        lsp[server].setup({})
    end
    lsp[server].setup(coq.lsp_ensure_capabilities())
end

local metals_config = require'metals'.bare_config()

metals_config.settings = {
    showImplicitArguments = true,
}

metals_config.init_options.statusBarProvider = 'on'

local api = vim.api
local nvim_metals_group = api.nvim_create_augroup('nvim-metals', { clear = true })
api.nvim_create_autocmd('FileType', {
    pattern = { 'scala', 'sbt' },
    callback = function ()
        require'metals'.initialize_or_attach(metals_config)
    end,
    group = nvim_metals_group,
})

local highlight_yank = api.nvim_create_augroup('highlight_yank', { clear = true })
api.nvim_create_autocmd('TextYankPost', {
    pattern = '*',
    callback = function ()
        require'vim.highlight'.on_yank()
    end,
    group = highlight_yank,
})

local lsp_buf = vim.lsp.buf
local diagnostic = vim.diagnostic

bindkey('n', '<leader>gd', function() lsp_buf.definition() end)
bindkey('n', '<leader>gr', function() lsp_buf.references() end)
bindkey('n', '<leader>gq', function() lsp_buf.hover() end)
bindkey('n', '<leader>gi', function() lsp_buf.implementation() end)
bindkey('n', '<leader>gds', function() lsp_buf.document_symbol() end)
bindkey('n', '<leader>gws', function() lsp_buf.workspace_symbol() end)
bindkey('n', '<leader>rn', function() lsp_buf.rename() end)
bindkey('n', '[c', function() diagnostic.goto_prev { wrap = false } end)
bindkey('n', ']c', function() diagnostic.goto_next { wrap = false } end)



