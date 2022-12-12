local typescript = require 'typescript'

local M = {}

function M.setup(options)
  typescript.setup({
    debug = false,
    disable_commands = false,
    go_to_source_definition = {
        fallback = true,
    },
    server = {
      on_attach = options.on_attach,
      capabilities = options.capabilities,
      settings = {}
    }
  })
end

return M;
