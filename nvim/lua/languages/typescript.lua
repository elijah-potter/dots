local lspconfig = require 'lspconfig'

local M = {}

function M.setup(options)
        lspconfig.tsserver.setup({
                on_attach = options.on_attach,
                capabilities = options.capabilities,
                settings = {}
        })
end

return M;
