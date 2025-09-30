local typescript_tools = require 'typescript-tools'

local M = {}

function M.setup(options)
  typescript_tools.setup({
    on_attach = options.on_attach
  })

  vim.lsp.enable('biome')
end

return M;
