local lspconfig = require 'lspconfig'

local M = {}

function M.setup(options)
  lspconfig.rust_analyzer.setup({
    on_attach = options.on_attach,
    capabilities = options.capabilities,
    settings = {
      checkOnSave = {
        command = 'clippy',
      },
    },
  })
end

return M;
