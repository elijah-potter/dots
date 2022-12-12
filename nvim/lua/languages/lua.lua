local lspconfig = require 'lspconfig'
local utils = require 'utils'

local M = {}

function M.setup(options)
  lspconfig.sumneko_lua.setup {
    server = {
      on_attach = function(client, bufnr)
        options.on_attach(client, bufnr)
      end,
      capabilities = options.capabilities
    },
    settings = {
      Lua = {
        runtime = {
          version = 'LuaJIT',
        },
        diagnostics = {
          globals = {'vim'},
        },
        workspace = {
          library = vim.api.nvim_get_runtime_file("", true),
        },
        telemetry = {
          enable = false,
        },
      },
    },
  }
end

return M;
