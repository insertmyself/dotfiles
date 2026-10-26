return {
  {
    "mason-org/mason.nvim",
    config = function()
      require("mason").setup({
        ui = {
          border = "single",
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      })
    end,
  },
  {
    "stevearc/conform.nvim",
    lazy = true,
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          lua = { "stylua" },
          html = { "prettier" },
          css = { "prettier" },
          ruby = { "rubocop" },
          javascript = { "prettier" },
          yaml = { "prettier" },
          c = { "clang-format" },
          cpp = { "clang-format" },
          cs = { "clang-format" },
          python = { "black" },
          rust = { "rustfmt" },
        },
        format_on_save = function(bufnr)
          if vim.bo[bufnr].filetype == "arduino" then
            return nil
          end
          return { timeout_ms = 500, lsp_format = "fallback" }
        end,
        notify_on_error = true,
      })

      vim.keymap.set("n", "<leader>fm", function()
        require("conform").format()
      end, { silent = true, desc = "Format current document" })
    end,
  },
  {
    "mason-org/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "clangd",
          "eslint",
          "cssls",
          "emmet_language_server",
          "tailwindcss",
          "pylsp",
          "rust_analyzer",
          "html",
          "gopls",
          "ts_ls",
        },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "saghen/blink.cmp",
    },
    config = function()
      local arduino_caps = vim.lsp.protocol.make_client_capabilities()
      arduino_caps.textDocument.completion.completionItem.insertReplaceSupport = false
      arduino_caps.workspace = arduino_caps.workspace or {}
      arduino_caps.workspace.semanticTokens = nil
      arduino_caps.textDocument.semanticTokens = nil

      vim.lsp.enable("lua_ls")
      vim.lsp.enable("ols")
      vim.lsp.enable("eslint")
      vim.lsp.enable("ts_ls")
      vim.lsp.enable("cssls")
      vim.lsp.config["emmet_language_server"] = {
        filetypes = { "html", "css", "php", "blade", "jsx", "javascript", "typescript" },
        init_options = {
          html = {
            options = {
              ["bem.enabled"] = true,
            },
          },
        },
      }
      vim.lsp.enable("emmet_language_server")
      vim.lsp.config["html"] = {
        filetypes = { "html", "php", "blade", "htm" },
        init_options = {
          configurationSection = { "html", "css", "typescript", "javascript", "tsx" },
          embeddedLanguages = {
            css = true,
            javascript = true,
          },
          provideFormatter = true,
        },
      }

      vim.lsp.config["arduino_language_server"] = {
        filetypes = { "arduino" },
        capabilities = arduino_caps,
        cmd = {
          "arduino-language-server",
          "-cli", "arduino-cli",
          "-cli-config", vim.fn.expand("$HOME/.arduino15/arduino-cli.yaml"),
          "-fqbn", "esp32:esp32:esp32",
          "-clangd", vim.fn.stdpath("data") .. "/mason/bin/clangd",
        }
      }
      vim.lsp.enable("arduino_language_server")
      vim.lsp.enable("arduino_language_server")
      vim.lsp.enable("html")
      vim.lsp.enable("clangd")
      vim.lsp.enable("jdtls")
      vim.lsp.enable("gradle_ls")
      vim.lsp.enable("lemminx")
      vim.lsp.enable("jsonls")
      vim.lsp.enable("pylsp")
      vim.lsp.enable("rust_analyzer")
      vim.lsp.config["qmlls"] = {
        cmd = { "qmlls6" },
        filetypes = { "qml" },
      }
      vim.lsp.enable("qmlls")
      vim.lsp.enable("gopls")
      vim.lsp.enable("tailwindcss")

      vim.keymap.set(
        { "n", "v" },
        "<leader>ca",
        vim.lsp.buf.code_action,
        { silent = true, desc = "Show code action from configured LSP" }
      )

      vim.api.nvim_create_user_command("LspRestart", function()
        local clients = vim.lsp.get_clients({ bufnr = 0 })
        for _, client in ipairs(clients) do
          vim.lsp.stop_client(client.id, true)
        end
        vim.defer_fn(function()
          vim.cmd("edit")
        end, 500)
      end, {})
    end,
  },
}
