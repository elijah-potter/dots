local lspconfig = require 'lspconfig'
local utils = require 'utils'
local bmap = utils.bmap

local M = {}

function M.setup(options)
        local on_attach = function(client, bufnr)
                options.on_attach(client, bufnr)

                bmap("i", "w/", "with")
                bmap("i", "wo/", "with")
                bmap("i", "bc", "because")
                bmap("i", "asap", "as soon a possible")
        end

        lspconfig.ltex.setup({
                on_attach = options.on_attach,
                capabilities = options.capabilities,
        });
end

return M;
