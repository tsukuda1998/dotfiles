call plug#begin('~/.local/share/nvim/plugged')

Plug 'phpactor/phpactor', {'for': 'php'}
Plug 'phpactor/ncm2-phpactor'
Plug 'ncm2/ncm2'
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-path'
Plug 'roxma/nvim-yarp'  " 依存プラグインの追加
Plug 'ludovicchabant/vim-gutentags'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'StanAngeloff/php.vim'

call plug#end()

set number
set autoread
set clipboard=unnamed
set expandtab
set shiftwidth=4
set softtabstop=4
set whichwrap=h,l,b,s,<,>,[,]
set textwidth=0

command W execute ":w"
command Q execute ":q"
nnoremap <Return><Return> <c-w><c-w>
highlight trailingWhitespace ctermbg=red guibg=red
cnoremap <Up> <C-p>
cnoremap <Down> <C-n>

" PHPActorのパスを設定
let g:phpactorPath = expand('~/.local/share/nvim/plugged/phpactor')

" ncm2の設定
set completeopt=noinsert,menuone,noselect
autocmd BufEnter * call ncm2#enable_for_buffer()

" PHPファイルでphpactorを使用
autocmd FileType php setlocal omnifunc=phpactor#Complete
let g:ncm2#auto_enable = 1

" Gutentagsの設定
let g:gutentags_enabled = 1
let g:gutentags_ctags_auto_set_tags = 1

" UltiSnipsの設定
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

" スニペットディレクトリの設定
let g:UltiSnipsSnippetDirectories=["UltiSnips", "my_snippets"]

" Python 3 provider設定
if has('nvim')
  let g:python3_host_prog = '/usr/bin/python3'
endif
