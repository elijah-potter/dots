local treesitter_config = require 'nvim-treesitter.configs'
local treesitter_context = require 'treesitter-context'

treesitter_config.setup({
        ensure_installed = {
                "json",
                "json5",
                "toml",
                "yaml",
                "html",
                "css",
                "lua",
                "rust",
                "bash",
                "javascript",
                "typescript",
                "tsx",
                "vim",
                "markdown",
                "markdown_inline",
                "latex",
                "bibtex",
                "regex",
                "gitignore",
                "diff",
                "comment",
                "wgsl",
                "dockerfile",
                "python"
        },
        highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
        }
})

treesitter_context.setup()
