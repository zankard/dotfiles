return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        python = { "isort", "black" },
        rust = { "rustfmt", lsp_format = "fallback" },
        json = { "prettierd", "prettier", stop_after_first = true },
        toml = { "taplo" },
      },
    },
  },
}
