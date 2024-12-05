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
    "echasnovski/mini.surround",
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

  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "rafamadriz/friendly-snippets",
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load({
          -- exclude = { "verilog" },
        })
      end,
    },
    keys = {
      {
        "<leader>L",
        '<cmd>lua require("luasnip.loaders.from_lua").load({paths = "~/.config/nvim/LuaSnip/"})<cr>',
        desc = "Refresh snippets",
      },
    },
    opts = {
      -- Enable autotriggered snippets
      enable_autosnippets = true,
      -- Use <Tab> (or some other key if you prefer) to trigger visual selection
      store_selection_keys = "<Tab>",
    },
    config = function(_, opts)
      -- Load snippets from ~/.config/nvim/LuaSnip/
      require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/LuaSnip/" })
      require("luasnip").config.set_config(opts)
    end,
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
    -- If nothing happens on MarkdownPreview, see the issue
    -- https://github.com/iamcco/markdown-preview.nvim/issues/188#issuecomment-629038471
    "iamcco/markdown-preview.nvim",
    ft = "markdown",
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    config = function()
      vim.cmd([[
        function OpenMarkdownPreview (url)
          execute "silent ! google-chrome-stable --new-window " . a:url
        endfunction
        let g:mkdp_browserfunc = 'OpenMarkdownPreview'
        let g:mkdp_theme = 'light'
      ]])
    end,
  },

  {
    "kaarmu/typst.vim",
    ft = "typst",
  },

  {
    "hotoo/pangu.vim",
    ft = { "typst", "markdown" },
  },

  {
    "kawre/leetcode.nvim",
    build = ":TSUpdate html",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim", -- telescope 所需
      "MunifTanjim/nui.nvim",

      -- 可选
      "nvim-treesitter/nvim-treesitter",
      "rcarriga/nvim-notify",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      -- 配置放在这里
      lang = "cpp",
      cn = {
        enabled = true,
      },
    },
  },

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
}
