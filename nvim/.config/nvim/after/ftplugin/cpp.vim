" Add support for Doxygen comment leader.
setlocal comments^=:///
setlocal commentstring=//%s

" Set text width for C++ code to be able to easily format comments.
setlocal shiftwidth=2
setlocal textwidth=80
setlocal formatoptions+=croqnj
setlocal spell spelllang=en_us

" Only do this when not done yet for this buffer.
if exists("b:c_cpp_override")
  finish
endif
let b:c_cpp_override = 1

" Mappings for formatting C++ code using clang-format.
map <buffer> <leader>a :call ClangFormatFile()<cr>
map <buffer> <leader>q :call ClangFormat()<cr>

" Let miniyank automatically format the pasted code using clang-format.
noremap <buffer> <expr> p miniyank#startput("p`[v`]=",1)
noremap <buffer> <expr> P miniyank#startput("P`[v`]=",1)

" Only do this when this is the first time these settings are loaded for the
" current Vim instance.
if exists("g:c_cpp_override")
  finish
endif
let g:c_cpp_override = 1

function ClangFormat()
    py3f ~/.local/share/nvim/clang/clang-format.py
endfunction

function ClangFormatFile()
    let l:lines="all"
    py3f ~/.local/share/nvim/clang/clang-format.py
endfunction

" Only do this when not done yet for this buffer.
if exists("b:cpp_override")
  finish
endif
let b:cpp_override = 1

" Don't indent templates.
setlocal indentexpr=CppNoTemplateIndent()

" Fix auto indentation in lambda's.
setlocal cino=j1,(0,ws,Ws

" Only do this when this is the first time these settings are loaded for the
" current Vim instance.
if exists("g:cpp_override")
  finish
endif
let g:cpp_override = 1

function CppNoTemplateIndent()
    let l:cline_num = line('.')
    let l:cline = getline(l:cline_num)
    let l:pline_num = prevnonblank(l:cline_num - 1)
    let l:pline = getline(l:pline_num)
    while l:pline =~# '\(^\s*{\s*\|^\s*//\|^\s*/\*\|\*/\s*$\)'
        let l:pline_num = prevnonblank(l:pline_num - 1)
        let l:pline = getline(l:pline_num)
    endwhile
    let l:retv = cindent('.')
    let l:pindent = indent(l:pline_num)
    if l:pline =~# '^\s*template\s*<.*>\s*$'
        let l:retv = l:pindent
    elseif l:pline =~# '\s*typename\s*.*,\s*$'
        let l:retv = l:pindent
    elseif l:cline =~# '^\s*>\s*$'
        let l:retv = l:pindent - &shiftwidth
    elseif l:pline =~# '\s*typename\s*.*>\s*$'
        let l:retv = l:pindent - &shiftwidth
    endif
    return l:retv
endfunction
