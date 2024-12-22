require "nvchad.options"

-- add yours here!

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!
local autocmd = vim.api.nvim_create_autocmd
autocmd({ "WinLeave" }, {
  callback = function()
    if vim.bo.ft == "TelescopePrompt" and vim.fn.mode() == "i" then
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "i", false)
    end
  end,
})

local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
autocmd("FileType", {
  pattern = { "scala", "sbt" },
  callback = function()
    local metals_config = require("metals").bare_config()
    metals_config.settings = {
      showImplicitArguments = true,
      showInferredType = true,
      serverVersion = "1.4.1",
      enableSemanticHighlighting = true,
    }
    metals_config.init_options.statusBarProvider = "on"
    metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()

    metals_config.on_attach = function(_, _)
      local dap, dapui = require "dap", require "dapui"
      dap.configurations.scala = {
        {
          type = "scala",
          request = "launch",
          name = "RunOrTest",
          metals = {
            runType = "runOrTestFile",
          },
        },
        {
          type = "scala",
          request = "launch",
          name = "Test Target",
          metals = {
            runType = "testTarget",
          },
        },
      }
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      -- dap.listeners.before.event_terminated["dapui_config"] = function()
      --   dapui.close()
      -- end
      -- dap.listeners.before.event_exited["dapui_config"] = function()
      --   dapui.close()
      -- end
      dapui.setup()
      require("metals").setup_dap()
    end

    require("metals").initialize_or_attach(metals_config)
  end,
  group = nvim_metals_group,
})

local highlight_yank = vim.api.nvim_create_augroup("highlight_yank", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  pattern = "*",
  callback = function()
    require("vim.highlight").on_yank()
  end,
  group = highlight_yank,
})

-- smithy stuff
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.smithy" },
  callback = function()
    vim.cmd "setfiletype smithy"
  end,
})

vim.o.background = "dark"

vim.opt.rnu = true
vim.opt.swapfile = false
vim.opt.wrap = false
vim.highlight.priorities.semantic_tokens = 95 -- Or any number lower than 100, treesitter's priority level
