" Add support for Doxygen comment leader.
setlocal comments^=:///
setlocal commentstring=//%s

" Set text width for C code to be able to easily format comments.
setlocal shiftwidth=2
setlocal textwidth=80
setlocal formatoptions+=croqnj
setlocal spell spelllang=en_us

" Only do this when not done yet for this buffer.
if exists("b:c_override")
  finish
endif
let b:c_override = 1

" Mappings for formatting C++ code using clang-format.
map <buffer> <leader>a :call ClangFormatFile()<cr>
map <buffer> <leader>q :call ClangFormat()<cr>

" Let miniyank automatically format the pasted code using clang-format.
noremap <buffer> <expr> p miniyank#startput("p`[v`]=",1)
noremap <buffer> <expr> P miniyank#startput("P`[v`]=",1)

" Only do this when this is the first time these settings are loaded for the
" current Vim instance.
if exists("g:c_override")
  finish
endif
let g:c_override = 1

function ClangFormat()
    py3f /usr/share/clang/clang-format.py
endfunction

function ClangFormatFile()
    let l:lines="all"
    py3f /usr/share/clang/clang-format.py
endfunction
