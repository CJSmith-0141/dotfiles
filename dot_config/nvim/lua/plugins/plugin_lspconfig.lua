return {
  "neovim/nvim-lspconfig",
  opts = {
    inlay_hints = {
      enabled = true,
      exclude = { "sbt", "scala", "vue" },
    },
    codelens = {
      enabled = true,
    },
  },
}
