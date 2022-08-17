local treesitter_config = require 'nvim-treesitter.configs'

treesitter_config.setup({
        ensure_installed = {
                "lua",
                "rust",
                "bash",
                "json",
                "toml",
                "javascript",
                "typescript",
                "tsx",
                "vim",
                "yaml",
                "markdown",
                "html",
                "css"
        },
        highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
        }
})
