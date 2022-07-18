return require('packer').startup(function()
	-- Let packer manage itself
	use 'wbthomason/packer.nvim'

    -- Icons
    use 'kyazdani42/nvim-web-devicons'

	-- LSP
	use {
            'neovim/nvim-lspconfig',
            requires = {
                'windwp/nvim-autopairs'
            }
    }

    -- Git
    use 'lewis6991/gitsigns.nvim'

	-- Completion
	use {
		'hrsh7th/nvim-cmp',
		requires = {
                'hrsh7th/cmp-nvim-lsp',
                'hrsh7th/cmp-path',
                'hrsh7th/cmp-emoji',
                'saadparwaiz1/cmp_luasnip'
		}
	}

	-- Snippets
	use {
            'L3MON4D3/LuaSnip',
            requires = {
                'rafamadriz/friendly-snippets'
            }
    }

	-- File explorer
	use {
        'kyazdani42/nvim-tree.lua',
		requires = {
			'nvim-lualine/lualine.nvim'
	    	}
    	}

	-- Statusline
	use {
		'nvim-lualine/lualine.nvim',
		requires = {
			'nvim-lualine/lualine.nvim'
		}
	}

	-- AST
	use 'stevearc/aerial.nvim'

    -- Color Highlighting
    use {
        'norcalli/nvim-colorizer.lua',
        config = function() require('colorizer').setup() end
    }

	-- Colorscheme
    use 'folke/tokyonight.nvim'
end)
