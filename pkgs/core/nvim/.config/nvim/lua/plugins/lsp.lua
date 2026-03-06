return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "folke/lazydev.nvim",
    },
    config = function()
      require("lazydev").setup()
      vim.diagnostic.config({
        update_in_insert = false,
        severity_sort = true,
        float = { border = "rounded", source = "if_many" },
        underline = { severity = vim.diagnostic.severity.ERROR },

        virtual_text = true,
        virtual_lines = false,

        jump = { float = true },
      })

      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls" },
      })
      if vim.lsp.config then
        vim.lsp.config("*", {
          root_descendants = { ".git" },
        })
        vim.lsp.config("lua_ls", {
          settings = {
            Lua = {
              diagnostics = {
                globals = { "vim" },
              },
            },
          },
        })
        vim.lsp.enable("lua_ls")
      else
        require("lspconfig").lua_ls.setup({})
      end
    end,
  },
}
