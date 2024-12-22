local M = {}

M.general = {
  n = {
    ["<leader>h"] = { "<C-w>h", "window left" },
    ["<leader>l"] = { "<C-w>l", "window right" },
    ["<leader>j"] = { "<C-w>j", "window down" },
    ["<leader>k"] = { "<C-w>k", "window up" },
  },
}

M.telescope = {
  n = {
    ["<leader>ff"] = { "<cmd> Telescope current_buffer_fuzzy_find <CR>", "find in current buffer" },
    ["<leader>fz"] = { "<cmd> Telescope find_files <CR>", "find files" },
    ["<leader>fg"] = { "<cmd> Telescope live_grep <CR>", "live grep" },
    ["<leader>ft"] = { "<cmd> Telescope git_files <CR>", "search git files" },
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
    ["<leader>nn"] = {
      function()
        vim.lsp.buf.rename()
      end,
      "rename the symbol",
    },
    ["<leader>me"] = {
      function()
        require"telescope".extensions.metals.commands()
      end,
      "open metals command prompt"
    }
  },
}

M.dap = {
  n = {
    ["<leader>dc"] = {
      function()
        require("dap").continue()
      end,
      "dap continue",
    },
    ["<leader>dr"] = {
      function()
        require("dap").repl.toggle()
      end,
      "dap toggle repl",
    },

    ["<leader>dK"] = {
      function()
        require("dap.ui.widgets").hover()
      end,
      "dap widgets (ui only)",
    },

    ["<leader>dt"] = {
      function()
        require("dap").toggle_breakpoint()
      end,
      "dap toggle breakpoint",
    },

    ["<leader>dso"] = {
      function()
        require("dap").step_over()
      end,
      "dap step over",
    },

    ["<leader>dsi"] = {
      function()
        require("dap").step_into()
      end,
      "dap step into",
    },

    ["<leader>dl"] = {
      function()
        require("dap").run_last()
      end,
      "dap run last",
    },
    ["<leader>dui"] = {
      function()
        require("dapui").toggle()
      end,
      "dap open dapui",
    },
  },
}

M.tabufline = {
  n = {
    ["<leader>tt"] = {
      function()
        require("nvchad.tabufline").tabuflineNext()
      end,
      "tabufline next buffer",
    },
  },
}

return M
