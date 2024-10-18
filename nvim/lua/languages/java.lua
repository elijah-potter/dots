local java = require 'java'
local lspconfig = require 'lspconfig'

local M = {}

function M.setup(options)
  java.setup()
  lspconfig.jdtls.setup {
    on_attach = function(client, bufnr)
      options.on_attach(client, bufnr)
    end,
    capabilities = options.capabilities
  }

end

return M;
