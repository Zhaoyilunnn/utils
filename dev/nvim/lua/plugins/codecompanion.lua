return {
  "olimorris/codecompanion.nvim",
  config = true,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  opts = {
    strategies = {
      chat = {
        -- adapter = {
        --   name = "copilot",
        --   model = "gemini-2.5-pro",
        -- },
        adapter = "copilot",
      },
    },
  },
}
