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

-- Copilot proxy: https://github.com/github/copilot.vim/blob/1358e8e45ecedc53daf971924a0541ddf6224faf/doc/copilot.txt#L77-L91
-- vim.g.copilot_proxy = "http://127.0.0.1:10808"
vim.g.copilot_filetypes = {
  tex = false, -- disable copilot for latex
}

-- LSP config
-- vim.lsp.enable("ltex", true)
-- vim.lsp.enable("texlab", false)
-- vim.lsp.enable("ltex_plus")
