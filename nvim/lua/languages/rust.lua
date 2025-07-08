local lspconfig = require 'lspconfig'
local crates = require 'crates'
crates.setup({})

local M = {}

function M.setup(options)
  lspconfig.rust_analyzer.setup {
    capabilities = options.capabilities,
    on_attach = options.on_attach,
    cmd = { "/home/elijahpotter/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/bin/rust-analyzer" },
    settings = {
      ["rust-analyzer"] = {
        imports = {
          granularity = {
            group = "module",
          },
          prefix = "self",
        },
        cargo = {
          buildScripts = {
            enable = true,
          },
        },
        procMacro = {
          enable = true
        },
      }
    }
  }
end

return M;
