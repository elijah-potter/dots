local rt = require 'rust-tools'

local M = {}

function M.setup(options)
  rt.setup({
    inlay_hints = {
      show_parameter_hints = false
    },
    server = {
      standalone = false,
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
          procMacro = {
            enable = true
          }
        }
      },
    }
  })
end

return M;
