local lspconfig = require 'lspconfig'
local typescript = require 'typescript'

local M = {}

function M.setup(options)
  lspconfig.eslint.setup({
    on_attach = options.on_attach,
    capabilities = options.capabilities,
    settings = {
      codeAction = {
        showDocumentation = {
          enable = true
        }
      },
      packageManager = "yarn",
    }
  })

  typescript.setup({
    debug = false,
    disable_commands = false,
    go_to_source_definition = {
        fallback = true,
    },
    server = {
      on_attach = options.on_attach,
      capabilities = options.capabilities,
      settings = {}
    }
  })

  lspconfig.cssls.setup({
    on_attach = options.on_attach,
    capabilities = options.capabilities,
  })

  lspconfig.html.setup({
    on_attach = options.on_attach,
    capabilities = options.capabilities,
  })

  lspconfig.jsonls.setup{
    on_attach = options.on_attach,
    capabilities = options.capabilities,
  }

  vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = {"*.tsx", "*.ts", "*.jsx", "*.js"},
    command = "EslintFixAll"
  })
end

return M;
