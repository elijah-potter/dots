local lspconfig = require 'lspconfig'
local typescript_tools = require 'typescript-tools'

local M = {}

function M.setup(options)
  typescript_tools.setup({
    on_attach = options.on_attach
  })

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
    pattern = { "*.tsx", "*.ts", "*.jsx", "*.js", "*.svelte" },
    command = "EslintFixAll"
  })
end

return M;
