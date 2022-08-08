local lspconfig = require 'lspconfig'

local M = {}

function M.setup(options)
        lspconfig.eslint.setup({
                on_attach = options.on_attach,
                capabilities = options.capabilities,
                settings = {}
        })

        vim.api.nvim_create_autocmd("BufWritePre", {
                pattern = {"*.tsx", "*.ts", "*.jsx", "*.js"},
                command = "EslintFixAll"
        });
end

return M;
