local lspconfig = require 'lspconfig'

local M = {}

function M.setup(options)
  lspconfig.pyright.setup({
    on_attach = options.on_attach,
    capabilities = options.capabilities,
    settings = {
      
    },
  })
end

return M;
