local lspconfig = require 'lspconfig'

local M = {}

local filetypes = {
  "bib",
  "bibtex",
  "gitcommit",
  "markdown",
  "org",
  "plaintext",
  "rst",
  "rnoweb",
  "tex",
  "latex",
  "pandoc",
  --"rust",
  "javascript",
  "typescript",
  "javascriptreact",
  "typescriptreact",
  "lua",
  "python",
  "html",
}


function M.setup(options)
  lspconfig.ltex.setup({
    on_attach = options.on_attach,
    capabilities = options.capabilities,
    filetypes = filetypes,
    settings = {
      ltex = {
        enabled = filetypes,
        sentenceCacheSize = 10000,
        checkFrequency = "save",
        additionalRules = {
          languageModel = "~/ngrams/",
        }
      }
    }
  });
end

return M;
