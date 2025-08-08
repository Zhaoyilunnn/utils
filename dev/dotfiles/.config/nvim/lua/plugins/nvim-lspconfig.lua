return {
  "neovim/nvim-lspconfig",
  opts = {
    inlay_hints = {
      enabled = true,
      exclude = { "vue", "tex" }, -- filetypes for which you don't want to enable inlay hints
    },
  },
}
