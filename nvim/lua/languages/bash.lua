local lspconfig = require 'lspconfig'

local M = {}

function M.setup(options)
  lspconfig.bashls.setup{
    on_attach = options.on_attach,
    capabilities = options.capabilities,
  }
end

return M;
