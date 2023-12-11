return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "verible", "typst-lsp", "rust-analyzer" })
      end
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        typst_lsp = {
          root_dir = require("lspconfig.util").root_pattern("*.typ"),
        },
      },
    },
  },
  -- {
  --   "nvimtools/none-ls.nvim",
  --   opts = function(_, opts)
  --     local nls = require("null-ls")
  --     table.insert(opts.sources, nls.builtins.formatting.verible_verilog_format)
  --     table.insert(opts.sources, nls.builtins.diagnostics.verilator)
  --   end,
  --   -- opts = function()
  --   --   local nls = require("null-ls")
  --   --   return {
  --   --     root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git"),
  --   --     sources = {
  --   --       nls.builtins.formatting.stylua,
  --   --       nls.builtins.formatting.shfmt,
  --   --       nls.builtins.formatting.prettier,
  --   --       nls.builtins.formatting.clang_format,
  --   --       -- nls.builtins.diagnostics.flake8,
  --   --
  --   --       -- verilog
  --   --       nls.builtins.formatting.verible_verilog_format,
  --   --       nls.builtins.diagnostics.verilator,
  --   --     },
  --   --   }
  --   -- end,
  -- },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        fish = { "fish_indent" },
        sh = { "shfmt" },
      },
      -- LazyVim will merge the options you set here with builtin formatters.
      -- You can also define any custom formatters here.
      ---@type table<string,table>
      formatters = {
        injected = { options = { ignore_errors = true } },
        -- -- Example of using dprint only when a dprint.json file is present
        -- dprint = {
        --   condition = function(ctx)
        --     return vim.fs.find({ "dprint.json" }, { path = ctx.filename, upward = true })[1]
        --   end,
        -- },
      },
    },
  },
}
