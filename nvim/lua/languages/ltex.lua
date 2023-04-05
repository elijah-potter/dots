local lspconfig = require 'lspconfig'

local M = {}

function M.setup(options)
  lspconfig.ltex.setup({
    on_attach = options.on_attach,
    capabilities = options.capabilities,
    settings = {
      ltex = {
        additionalRules = {
          languageModel = "~/ngrams/"
        }
      }
    }
  });
end

return M;
