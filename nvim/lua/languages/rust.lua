local lspconfig = require 'lspconfig'

local M = {}

function M.setup(options)
  lspconfig.rust_analyzer.setup({
    on_attach = options.on_attach,
    capabilities = options.capabilities,
    settings = {
      ['rust-analyzer'] = {
        checkOnSave = {
          allFeatures = true,
          overrideCommand = {
              'cargo', 'clippy', '--workspace', '--message-format=json',
              '--all-targets', '--all-features'
          }
        },
      }
    },
  })
end

return M;
