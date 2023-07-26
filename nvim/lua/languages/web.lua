local lspconfig = require 'lspconfig'
local typescript_tools = require 'typescript-tools'

local M = {}

function M.setup(options)
  local eslint_on_attach = function (client, bufnr)
    options.on_attach();
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      command = "EslintFixAll",
    })
  end

  lspconfig.eslint.setup({
    on_attach = eslint_on_attach,
    capabilities = options.capabilities,
    settings = {
      packageManager = "yarn",
    }
  })

  typescript_tools.setup({
      on_attach = options.on_attach,
      capabilities = options.capabilities,
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

  lspconfig.svelte.setup{
    on_attach = options.on_attach,
    capabilities = options.capabilities,
  }

  lspconfig.tailwindcss.setup{
    on_attach = options.on_attach,
    capabilities = options.capabilities,
  }

  vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = {"*.tsx", "*.ts", "*.jsx", "*.js"},
    command = "EslintFixAll"
  })
end

return M;
