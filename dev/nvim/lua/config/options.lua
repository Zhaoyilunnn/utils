-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- spelling check
vim.opt.spell = true
vim.opt.spelllang = "en_us"

-- change line automatically
vim.opt.wrap = true

-- disable AI completion in nvim-cmp / blink.cmp
vim.g.ai_cmp = false
