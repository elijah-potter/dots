local M = {}

function M.setup(options)
  vim.lsp.enable('harper_ls')
  vim.lsp.config('harper_ls', {
    -- cmd = vim.lsp.rpc.connect("127.0.0.1", 4000),
    on_attach = options.on_attach,
    capabilities = options.capabilities,
    filetypes = {
      'plaintex',
      'tex',
    'asciidoc',
    'c',
    'cpp',
    'cs',
    'gitcommit',
    'go',
    'html',
    'java',
    'javascript',
    'lua',
    'markdown',
    'nix',
    'python',
    'ruby',
    'rust',
    'swift',
    'toml',
    'typescript',
    'typescriptreact',
    'haskell',
    'cmake',
    'typst',
    'php',
    'dart',
    'clojure',
    'sh',
    'octo'
  },
    settings = {
      ["harper-ls"] = {
        dialect = "American",
        linters = {
        },
      }
    },
  })
end

return M;
