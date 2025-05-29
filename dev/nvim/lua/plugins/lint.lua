-- https://github.com/LazyVim/LazyVim/discussions/4094#discussioncomment-10178217
-- For disable MD013: https://github.com/DavidAnson/markdownlint/blob/main/doc/md013.md
local HOME = os.getenv("HOME")
return {
  "mfussenegger/nvim-lint",
  optional = true,
  opts = {
    linters = {
      ["markdownlint-cli2"] = {
        args = { "--config", HOME .. "/.config/nvim/.markdownlint-cli2.yaml", "--" },
      },
    },
  },
}
