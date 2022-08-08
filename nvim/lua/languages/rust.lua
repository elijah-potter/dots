local lspconfig = require 'lspconfig'
local tools_config = require 'rust-tools.config'
local tools_inlay_hints = require 'rust-tools.inlay_hints'

local M = {}

function M.setup(options)
        local on_attach = function(client, bufnr)
                tools_config.setup()
                tools_inlay_hints.setup_autocmd()

                options.on_attach(client, bufnr)
        end

        lspconfig.rust_analyzer.setup({
                on_attach = options.on_attach,
                capabilities = options.capabilities,
                settings = {
                    	checkOnSave = {
                                command = 'clippy',
                        },
                },
        });
end

return M;
