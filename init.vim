set number
set autoread
set clipboard=unnamed
set expandtab
set shiftwidth=2
set softtabstop=2
set whichwrap=h,l,b,s,<,>,[,]
set textwidth=80
command W execute ":w"
command Q execute ":q"
nnoremap <Return><Return> <c-w><c-w>
highlight trailingWhitespace ctermbg=red guibg=red
cnoremap <Up> <C-p>
cnoremap <Down> <C-n>

