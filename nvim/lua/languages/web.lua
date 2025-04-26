local lspconfig = require 'lspconfig'
local typescript_tools = require 'typescript-tools'

local M = {}

function M.setup(options)
  typescript_tools.setup({
    on_attach = options.on_attach
  })

  lspconfig.biome.setup {}

  -- vim.api.nvim_create_autocmd("BufWritePre", {
  --   pattern = { "*.tsx", "*.ts", "*.jsx", "*.js", "*.svelte" },
  --   command = "EslintFixAll"
  -- })
end

return M;
