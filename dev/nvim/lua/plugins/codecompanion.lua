return {
  "olimorris/codecompanion.nvim",
  config = true,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  strategies = {
    chat = {
      adapter = {
        name = "copilot",
        model = "claude-sonnet-4-20250514",
      },
    },
  },
}
