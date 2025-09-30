local M = {}

function M.setup(options)
  vim.lsp.enable('lua_ls')
  vim.lsp.config('lua_ls', {
    on_attach = options.on_attach,
    capabilities = options.capabilities,
    settings = {
      Lua = {
        runtime = {
          version = 'LuaJIT',
        },
        diagnostics = {
          globals = { 'vim' },
        },
        workspace = {
          library = vim.api.nvim_get_runtime_file("", true),
        },
        telemetry = {
          enable = false,
        },
      },
    },
  })
end

return M;
