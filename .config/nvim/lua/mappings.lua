require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

map("n", "j", function()
  return vim.v.count > 0 and "j" or "gj"
end, { expr = true, desc = "Move down (handle wrapped lines)" })

map("n", "k", function()
  return vim.v.count > 0 and "k" or "gk"
end, { expr = true, desc = "Move up (handle wrapped lines)" })

-- show references
vim.keymap.set("n", "<leader>fu", function()
  require("telescope.builtin").lsp_references {
    include_declaration = true,
    jump_type = "never", -- avoid auto-jump on 1 result
  }
end, { noremap = true, silent = true })

-- manual formatting using conform
vim.keymap.set("n", "<leader>lf", function()
  require("conform").format { async = true, lsp_fallback = true }
end, { desc = "Format file with Conform" })

vim.opt.clipboard = "unnamedplus"

-- copy to clipboard
if vim.fn.has "wsl" == 1 then
  vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup("Yank", { clear = true }),
    callback = function()
      vim.fn.system("clip.exe", vim.fn.getreg '"')
    end,
  })
end
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
local unmap = vim.keymap.del

--- This fixes an issue with the vim-tmux-navigator + nvchad in which the base nvchad
--- mapping were conflicting with vim-tmux-navigator ones.
unmap("n", "<c-h>")
unmap("n", "<c-j>")
unmap("n", "<c-k>")
unmap("n", "<c-l>")
map("n", "<c-h>", "<cmd>:NvimTmuxNavigateLeft<cr>")
map("n", "<c-j>", "<cmd>:NvimTmuxNavigateDown<cr>")
map("n", "<c-k>", "<cmd>:NvimTmuxNavigateUp<cr>")
map("n", "<c-l>", "<cmd>:NvimTmuxNavigateRight<cr>")
