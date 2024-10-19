return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  {
    "nvimtools/none-ls.nvim",
    ft = {"python"},
    config = function()
      require("null-ls").setup()
    end,
    requires = {"nvim-lua/plenary.nvim"}
  },
  {
    'alexghergh/nvim-tmux-navigation',
    lazy=false,
    config = function()
    require'nvim-tmux-navigation'.setup {
        disable_when_zoomed = true, -- defaults to false
        keybindings = {
            left = "<C-h>",
            down = "<C-j>",
            up = "<C-k>",
            right = "<C-l>",
            last_active = "<C-\\>",
            next = "<C-Space>",
        }
    }
  end
  }

}
