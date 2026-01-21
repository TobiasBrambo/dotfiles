-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local nvlsp = require "nvchad.configs.lspconfig"

local function on_attach(client, bufnr)
  if client.name == "ts_ls" then
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end
end

local servers = { "html", "cssls", "ts_ls", "eslint" }

for _, server in ipairs(servers) do
  vim.lsp.config(server, {
    on_attach = on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  })
  vim.lsp.enable(server)
end

vim.lsp.config("pyright", {
  on_attach = on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  filetypes = { "python" },
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "off",
      },
    },
  },
})
vim.lsp.enable "pyright"

-- Keep Copilot's defaults (sign-in commands, etc.) while layering NvChad capabilities.
local copilot_defaults = vim.tbl_deep_extend("force", {}, vim.lsp.config["copilot"] or {})

vim.lsp.config("copilot", vim.tbl_deep_extend("force", copilot_defaults, {
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  on_attach = function(client, bufnr)
    if copilot_defaults.on_attach then
      copilot_defaults.on_attach(client, bufnr)
    end
  end,
}))
vim.lsp.enable "copilot"
