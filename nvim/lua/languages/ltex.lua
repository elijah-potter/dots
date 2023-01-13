local lspconfig = require 'lspconfig'

local M = {}

function M.setup(options)
  lspconfig.ltex.setup({
    on_attach = options.on_attach,
    capabilities = options.capabilities,
  });

  local command = "pdflatex -output-directory=./%:h ./%:r 2>&1 1>/dev/null; "

  vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = {"*.tex"},
    command = "silent !(" .. command .. "biber ./%:r 2>&1 1>/dev/null; " .. command .. command .. ") & disown"
  })

  vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = {"*.md"},
    command = "silent !pandoc ./% -o ./%.pdf -V \"geometry:margin=2cm\" & disown"
  })
end

return M;
