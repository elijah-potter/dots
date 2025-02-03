local lspconfig = require 'lspconfig'

local M = {}

function M.setup(options)
  lspconfig.harper_ls.setup {
    -- cmd = vim.lsp.rpc.connect("127.0.0.1", 4000),
    -- filetypes = { "markdown", "text", "lua", "tex", "nix", "php" },
    on_attach = options.on_attach,
    capabilities = options.capabilities,
    settings = {
      ["harper-ls"] = {
        linters = {
          spelled_numbers = true,
          an_a = true,
          sentence_capitalization = true,
          unclosed_quotes = true,
          wrong_quotes = true,
          long_sentences = true,
          repeated_words = true,
          spaces = true,
          matcher = true,
          correct_number_suffix = true,
          number_suffix_capitalization = true,
          multiple_sequential_pronouns = true,
          linking_verbs = true,
          avoid_curses = true,
          terminating_conjunctions = true,
          ellipsis_length = true,
          dot_initialisms = true,
          boring_words = true,
          use_genitive = true,
          that_which = true,
          capitalize_personal_pronouns = true,
          americas = true,
          koreas = true,
          chinese_communist_party = true,
          united_organizations = true,
          holidays = true,
          amazon_names = true,
          google_names = true,
          meta_names = true,
          microsoft_names = true,
          apple_names = true,
          azure_names = true,
          merge_words = true,
          plural_conjugate = true,
          oxford_comma = true,
          spell_check = true,
        }
      }
    },
  }
end

return M;
