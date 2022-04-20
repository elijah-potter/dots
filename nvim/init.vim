set nocompatible            
set showmatch               
set ignorecase              
set mouse=v                 
set hlsearch                
set incsearch               
set tabstop=4               
set softtabstop=4           
set expandtab               
set shiftwidth=4            
set autoindent              
set number                  
set wildmode=longest,list   
filetype plugin indent on   
syntax on                   
set mouse=a                 
set clipboard=unnamedplus   
set cursorline              
set ttyfast                 
set spelllang=en
set spellsuggest=best,9
set spell
set backupdir=~/.cache/vim 
set signcolumn=number
set completeopt=menuone,noinsert,noselect
set clipboard=unnamedplus

" Install Plugins
call plug#begin(stdpath('data'))
 Plug 'vim-airline/vim-airline'
 Plug 'vim-airline/vim-airline-themes'
 Plug 'ryanoasis/vim-devicons'
 Plug 'morhetz/gruvbox'
 Plug 'scrooloose/nerdtree'
 Plug 'neovim/nvim-lspconfig'
 Plug 'hrsh7th/nvim-cmp'
 Plug 'hrsh7th/cmp-nvim-lsp'
 Plug 'hrsh7th/cmp-vsnip'
 Plug 'hrsh7th/cmp-path'
 Plug 'hrsh7th/cmp-buffer'
 Plug 'simrat39/rust-tools.nvim'
 Plug 'hrsh7th/vim-vsnip'
 Plug 'lukas-reineke/lsp-format.nvim'
 Plug 'nvim-lua/plenary.nvim'
 Plug 'filipdutescu/renamer.nvim'
call plug#end()

lua << EOF
local nvim_lsp = require'lspconfig'
require("lsp-format").setup {}

local on_attach = function(client)
    require "lsp-format".on_attach(client)
end

-- Setup Language Servers
require('rust-tools').setup{
    tools = {
        autoSetHints = true,
        hover_with_actions = true,
        inlay_hints = {
            show_parameter_hints = false,
            parameter_hints_prefix = "",
            other_hints_prefix = "",
        },
    },

    server = {
        settings = {
            ["rust-analyzer"] = {
                checkOnSave = {
                    command = "clippy"
                },
            },
        },
    },
    on_attach = on_attach
}

require'lspconfig'.eslint.setup{}
require'lspconfig'.ltex.setup{}

-- Setup renamer
local mappings_utils = require('renamer.mappings.utils');
require('renamer').setup{}

-- Setup Autocompletion
local cmp = require'cmp'
cmp.setup({
    -- Enable LSP Snippets
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end,
    },
    mapping = {
        -- Use Tab to navigate completions
        ['<S-Tab>'] = cmp.mapping.select_prev_item(),
        ['<Tab>'] = cmp.mapping.select_next_item(),
        ['<C-D>'] = cmp.mapping.scroll_docs(-4),
        ['<C-F>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
        })
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'vsnip' },
        { name = 'path' },
        { name = 'buffer' },
    }
})
EOF

" Map keys for LSP
nnoremap <silent> <C-F> <cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap <C-A> <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <C-D> <cmd>lua vim.lsp.buf.definition()<CR>

" Set rename hotkey
inoremap <silent> <C-R> <cmd>lua require('renamer').rename()<CR>

" Switch tabs using Control + Move Keys
map <silent> <C-H> :bp<CR>
map <silent> <C-L> :bn<CR>

" Switch windows using Shift + Move Keys
nnoremap <silent> <S-H> <C-W>h
nnoremap <silent> <S-J> <C-W>j
nnoremap <silent> <S-K> <C-W>k
nnoremap <silent> <S-L> <C-W>l

" Close window with Shift + C
nnoremap <silent> <S-C> <C-W>c

" Make windows side-by-side with Shift + A
nnoremap <silent> <S-A> <C-W>H

" Move around twice as fast with Alt + Movement Keys
nnoremap <silent> <A-h> hh
nnoremap <silent> <A-j> jj
nnoremap <silent> <A-k> kk
nnoremap <silent> <A-l> ll

vnoremap <silent> <A-h> hh
vnoremap <silent> <A-j> jj
vnoremap <silent> <A-k> kk
vnoremap <silent> <A-l> ll


" Toggle Nerd Tree with Control + B
map <silent> <C-B> :NERDTreeToggle<CR>

" Make Nerd Tree open on right side
let g:NERDTreeWinPos = "right"

" Start NERDTree when Vim is started without file arguments.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif

" Make everything look pretty
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

if (has("termguicolors"))
    set termguicolors
endif

syntax enable
colorscheme gruvbox
