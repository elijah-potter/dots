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
set guifont=FiraCode\ Nerd\ Font\ Mono:h11 " Set Neovide font color and size
let g:neovide_cursor_vfx_mode = "torpedo"

call plug#begin(stdpath('data'))
 Plug 'vim-airline/vim-airline'
 Plug 'vim-airline/vim-airline-themes'
 Plug 'tanvirtin/monokai.nvim'
 Plug 'ryanoasis/vim-devicons'
 Plug 'scrooloose/nerdtree'
 Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

" Configure Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

" Configure COC
" Install necessary extensions
let g:coc_global_extensions = ['coc-json', 'coc-git', 'coc-rust-analyzer', 'coc-prettier', 'coc-css', 'coc-html', 'coc-eslint', 'coc-tsserver', 'coc-tslint-plugin', 'coc-ltex']

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

" Use <tab> for trigger completion and navigate to the next complete item.
inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

nmap <slient> gd <Plug>(coc-definition)

" Add `:Format` command to format current buffer and add format on save.
command! -nargs=0 Format :call CocActionAsync('format')
:map <silent> <C-F> :Format<CR>

" COC show function signatures
autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')

" Enable highlighting
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

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

" Define location of LanguageTool
let g:languagetool_server_jar="/usr/share/java/languagetool/languagetool-server.jar"

if (has("termguicolors"))
    set termguicolors
endif

syntax enable
colorscheme monokai_soda
" hi Normal guibg=NONE ctermbg=NONE

" Start NERDTree when Vim is started without file arguments.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif
