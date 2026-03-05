return {
  {
    "j-hui/fidget.nvim",
    opts = {
      -- options
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      --      local components = require("plugins.lualine.components.codecompanion")
      --      -- Add the component to the lualine_x section
      --      if not opts.sections.lualine_x then
      --        opts.sections.lualine_x = {}
      --      end
      --      table.insert(opts.sections.lualine_x, 1, components)
    end,
  },
  {
    "folke/noice.nvim",
    opts = {
      presets = {
        long_message_to_split = true,
        lsp_doc_border = true,
      },
    },
  },
}
