set nocompatible            " disable compatibility to old-time vi
set showmatch               " show matching 
set ignorecase              " case insensitive 
set mouse=v                 " middle-click paste with 
set hlsearch                " highlight search 
set incsearch               " incremental search
set tabstop=4               " number of columns occupied by a tab 
set softtabstop=4           " see multiple spaces as tabstops so <BS> does the right thing
set expandtab               " converts tabs to white space
set shiftwidth=4            " width for autoindents
set autoindent              " indent a new line the same amount as the line just typed
set number                  " add line numbers
set wildmode=longest,list   " get bash-like tab completions
filetype plugin indent on   "allow auto-indenting depending on file type
syntax on                   " syntax highlighting
set mouse=a                 " enable mouse click
set clipboard=unnamedplus   " using system clipboard filetype plugin on
set cursorline              " highlight current cursorline
set ttyfast                 " Speed up scrolling in Vim
set spelllang=en
set spellsuggest=best,9
set spell
set backupdir=~/.cache/vim " Directory to store backup files.
set signcolumn=number
set guifont=FiraCode\ Nerd\ Font\ Mono:h12 " Set Neovide font color and size
let g:neovide_cursor_vfx_mode = "torpedo"

call plug#begin(stdpath('data'))
 Plug 'vim-airline/vim-airline'
 Plug 'vim-airline/vim-airline-themes'
 Plug 'tanvirtin/monokai.nvim'
 Plug 'ryanoasis/vim-devicons'
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

" Setup LSP
lua << EOF
local nvim_lsp = require'lspconfig'
require("lsp-format").setup {}

local on_attach = function(client)
    require "lsp-format".on_attach(client)
end


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

    -- All the opts to send to nvim-lspconfig
    -- These override the settings set by rust-tools.nvim
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

local mappings_utils = require('renamer.mappings.utils');
require('renamer').setup{}

EOF

" Setup completions
set completeopt=menuone,noinsert,noselect

lua << EOF
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
" Do code action on ga
nnoremap <silent> <C-F> <cmd>lua vim.lsp.buf.code_action()<CR>

" Show hover menu with Control + A
nnoremap <C-A> <cmd>lua vim.lsp.buf.hover()<CR>

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

" Make windows side-by-side with Shift + H
nnoremap <silent> <S-A> <C-W>H

" Toggle Nerd Tree with Control + B
map <silent> <C-B> :NERDTreeToggle<CR>

" Make Nerd Tree open on right side
let g:NERDTreeWinPos = "right"

" Configure Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

if (has("termguicolors"))
    set termguicolors
endif

syntax enable
colorscheme monokai_soda
" hi Normal guibg=NONE ctermbg=NONE

" Start NERDTree when Vim is started without file arguments.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif
