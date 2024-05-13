local lspconfig = require 'lspconfig'
local utils = require 'utils'

local M = {}

function M.setup(options)
  lspconfig.harper_ls.setup {
    -- cmd = vim.lsp.rpc.connect("127.0.0.1", 4000),
    -- filetypes = { "markdown", "text", "lua" },
    server = {
      on_attach = function(client, bufnr)
        options.on_attach(client, bufnr)
      end,
      capabilities = options.capabilities
    },
    settings = {
      ["harper-ls"] = {
        linters = {
          spell_check = true,
          spelled_numbers = false,
          an_a = true,
          sentence_capitalization = true,
          unclosed_quotes = true,
          wrong_quotes = false,
          long_sentences = true,
          repeated_words = true,
          spaces = true,
          matcher = true
        },
        diagnosticSeverity = "information"
      }
    },
  }
end

return M;
