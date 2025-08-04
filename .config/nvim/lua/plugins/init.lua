return {
  {
    "stevearc/conform.nvim",
    event = 'BufWritePre', -- uncomment for format on save
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
  },
  {
    "kiyoon/jupynium.nvim",
    lazy=false,
    -- build = "pip3 install --user .",
    build = "conda run --no-capture-output -n jupynium pip install .",
    -- enabled = vim.fn.isdirectory(vim.fn.expand "~/miniconda3/envs/jupynium"),
    config = function ()
      require("jupynium").setup({
        --- For Conda environment named "jupynium",
  -- python_host = { "conda", "run", "--no-capture-output", "-n", "jupynium", "python" },
  python_host = vim.g.python3_host_prog or "python3",

  default_notebook_URL = "localhost:8888/nbclassic",

  -- Write jupyter command but without "notebook"
  -- When you call :JupyniumStartAndAttachToServer and no notebook is open,
  -- then Jupynium will open the server for you using this command. (only when notebook_URL is localhost)
  jupyter_command = "jupyter",
  --- For Conda, maybe use base environment
  --- then you can `conda install -n base nb_conda_kernels` to switch environment in Jupyter Notebook
  -- jupyter_command = { "conda", "run", "--no-capture-output", "-n", "base", "jupyter" },

  -- Used when notebook is launched by using jupyter_command.
  -- If nil or "", it will open at the git directory of the current buffer,
  -- but still navigate to the directory of the current buffer. (e.g. localhost:8888/nbclassic/tree/path/to/buffer)
  notebook_dir = nil,

  -- Used to remember the last session (password etc.).
  -- e.g. '~/.mozilla/firefox/profiles.ini'
  -- or '~/snap/firefox/common/.mozilla/firefox/profiles.ini'
  firefox_profiles_ini_path = nil,
  -- nil means the profile with Default=1
  -- or set to something like 'default-release'
  firefox_profile_name = nil,

  -- Open the Jupynium server if it is not already running
  -- which means that it will open the Selenium browser when you open this file.
  -- Related command :JupyniumStartAndAttachToServer
  auto_start_server = {
    enable = false,
    file_pattern = { "*.ju.*" },
  },

  -- Attach current nvim to the Jupynium server
  -- Without this step, you can't use :JupyniumStartSync
  -- Related command :JupyniumAttachToServer
  auto_attach_to_server = {
    enable = true,
    file_pattern = { "*.ju.*", "*.md" },
  },

  -- Automatically open an Untitled.ipynb file on Notebook
  -- when you open a .ju.py file on nvim.
  -- Related command :JupyniumStartSync
  auto_start_sync = {
    enable = false,
    file_pattern = { "*.ju.*", "*.md" },
  },

  -- Automatically keep filename.ipynb copy of filename.ju.py
  -- by downloading from the Jupyter Notebook server.
  -- WARNING: this will overwrite the file without asking
  -- Related command :JupyniumDownloadIpynb
  auto_download_ipynb = false,

  -- Automatically close tab that is in sync when you close buffer in vim.
  auto_close_tab = true,

  -- Always scroll to the current cell.
  -- Related command :JupyniumScrollToCell
  autoscroll = {
    enable = true,
    mode = "always", -- "always" or "invisible"
    cell = {
      top_margin_percent = 20,
    },
  },

  scroll = {
    page = { step = 0.5 },
    cell = {
      top_margin_percent = 20,
    },
  },

  -- Files to be detected as a jupynium file.
  -- Add highlighting, keybindings, commands (e.g. :JupyniumStartAndAttachToServer)
  -- Modify this if you already have lots of files in Jupytext format, for example.
  jupynium_file_pattern = { "*.ju.*" },

  use_default_keybindings = true,
  textobjects = {
    use_default_keybindings = true,
  },

  syntax_highlight = {
    enable = true,
  },

  -- Dim all cells except the current one
  -- Related command :JupyniumShortsightedToggle
  shortsighted = false,

  -- Configure floating window options
  -- Related command :JupyniumKernelHover
  kernel_hover = {
    floating_win_opts = {
      max_width = 84,
      border = "none",
    },
  },

  notify = {
    ignore = {
      -- "download_ipynb",
      -- "error_download_ipynb",
      -- "attach_and_init",
      -- "error_close_main_page",
      -- "notebook_closed",
    },
  },
      })
    end
  },
  "rcarriga/nvim-notify",   -- optional
  "stevearc/dressing.nvim", -- optional, UI for :JupyniumKernelSelect
  {
    "aserowy/tmux.nvim",

    config = function ()
      return require("tmux").setup({
          copy_sync = {
          enable=true
        },
      })
    end
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
        require("nvim-surround").setup({
            -- Configuration here, or leave empty to use defaults
        })
    end
  },
  {
    "mfussenegger/nvim-dap",
    config = function()
      vim.keymap.set('n', '<F5>', function()
        require('dap.ext.vscode').load_launchjs() -- Load launch.json every time we debug
        require('dap').continue() end)
      vim.keymap.set('n', '<F6>', function() require('dap').step_into() end)
      vim.keymap.set('n', '<F7>', function() require('dap').step_over() end)
      vim.keymap.set('n', '<F8>', function() require('dap').step_out() end)
      vim.keymap.set('n', '<leader>dG', function() require('dap').run_to_cursor() end)
    end,
    lazy = false,
  },

  -- Have persistent breakpoints
  {
    'Weissle/persistent-breakpoints.nvim',
    dependencies = {
      'mfussenegger/nvim-dap',
    },
    config = function()
      vim.keymap.set('n', '<leader>db', function() require("persistent-breakpoints.api").toggle_breakpoint() end)
      vim.keymap.set('n', '<leader>dc',
        function() require('persistent-breakpoints.api').set_conditional_breakpoint() end)
      vim.keymap.set('n', '<leader>du', function() require('persistent-breakpoints.api').clear_all_breakpoints() end)
      require('persistent-breakpoints').setup{
        load_breakpoints_event = { "BufReadPost" }
      }
    end,
    lazy = false,
  },

  {
    'rcarriga/nvim-dap-ui',
    dependencies = {
      'mfussenegger/nvim-dap',
    },
    config = function()
      local dap = require('dap')
      local dapui = require('dapui')
      dapui.setup({
        layouts = {{
          elements = { {
              id = "scopes",
              size = 0.55
            }, {
              id = "breakpoints",
              size = 0.15
            }, {
              id = "stacks",
              size = 0.15
            }, {
              id = "watches",
              size = 0.15
            } },
          position = "left",
          size = 50
        }, {
          elements = { {
              id = "repl",
              size = 0.3
            }, {
              id = "console",
              size = 0.7
            } },
          position = "bottom",
          size = 10
        }},
      })

      dap.listeners.after.event_initialized['dapui_config'] = function()
        dapui.open()
      end

      -- Uncomment for dap-ui GUI to close automatically after finishing a debugging session
      dap.listeners.before.event_terminated['dapui_config'] = function()
        dapui.close()
      end

      dap.listeners.before.event_exited['dapui_config'] = function()
        dapui.close()
      end
    end
  },

  {
    "mfussenegger/nvim-dap-python",
    dependencies = {
      'mfussenegger/nvim-dap',
      'rcarriga/nvim-dap-ui',
    },
    config = function()
      require("dap-python").setup()
      vim.keymap.set('n', '<F4>', function() require('dap-python').debug_selection() end)
    end,
    lazy = false,
  },
  { "nvim-neotest/nvim-nio" },


  -- {
  --   "averms/black-nvim",
  --   lazy = false,
  --   ft = "python",
  --   config = function()
  --     vim.api.nvim_create_autocmd("BufWritePre", {
  --       pattern = "*.py",
  --       callback = function()
  --         require("black").format()
  --       end,
  --     })
  --   end
  -- },
  -- {
  --   -- Flake8 (linter)
  --   "mfussenegger/nvim-lint",
  --   event = { "BufWritePost", "BufReadPost" },
  --   config = function()
  --     require("lint").linters_by_ft = {
  --       python = { "flake8" },
  --     }
  --     vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost" }, {
  --       pattern = "*.py",
  --       callback = function()
  --         require("lint").try_lint()
  --       end,
  --     })
  --   end
  -- }
}
