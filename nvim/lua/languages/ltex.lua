local lspconfig = require 'lspconfig'

local M = {}

function M.setup(options)
        local on_attach = function(client, bufnr)
                options.on_attach(client, bufnr)
        end

        lspconfig.ltex.setup({
                on_attach = options.on_attach,
                capabilities = options.capabilities,
        });
end

return M;
