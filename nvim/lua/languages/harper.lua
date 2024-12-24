local lspconfig = require 'lspconfig'

local M = {}

function M.setup(options)
  lspconfig.harper_ls.setup {
    -- cmd = vim.lsp.rpc.connect("127.0.0.1", 4000),
    -- filetypes = { "markdown", "text", "lua", "tex", "nix" },
    on_attach = options.on_attach,
    capabilities = options.capabilities,
    settings = {
      ["harper-ls"] = {
        linters = {
          spell_check = true,
          spelled_numbers = true,
          an_a = true,
          sentence_capitalization = true,
          unclosed_quotes = true,
          wrong_quotes = false,
          long_sentences = true,
          repeated_words = true,
          spaces = true,
          matcher = true,
          linking_verbs = true,
          boring_words = true
        },
        isolateEnglish = false
      }
    },
  }
end

return M;
