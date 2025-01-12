" シンプルに前の行のインデントを保つ設定
function! SimpleIndent() abort
  " 前の行のインデントをそのまま返す
  return indent(v:lnum - 1)
endfunction

" インデント式を設定
setlocal indentexpr=SimpleIndent()
setlocal autoindent
setlocal shiftwidth=2
setlocal tabstop=2
setlocal expandtab

