-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local opt = vim.opt

opt.shiftwidth = 4 -- Size of an indent
opt.tabstop = 4 -- Number of spaces tabs count for
opt.signcolumn = "yes:1" -- Always show the signcolumn, otherwise it would shift the text each time
opt.numberwidth = 2 -- set number column width to 2 {default 4}
opt.sidescrolloff = 0 -- Columns to keep to the left and right of the cursor
opt.textwidth = 100 -- Maximum width of text that is being inserted

-- LSP Server to use for Python.
-- Set to "basedpyright" to use basedpyright instead of pyright.
vim.g.lazyvim_python_lsp = "pyright"
-- Set to "ruff_lsp" to use the old LSP implementation version.
vim.g.lazyvim_python_ruff = "ruff"
vim.g.lazyvim_rust_diagnostics = "bacon-ls"

-- if the completion engine supports the AI source,
-- use that instead of inline suggestions
vim.g.ai_cmp = false

vim.g.lazyvim_picker = "snacks"

-- Set LazyVim root directory detection
vim.g.root_spec = { { ".git", "lua" }, "lsp", "cwd" }

if vim.env.SSH_TTY then
  opt.clipboard = "unnamedplus"
  vim.g.clipboard = {
    name = "OSC 52",
    copy = {
      ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
      ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
    },
    paste = {
      ["+"] = require("vim.ui.clipboard.osc52").paste("+"),
      ["*"] = require("vim.ui.clipboard.osc52").paste("*"),
    },
  }
end
