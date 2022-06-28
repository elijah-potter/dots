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

	-- Completions
	use {
		'hrsh7th/nvim-cmp',
		requires = {
                'hrsh7th/cmp-nvim-lsp',
                'hrsh7th/cmp-path',
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

	-- Colorscheme
	use 'EdenEast/nightfox.nvim'
end)
