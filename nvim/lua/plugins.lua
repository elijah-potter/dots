local packer = require 'packer'

packer.startup(function()
	-- Let packer manage itself
	use 'wbthomason/packer.nvim'

    use 'kyazdani42/nvim-web-devicons'
	use 'neovim/nvim-lspconfig'
    use 'windwp/nvim-autopairs'
    use 'lewis6991/gitsigns.nvim'
	use {
		'hrsh7th/nvim-cmp',
		requires = {
                'hrsh7th/cmp-nvim-lsp',
                'hrsh7th/cmp-path',
                'hrsh7th/cmp-emoji',
                'saadparwaiz1/cmp_luasnip'
		}
	}
	use {
            'L3MON4D3/LuaSnip',
            requires = {
                'rafamadriz/friendly-snippets'
            }
    }
	use 'kyazdani42/nvim-tree.lua'
    use 'nvim-lualine/lualine.nvim'
	use 'stevearc/aerial.nvim'
    use 'folke/tokyonight.nvim'
    use 'nvim-treesitter/nvim-treesitter'
    use 'folke/trouble.nvim'
    use {
        'saecki/crates.nvim',
        requires = { 'nvim-lua/plenary.nvim' },
    }
end)
