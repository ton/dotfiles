" Fold Doxygen comments by default in C++ code.
au FileType cpp setlocal foldmethod=expr
au FileType cpp setlocal foldexpr=getline(v:lnum)=~'^\\s*///'

" By default, expand all folded Doxygen blocks.
set foldlevelstart=1

" No fill chars for the fold text.
set fillchars=fold:\ 

" Custom fold text; make sure the text stays in the same place, include number
" of lines.
function DoxygenFoldText()
  let line = getline(v:foldstart)
  let num_lines = v:foldend - v:foldstart + 1
  let sub = substitute(line, '^  ', '', 'g')
  return '+ ' . sub . ' (' . num_lines . ' lines)'
endfunction
set foldtext=DoxygenFoldText()

" Subtler colors for folded Doxygen comments.
highlight Folded guibg=#333333 guifg=#585858
