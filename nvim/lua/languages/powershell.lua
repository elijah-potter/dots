local lspconfig = require 'lspconfig'
local utils = require 'utils'

local M = {}

function M.setup(options)
  lspconfig.powershell_es.setup {
    server = {
      on_attach = function(client, bufnr)
        options.on_attach(client, bufnr)
      end,
      capabilities = options.capabilities
    },
  }
end

return M;
