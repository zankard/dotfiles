return {
  {
    "zbirenbaum/copilot.lua",
    opts = {
      copilot_model = "gpt-41-copilot",
      filetypes = {
        ["rust"] = true,
        ["go"] = true,
        ["python"] = true,
        ["typescript"] = true,
        ["javascript"] = true,
        ["lua"] = true,
        ["markdown"] = true,
        ["*"] = false,
      },
    },
  },
  {
    "folke/sidekick.nvim",
    opts = {
      debug = false,
      cli = {
        tools = {
          copilot = {
            cmd = { "copilot", "--banner", "--disable-mcp-server", "github-mcp-server" },
          },
        },
        context = {
          quickfix_errors = function(ctx)
            local Loc = require("sidekick.cli.context.location")
            local info = vim.fn.getqflist({ items = 0, title = 0 })
            local items = info.items or {}
            if vim.tbl_isempty(items) then
              return
            end

            local cwd = ctx and ctx.cwd or vim.fs.normalize(vim.fn.getcwd())
            local ret = {}

            -- Filter and format only error items
            for _, item in ipairs(items) do
              local qtype = item.type and item.type ~= "" and item.type:upper() or nil
              -- Only include errors (type 'E' or no type which often indicates errors)
              if qtype == "E" or not qtype then
                local bufnr = item.bufnr and item.bufnr > 0 and vim.api.nvim_buf_is_valid(item.bufnr) and item.bufnr
                  or nil
                local name = item.filename
                if (not name or name == "") and bufnr then
                  name = vim.api.nvim_buf_get_name(bufnr)
                end

                if name and name ~= "" then
                  name = vim.fs.normalize(name)
                end

                local loc_ctx = {
                  buf = bufnr,
                  name = name,
                  cwd = cwd,
                }

                local lnum = item.lnum or 0
                local col = item.col or 0

                if lnum > 0 then
                  loc_ctx.row = lnum
                  loc_ctx.col = col > 0 and col or nil
                end

                local loc = Loc.get(loc_ctx, { kind = "position" })
                local vt = loc and vim.deepcopy(loc[1]) or { { "@", "Bold" }, { "[No Name]", "SnacksPickerDir" } }
                table.insert(vt, 1, { "- ", "@markup.list.markdown" })

                if qtype then
                  vt[#vt + 1] = { " " }
                  vt[#vt + 1] = { ("[%s]"):format(qtype), "DiagnosticVirtualTextError" }
                end

                local message = item.text or ""
                message = message:gsub("%s+$", "")
                if message ~= "" then
                  vt[#vt + 1] = { " " .. message }
                end

                ret[#ret + 1] = vt
              end
            end

            return #ret > 0 and ret or nil
          end,
        },
        prompts = {
          diag_all_errors = "Filter out errors from diagnostics output and help me fix.\n\n{diagnostics}\n\n",
          git_commit = "Generate a descriptive git commit message and then commit.",
          quickfix_e = "Help me fix the following errors.\n\n{quickfix_errors}\n\n",
        },
      },
      mux = {
        enable = false,
      },
    },
  },
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      -- NOTE: The log_level is in `opts.opts`
      opts = {
        log_level = "DEBUG", -- or "TRACE"
      },
      interactions = {
        chat = {
          adapter = {
            name = "claude_code",
          },
        },
      },
    },
  },
}
