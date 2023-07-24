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
      serverVersion = "1.0.0",
    }
    metals_config.init_options.statusBarProvider = "on"
    metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()

    metals_config.on_attach = function(client, bufnr)
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

vim.opt.rnu = true
vim.opt.swapfile = false
vim.opt.wrap = false
