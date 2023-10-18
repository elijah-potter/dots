local lspconfig = require 'lspconfig'
local typescript = require 'typescript'

local M = {}

function M.setup(options)
  typescript.setup({})

  local eslint_on_attach = function(client, bufnr)
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

  vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = { "*.tsx", "*.ts", "*.jsx", "*.js" },
    command = "EslintFixAll"
  })
end

return M;
