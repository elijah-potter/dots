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
set clipboard=unnamedplus   " using system clipboard
filetype plugin on
set cursorline              " highlight current cursorline
set ttyfast                 " Speed up scrolling in Vim
set spell                 
set backupdir=~/.cache/vim " Directory to store backup files.
set signcolumn=number

call plug#begin(stdpath('data'))
 Plug 'vim-airline/vim-airline'
 Plug 'vim-airline/vim-airline-themes'
 Plug 'tanvirtin/monokai.nvim'
 Plug 'ryanoasis/vim-devicons'
 Plug 'scrooloose/nerdtree'
 Plug 'mhinz/vim-startify'
 Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

" Configure Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

" Configure COC
" Install necessary extensions
let g:coc_global_extensions = ['coc-json', 'coc-git', 'coc-rust-analyzer', 'coc-prettier', 'coc-css', 'coc-html', 'coc-eslint']

" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

" Add `:Format` command to format current buffer and add format on save.
command! -nargs=0 Format :call CocActionAsync('format')

" COC show signatures
autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')


if (has("termguicolors"))
    set termguicolors
endif
syntax enable
colorscheme monokai_soda
hi Normal guibg=NONE ctermbg=NONE
