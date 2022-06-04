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
 Plug 'nvim-lualine/lualine.nvim'
 Plug 'ryanoasis/vim-devicons'
 Plug 'scrooloose/nerdtree'
 Plug 'eddyekofo94/gruvbox-flat.nvim'
 Plug 'neovim/nvim-lspconfig'
 Plug 'hrsh7th/nvim-cmp'
 Plug 'hrsh7th/cmp-nvim-lsp'
 Plug 'hrsh7th/cmp-vsnip'
 Plug 'hrsh7th/cmp-path'
 Plug 'hrsh7th/cmp-buffer'
 Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
 Plug 'hrsh7th/vim-vsnip'
 Plug 'hrsh7th/vim-vsnip-integ'
 Plug 'rafamadriz/friendly-snippets'
 Plug 'windwp/nvim-autopairs'
 Plug 'airblade/vim-gitgutter'
call plug#end()

lua << EOF
require('nvim-autopairs').setup()

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
local lsp_args = {capabilities = capabilities}

-- Setup Language Servers
local lspconfig = require('lspconfig')

local servers = { 'ltex', 'eslint', 'tsserver', 'jsonls' }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    capabilities = capabilities,
  }
end

lspconfig["rust_analyzer"].setup{
    capabilities = capabilities,
    settings = {
        ["rust-analyzer"] = {
            checkOnSave = {
                command = "clippy"
            } 
        }
    }
}

-- Setup Autocompletion
local cmp = require("cmp");
cmp.setup({
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end,
    },
    mapping = {
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
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'vsnip' },
        { name = 'path' },
        { name = 'nvim_lsp_signature_help' },
        { name = 'buffer'}
    }),
})
EOF

let g:vsnip_filetypes = {}
let g:vsnip_filetypes.javascriptreact = ['html']
let g:vsnip_filetypes.typescriptreact = ['html']

" Map keys for LSP
nnoremap <silent> <C-F> <cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap <C-A> <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <C-D> <cmd>lua vim.lsp.buf.definition()<CR>

" Auto format with eslint
autocmd BufWritePre *.tsx,*.ts,*.jsx,*.js EslintFixAll

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
map <silent> <C-N> :NERDTreeToggle<CR>

" Make Nerd Tree open on right side
let g:NERDTreeWinPos = "right"

" Start NERDTree when Vim is started without file arguments.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif

" Create command to close all but current buffer
function! CloseOtherBuffer()
    let l:bufnr = bufnr()
    execute "only"
    for buffer in getbufinfo()
        if !buffer.listed
            continue
        endif
        if buffer.bufnr == l:bufnr
            continue
        else
            if buffer.changed
                echo buffer.name . " has changed, save first"
                continue
            endif
            let l:cmd = "bdelete " . buffer.bufnr
            execute l:cmd
        endif
    endfor
endfunction

nnoremap <C-O> :call CloseOtherBuffer()<CR>

" Make everything look pretty
lua << EOF
require('lualine').setup({
    options = {
        theme = 'gruvbox-flat'
    },
    extensions = { 'nerdtree', 'quickfix' },
    tabline = {
        lualine_a = {'buffers'},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {}
    }
})
EOF

if (has("termguicolors"))
    set termguicolors
endif

syntax enable
let g:gruvbox_flat_style = "hard"
let g:gruvbox_italic_functions = 1

colorscheme gruvbox-flat
