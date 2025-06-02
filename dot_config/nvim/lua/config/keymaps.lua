local M = require("config.mappings_old")

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

for _, maps in pairs(M) do
  for _, data in pairs(maps) do
    for key, val in pairs(data) do
      map("n", key, val[1], { desc = val[2] })
    end
  end
end

map({ "n", "i", "v" }, "<leader>/", "<cmd> w <cr>")
