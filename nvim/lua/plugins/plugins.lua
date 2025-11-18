return {
  --------------------------------------------------------------------------------
  -- Disable origin plugins
  --------------------------------------------------------------------------------
  -- {
  --   "echasnovski/mini.pairs",
  --   enabled = false,
  -- },

  --------------------------------------------------------------------------------
  -- Change origin plugins
  --------------------------------------------------------------------------------
  {
    "nvim-mini/mini.surround",
    opts = {
      custom_surroundings = {
        ["("] = { output = { left = "(", right = ")" } },
        ["["] = { output = { left = "[", right = "]" } },
        ["{"] = { output = { left = "{", right = "}" } },
        ["<"] = { output = { left = "<", right = ">" } },
      },
    },
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      window = {
        mappings = {
          ["h"] = "close_node",
          ["l"] = "open",
          ["L"] = "focus_preview",
        },
      },
    },
  },

  --------------------------------------------------------------------------------
  -- Add new plugins
  --------------------------------------------------------------------------------
  {
    "aserowy/tmux.nvim",
    lazy = true,
    opts = {
      copy_sync = {
        -- overwrites vim.g.clipboard to redirect * and + to the system
        -- clipboard using tmux. If you sync your system clipboard without tmux,
        -- disable this option!
        sync_clipboard = false,
      },
      resize = {
        -- enables default keybindings (A-hjkl) for normal mode
        enable_default_keybindings = true,
      },
    },
  },

  {
    "vhda/verilog_systemverilog.vim",
    ft = { "verilog", "verilog_systemverilog" },
  },

  {
    "lervag/vimtex",
    ft = "tex",
  },

  {
    "lilydjwg/fcitx.vim",
    lazy = true,
  },

  {
    "kaarmu/typst.vim",
    ft = "typst",
  },

  {
    "hotoo/pangu.vim",
    ft = { "typst", "markdown" },
  },

  -- {
  --   "kawre/leetcode.nvim",
  --   build = ":TSUpdate html",
  --   dependencies = {
  --     "nvim-telescope/telescope.nvim",
  --     "nvim-lua/plenary.nvim", -- telescope 所需
  --     "MunifTanjim/nui.nvim",
  --
  --     -- 可选
  --     "nvim-treesitter/nvim-treesitter",
  --     "nvim-tree/nvim-web-devicons",
  --   },
  --   opts = {
  --     -- 配置放在这里
  --     lang = "cpp",
  --     cn = {
  --       enabled = true,
  --     },
  --   },
  -- },

  ---@type LazySpec
  {
    "mikavilpas/yazi.nvim",
    event = "VeryLazy",
    keys = {
      -- 👇 in this section, choose your own keymappings!
      {
        "<leader>fy",
        "<cmd>Yazi<cr>",
        desc = "Open yazi at the current file",
      },
      {
        -- Open in the current working directory
        "<leader>fY",
        "<cmd>Yazi cwd<cr>",
        desc = "Open yazi in nvim's working directory",
      },
      {
        -- NOTE: this requires a version of yazi that includes
        -- https://github.com/sxyazi/yazi/pull/1305 from 2024-07-18
        "<leader>f<C-y>",
        "<cmd>Yazi toggle<cr>",
        desc = "Resume the last yazi session",
      },
    },
    ---@type YaziConfig
    opts = {
      -- if you want to open yazi instead of netrw, see below for more info
      open_for_directories = false,
      keymaps = {
        show_help = "<f1>",
      },
    },
  },

  -- For auto switch Chinese input method in macOS
  {
    "keaising/im-select.nvim",
    config = function()
      require("im_select").setup({})
    end,
  },

  {
    "yetone/avante.nvim",
    opts = {
      provider = "ipads", -- You can then change this provider here
      providers = {
        ["ipads"] = {
          __inherited_from = "openai",
          endpoint = "http://ipads.chat.gpt:3006/v1", -- The full endpoint of the provider
          model = "gemini-2.5-pro", -- The model name to use with this provider
          api_key_name = "IPADS_API_KEY", -- The name of the environment variable that contains the API key
        },
      },
      selection = {
        hint_display = "none",
      },
      behaviour = {
        auto_set_keymaps = false,
      },
    },
  },

}
