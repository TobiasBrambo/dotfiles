return {

  {
    "NvChad/base46",
    branch = "v2.5",
    build = function()
      require("base46").load_all_highlights()
    end,
  },

  {
    nvchad = "NvChad/nvim",
    "NvChad/ui",
    branch = "v2.5",
    lazy = false,
    config = function()
      require "nvchad"
    end,
  },

  {
    "nvim-tree/nvim-web-devicons",
    opts = function()
      return { override = require "nvchad.icons.devicons" }
    end,
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "devicons")
      require("nvim-web-devicons").setup(opts)
    end,
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    event = "User FilePost",
    opts = {
      indent = { char = "│", highlight = "IblChar" },
      scope = { char = "│", highlight = "IblScopeChar" },
    },
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "blankline")

      local hooks = require "ibl.hooks"
      hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
      require("ibl").setup(opts)

      dofile(vim.g.base46_cache .. "blankline")
    end,
  },

  -- file managing , picker etc
  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    opts = function()
      return require "nvchad.configs.nvimtree"
    end,
    config = function(_, opts)
      require("nvim-tree").setup(opts)
    end,
  },

  {
    "folke/which-key.nvim",
    keys = { "<leader>", "<c-r>", "<c-w>", '"', "'", "`", "c", "v", "g" },
    cmd = "WhichKey",
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "whichkey")
      require("which-key").setup(opts)
    end,
  },

  "nvim-lua/plenary.nvim",

  -- formatting!
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
      },
    },
    config = function(_, opts)
      require("conform").setup(opts)
    end,
  },

  -- git stuff
  {
    "lewis6991/gitsigns.nvim",
    event = "User FilePost",
    opts = function()
      return require "nvchad.configs.gitsigns"
    end,
    config = function(_, opts)
      require("gitsigns").setup(opts)
    end,
  },

  -- lsp stuff
  {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUpdate" },
    opts = function()
      return require "nvchad.configs.mason"
    end,
    config = function(_, opts)
      require("mason").setup(opts)

      -- custom nvchad cmd to install all mason binaries listed
      vim.api.nvim_create_user_command("MasonInstallAll", function()
        if opts.ensure_installed and #opts.ensure_installed > 0 then
          vim.cmd "Mason"
          local mr = require "mason-registry"

          mr.refresh(function()
            for _, tool in ipairs(opts.ensure_installed) do
              local p = mr.get_package(tool)
              if not p:is_installed() then
                p:install()
              end
            end
          end)
        end
      end, {})

      vim.g.mason_binaries_list = opts.ensure_installed
    end,
  },

  {
    "neovim/nvim-lspconfig",
    event = "User FilePost",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
    end,
  },

  -- load luasnips + cmp related in insert mode only
 {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    {
      "L3MON4D3/LuaSnip",
      dependencies = "rafamadriz/friendly-snippets",
      opts = { history = true, updateevents = "TextChanged,TextChangedI" },
      config = function(_, opts)
        require("luasnip").config.set_config(opts)
        require "nvchad.configs.luasnip"
      end,
    },
    -- autopairing of (){}[] etc
    {
      "windwp/nvim-autopairs",
      opts = {
        fast_wrap = {},
        disable_filetype = { "TelescopePrompt", "vim" },
      },
      config = function(_, opts)
        require("nvim-autopairs").setup(opts)
        local cmp_autopairs = require "nvim-autopairs.completion.cmp"
        require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
      end,
    },
    -- cmp sources
    "saadparwaiz1/cmp_luasnip",
    "hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
  },
  opts = function()
    local cmp = require "cmp"
    
    local has_words_before = function()
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
    end

    local copilot_suggestion_visible = function()
      return vim.fn['copilot#GetDisplayedSuggestion']() ~= ''
    end

    return {
      mapping = {
        -- Tab: Handle both Copilot and nvim-cmp
        ["<Tab>"] = cmp.mapping(function(fallback)
          if copilot_suggestion_visible() then
            -- Accept Copilot suggestion
            vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<C-R>=copilot#Accept()<CR>", true, true, true), "")
          elseif cmp.visible() and cmp.get_selected_entry() then
            -- If cmp menu is visible and an item is selected, confirm the selection
            cmp.confirm({ select = true })
          else
            -- Fallback to default behavior if no completion is available
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, true, true), "n", true)
          end
        end, {"i", "s"}), -- Insert and Select modes

        -- Use Ctrl-n and Ctrl-p to cycle through cmp items
        ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
        ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),

        -- Enter: Confirm the current selection
        ["<CR>"] = cmp.mapping.confirm({ select = true }),

        -- Esc: Close cmp menu
        ["<Esc>"] = cmp.mapping.close(),

        -- Other bindings can be added here as needed
      },
      -- Other nvim-cmp options
      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'buffer' },
      }),
    }
  end,
  config = function(_, opts)
    require("cmp").setup(opts)
  end,
},

  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    cmd = "Telescope",
    opts = function()
      return require "nvchad.configs.telescope"
    end,
    config = function(_, opts)
      local telescope = require "telescope"
      telescope.setup(opts)
      telescope.load_extension("remote-sshfs")
      -- load extensions
      for _, ext in ipairs(opts.extensions_list) do
        telescope.load_extension(ext)
      end
    end,
    lazy=false,
  },

  {
    "NvChad/nvim-colorizer.lua",
    event = "User FilePost",
    opts = { user_default_options = { names = false } },
    config = function(_, opts)
      require("colorizer").setup(opts)

      -- execute colorizer as soon as possible
      vim.defer_fn(function()
        require("colorizer").attach_to_buffer(0)
      end, 0)
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    build = ":TSUpdate",
    opts = function()
      return require "nvchad.configs.treesitter"
    end,
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
  {
    "github/copilot.vim",
    lazy = false
  },
  {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    config = function()
      require('dashboard').setup {
        change_to_vcs_root = true,
        shortcut_type = 'number',
      }
    end,
    dependencies = { {'nvim-tree/nvim-web-devicons'}}
  },
  {
   "nosduco/remote-sshfs.nvim",
   dependencies = { "nvim-telescope/telescope.nvim" },
   opts = {
    -- Refer to the configuration section below
    -- or leave empty for defaults
   },
  }
}
