local default_cli = "codex"

local function with_tool(extra)
  return vim.tbl_deep_extend("force", { name = default_cli }, extra or {})
end

local function key_opts(text, extra)
  return vim.tbl_extend("force", { desc = ("Sidekick: %s"):format(text), silent = true }, extra or {})
end

local opts = {
  cli = {
    picker = "telescope",
    tools = {
      codex = {
        -- cmd must be a string[] (array). First element is the executable.
        cmd = { "codex", "-s", "danger-full-access" },
      },
    },
  },
}

local M = {}

function M.setup()
  local sidekick = require "sidekick"
  sidekick.setup(opts)

  local cli = require "sidekick.cli"
  local map = vim.keymap.set

  map({ "n", "t", "i", "x" }, "<C-_>", function()
    cli.toggle(with_tool { focus = true })
  end, key_opts "toggle codex terminal")

  map("n", "<leader>sk", function()
    cli.toggle(with_tool { focus = true })
  end, key_opts "toggle codex terminal")

  map("n", "<leader>ss", function()
    cli.select { focus = true }
  end, key_opts "select CLI tool")

  map({ "n", "x" }, "<leader>sp", function()
    cli.prompt(with_tool())
  end, key_opts "prompt (codex)")

  map("n", "<leader>sf", function()
    cli.send(with_tool { msg = "{file}" })
  end, key_opts "send file to codex")

  map("x", "<leader>sv", function()
    cli.send(with_tool { msg = "{selection}" })
  end, key_opts "send selection to codex")

  map("n", "<leader>sd", function()
    cli.close(with_tool())
  end, key_opts "detach codex session")
end

return M
