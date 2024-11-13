" vim-plugの初期化
call plug#begin('~/.config/nvim/plugged')

" コメントアウト用
Plug 'tpope/vim-commentary'

" HTMLインデント用
Plug 'othree/html5.vim'
Plug 'mattn/emmet-vim'

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'honza/vim-snippets'
Plug 'neoclide/coc-snippets'

Plug 'sbdchd/neoformat'
Plug 'vim-airline/vim-airline'

call plug#end()

" エディタの基本設定
set number
set autoread
set clipboard=unnamed
set expandtab
set shiftwidth=2
set softtabstop=2
set whichwrap=h,l,b,s,<,>,[,]
set textwidth=0

" キーバインド
nnoremap <Return><Return> <c-w><c-w>      " Enterキーでウィンドウ間を移動
highlight trailingWhitespace ctermbg=red guibg=red  " 行末の空白を赤くハイライト
cnoremap <Up> <C-p>                        " コマンドラインで矢印キーで履歴を呼び出す
cnoremap <Down> <C-n>                      " コマンドラインで矢印キーで履歴を呼び出す
nnoremap <C-k> <C-v>                       " Ctrl+kでビジュアルモードの操作

" コード補完の設定
" Cocの拡張機能をインストールして、HTML, CSS, JS補完を有効化
let g:coc_global_extensions = ['coc-html', 'coc-css', 'coc-tsserver', 'coc-json', 'coc-phpls', 'coc-sql']

" タブキーで補完候補を選択し、補完リストが表示されていないときは通常のインデントにする
inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <silent><expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"

" .phpファイル用の補完インデント設定
autocmd FileType php inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
autocmd FileType php inoremap <silent><expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"

" 補完候補の確定をEnterキーに設定
inoremap <silent><expr> <CR> pumvisible() ? coc#_select_confirm() : "\<CR>"


" .phpファイルでもEmmetを有効にする
" autocmd FileType php EmmetInstall

" .phpファイル内でもHTMLのインデントを適用
" autocmd FileType php setlocal shiftwidth=2 tabstop=2 expandtab
" autocmd FileType php setlocal autoindent smartindent

" .phpファイルに対してもhtml5.vimのインデントを適用
" autocmd FileType php setlocal filetype=html



" --- カーソルを表示行で移動する設定（日本語の文章用） ---
nnoremap j gj
nnoremap k gk
nnoremap <Down> gj
nnoremap <Up>   gk

" --- 日本語(マルチバイト文字)連結時に空白を挿入しない設定 ---
set formatoptions+=mM
set ambiwidth=double          " ○や□などの全角文字のズレ防止
set display+=lastline         " 最後の行も画面に収める

" --- 全角スペースを強調表示する設定 ---
highlight ZenkakuSpace ctermbg=red guibg=red
match ZenkakuSpace /　/

" --- ステータスラインにエンコーディングと改行コードを表示 ---
set laststatus=2
set statusline=%<%f\ %m\ %r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=\ (%v,%l)/%L%8P

" --- 「」や（）のマッチペア移動を有効にする設定 ---
set matchpairs+=「:」,（:）

" --- タイプライタースクロールの設定 ---
set scrolloff=9999


" Neoformat を有効にする
let g:neoformat_enabled_php = ['php_cs_fixer']

" PHP-CS-Fixer のオプションをカスタマイズ（必要に応じて）
let g:neoformat_php_php_cs_fixer = {
    \ 'exe': 'php-cs-fixer',
    \ 'args': ['fix', '--using-cache=no', '--quiet', '--stdin', '--stdin-filename', '%'],
    \ 'stdin': 1,
    \ }

" キーマッピングの設定（例: <leader>f でフォーマット実行）
nnoremap <leader>f :Neoformat<CR>

" 保存時に自動でPHPファイルをフォーマット
autocmd BufWritePre *.php Neoformat


