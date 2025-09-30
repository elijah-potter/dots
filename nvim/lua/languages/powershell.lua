local M = {}

function M.setup(options)
  vim.lsp.enable('powershell_es')
  vim.lsp.config('powershell_es', {
    bundle_path = vim.fn.stdpath "data" .. "/mason/packages/powershell-editor-services",
    capabilities = options.capabilities,
    on_attach = options.on_attach
  })
end

return M;
