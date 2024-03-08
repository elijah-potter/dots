local lspconfig = require 'lspconfig'
local utils = require 'utils'

local M = {}

function M.setup(options)
  lspconfig.harper_ls.setup {
    server = {
      on_attach = function(client, bufnr)
        options.on_attach(client, bufnr)
      end,
      capabilities = options.capabilities
    },
    settings = {
    },
  }
end

return M;
