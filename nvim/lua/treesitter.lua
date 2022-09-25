local treesitter_config = require 'nvim-treesitter.configs'

treesitter_config.setup({
        ensure_installed = {
                "json",
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
                "latex",
        },
        highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
        }
})
