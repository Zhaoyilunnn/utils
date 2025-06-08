-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set({ "n", "v" }, "<C-a>", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "<LocalLeader>a", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true })
vim.keymap.set("v", "ga", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true })

-- Expand 'cc' into 'CodeCompanion' in the command line
vim.cmd([[cab cc CodeCompanion]])

-- Show the full file path in the command line
vim.keymap.set("n", "<C-g>", function()
  local buf = vim.api.nvim_create_buf(false, true)
  local full_path = vim.fn.expand("%:p")
  -- store the path in clipboard for easy access
  vim.fn.setreg("+", full_path)
  local width = math.min(#full_path + 4, vim.o.columns)
  local height = 1
  local row = vim.o.lines - 3
  local col = math.floor((vim.o.columns - width) / 2)

  vim.api.nvim_open_win(buf, false, {
    relative = "editor",
    width = width,
    height = height,
    row = row,
    col = col,
    style = "minimal",
    border = "single",
  })

  vim.api.nvim_buf_set_lines(buf, 0, -1, false, { " " .. full_path .. " " })

  vim.defer_fn(function()
    vim.api.nvim_buf_delete(buf, { force = true })
  end, 3000)
end, { desc = "Show full file path in float" })

-- Duplicate the current line and comment the first line
vim.keymap.set("n", "ycc", "yygccp", { remap = true })
