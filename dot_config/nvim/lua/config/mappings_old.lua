local M = {}
local Snanks = require("snacks")

M.general = {
  n = {
    ["<leader>h"] = { "<C-w>h", "window left" },
    ["<leader>l"] = { "<C-w>l", "window right" },
    ["<leader>j"] = { "<C-w>j", "window down" },
    ["<leader>k"] = { "<C-w>k", "window up" },
  },
}

M.snacks = {
  n = {
    ["<leader>ff"] = {
      function()
        Snacks.picker.lines()
      end,
      "find in current buffer",
    },
    ["<leader>fz"] = {
      function()
        Snacks.picker.smart()
      end,
      "find files",
    },
    ["<leader>fg"] = {
      function()
        Snacks.picker.grep()
      end,
      "live grep",
    },
    ["<leader>ft"] = {
      function()
        Snacks.picker.git_files()
      end,
      "search git files",
    },
  },
}

M.metals = {
  n = {
    ["<leader>gD"] = {
      function()
        vim.lsp.buf.declaration()
      end,
      "lsp declaration",
    },
    ["<leader>gd"] = {
      function()
        vim.lsp.buf.definition()
      end,
      "lsp definition",
    },
    ["<leader>gi"] = {
      function()
        vim.lsp.buf.implementation()
      end,
      "lsp implementation",
    },
    ["<leader>gr"] = {
      function()
        vim.lsp.buf.references()
      end,
      "lsp references",
    },
    ["<leader>gq"] = {
      function()
        vim.lsp.buf.hover()
      end,
      "lsp documentation",
    },
    ["<leader>cl"] = {
      function()
        vim.lsp.codelens.run()
      end,
      "run the code",
    },
  },
}

return M
