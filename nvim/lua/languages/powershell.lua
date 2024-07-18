local lspconfig = require 'lspconfig'
local utils = require 'utils'

local M = {}

function M.setup(options)
  require('powershell').setup({
    bundle_path = vim.fn.stdpath "data" .. "/mason/packages/powershell-editor-services",
  })
end

return M;
