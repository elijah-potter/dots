local lspconfig = require 'lspconfig'
local crates = require 'crates'
crates.setup({})

local M = {}

function M.setup(options)
  vim.g.rustaceanvim = {
    server = {
      on_attach = options.on_attach,
      capabilities = options.capabilities,
    },
  }
end

return M;
