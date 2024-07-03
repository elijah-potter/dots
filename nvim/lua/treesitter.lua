local treesitter_config = require 'nvim-treesitter.configs'
local treesitter_context = require 'treesitter-context'

treesitter_config.setup({
  ensure_installed = {
    "fish",
    "json",
    "json5",
    "toml",
    "yaml",
    "html",
    "css",
    "lua",
    "rust",
    "bash",
    "java",
    "javascript",
    "typescript",
    "svelte",
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
    "python",
    "go",
    "elixir",
    "astro",
    "c_sharp",
    "make"
  },
  autotag = {
    enable = true,
  },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  }
})

treesitter_context.setup({
  max_lines = 6
})
