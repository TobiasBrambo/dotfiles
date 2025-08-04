local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "black" },
    -- css = { "prettier" },
    -- html = { "prettier" },
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 1000,
    lsp_fallback = true,
  },

  -- formatters = {
  --   flake8 = {
  --     command = "flake8",
  --     args = { "--stdin-display-name", "$FILENAME", "-" },
  --     stdin = true,
  --     exit_codes = { 0, 1 }, -- 1 = warnings
  --   },
  -- },
}

return options
