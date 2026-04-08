return {
  "openqasm/openqasm.vim",
  config = false, -- not auto config
  init = function()
    vim.filetype.add({ extension = { qasm = "openqasm" } })
  end,
}
