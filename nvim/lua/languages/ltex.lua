local lspconfig = require 'lspconfig'

local M = {}

local filetypes = {
  "bib",
  "gitcommit",
  "markdown",
  "org",
  "plaintex",
  "rst",
  "rnoweb",
  "tex",
  "pandoc",
  "rust",
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
        sentenceCacheSize = 1000000,
        checkFrequency = "save",
        additionalRules = {
          languageModel = "~/ngrams/",
        }
      }
    }
  });

  lspconfig["lt-rs"].setup({
    on_attach = options.on_attach,
    capabilities = options.capabilities,
  })
end

return M;
