local lspconfig = require 'lspconfig'

local M = {}

function M.setup(options)
  lspconfig.powershell_es.setup{
    bundle_path = vim.fn.stdpath "data" .. "/mason/packages/powershell-editor-services",
    capabilities = options.capabilities,
    on_attach = options.on_attach
  }
end

return M;
