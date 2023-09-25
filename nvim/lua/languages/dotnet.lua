local lspconfig = require 'lspconfig'

local M = {}

function M.setup(options)
  lspconfig.omnisharp.setup {
    server = {
      on_attach = function(client, bufnr)
        options.on_attach(client, bufnr)
      end,
      capabilities = options.capabilities
    },
  }
end

return M;
