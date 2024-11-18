call plug#begin('~/.config/nvim/plugged')

Plug 'tpope/vim-commentary'                   
Plug 'othree/html5.vim'                        
Plug 'mattn/emmet-vim'                         
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'honza/vim-snippets'                      
Plug 'neoclide/coc-snippets'                   
Plug 'sbdchd/neoformat'                        
Plug 'vim-airline/vim-airline'                 
Plug 'SirVer/ultisnips'                        

call plug#end()

set number
set autoread
set clipboard=unnamed
set expandtab
set shiftwidth=2
set softtabstop=2
set whichwrap=h,l,b,s,<,>,[,]
set textwidth=0

nnoremap <Return><Return> <c-w><c-w>      
highlight trailingWhitespace ctermbg=red guibg=red  
cnoremap <Up> <C-p>                        
cnoremap <Down> <C-n>                      

let g:coc_global_extensions = [
      \ 'coc-html',
      \ 'coc-css',
      \ 'coc-tsserver',
      \ 'coc-json',
      \ 'coc-phpls',
      \ 'coc-sql',
      \ 'coc-ultisnips'
      \ ]
let g:UltiSnipsRemoveSelectModeMappings = 1
let g:UltiSnipsRemoveSplitMappings = 1

let g:UltiSnipsExpandTrigger = '<C-j>'
let g:UltiSnipsJumpForwardTrigger = '<C-j>'
let g:UltiSnipsJumpBackwardTrigger = '<C-k>'

" nnoremap > v>
" nnoremap < v<
" vnoremap > >gv
" vnoremap < <gv

" inoremap <silent><expr> <S-j>
"       \ pumvisible() ? "\<C-n>" :
"       \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets.expandOrJump', ''])\<CR>" :
"       \ "\<S-j>"

" inoremap <silent><expr> <S-k>
"       \ pumvisible() ? "\<C-p>" :
"       \ coc#jumpable(-1) ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets.jumpBackward', ''])\<CR>" :
"       \ "\<S-k>"


inoremap <silent><expr> <CR> pumvisible() ? coc#pum#confirm() : "\<CR>"

