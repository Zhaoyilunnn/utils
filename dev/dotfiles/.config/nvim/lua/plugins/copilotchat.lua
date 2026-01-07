return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "github/copilot.vim" }, -- or zbirenbaum/copilot.lua
      { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
    },
    build = "make tiktoken", -- Only on MacOS or Linux
    opts = {
      -- See Configuration section for options
      -- model = "gemini-2.5-pro",
      model = "gpt-4.1",
      -- model = "gpt-5",
      -- model = "gpt-5-mini",
    },
    -- See Commands section for default commands if you want to lazy load on them
  },
}
