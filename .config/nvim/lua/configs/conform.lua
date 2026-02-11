local util = require "conform.util"

local function has_ruff_config(ctx)
  local root = util.root_file { "pyproject.toml" }(ctx)
  if not root then
    return false
  end

  local pyproject = root .. "/pyproject.toml"
  local ok, lines = pcall(vim.fn.readfile, pyproject)
  if not ok then
    return false
  end

  for _, line in ipairs(lines) do
    if line:match "^%s*%[tool%.ruff%]" then
      return true
    end
  end

  return false
end

local function use_ruff_format(ctx)
  return vim.fn.executable "ruff" == 1 and has_ruff_config(ctx)
end

local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "ruff_format", "black" },
    javascript = { "eslint_d" },
    typescript = { "eslint_d" },
    javascriptreact = { "eslint_d" },
    typescriptreact = { "eslint_d" },
    json = { "prettierd", "prettier" },
    -- css = { "prettier" },
    -- html = { "prettier" },
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 3000,
    lsp_fallback = true,
  },

  formatters = {
    eslint_d = {
      cwd = util.root_file {
        ".eslintrc",
        ".eslintrc.js",
        ".eslintrc.cjs",
        ".eslintrc.json",
        ".eslintrc.yml",
        ".eslintrc.yaml",
        "eslint.config.js",
        "eslint.config.cjs",
        "eslint.config.mjs",
        "eslint.config.ts",
        "package.json",
      },
      condition = function(ctx)
        return ctx.cwd ~= nil
      end,
    },
    prettierd = {
      cwd = util.root_file {
        ".prettierrc",
        ".prettierrc.js",
        ".prettierrc.cjs",
        ".prettierrc.json",
        ".prettierrc.yml",
        ".prettierrc.yaml",
        "prettier.config.js",
        "prettier.config.cjs",
        "prettier.config.mjs",
        "package.json",
      },
      condition = function(ctx)
        return ctx.cwd ~= nil
      end,
    },
    prettier = {
      cwd = util.root_file {
        ".prettierrc",
        ".prettierrc.js",
        ".prettierrc.cjs",
        ".prettierrc.json",
        ".prettierrc.yml",
        ".prettierrc.yaml",
        "prettier.config.js",
        "prettier.config.cjs",
        "prettier.config.mjs",
        "package.json",
      },
      condition = function(ctx)
        return ctx.cwd ~= nil
      end,
    },
    ruff_format = {
      condition = function(ctx)
        return use_ruff_format(ctx)
      end,
    },
    black = {
      condition = function(ctx)
        return not use_ruff_format(ctx)
      end,
    },
  },
}

return options
