"-------------------------------------------------------------------------------
" Shortcuts
"-------------------------------------------------------------------------------

" The <leader> part in the shortcuts below is configurable and set to '\' in
" this configuration.
"
" K : open man page for word under cursor in a vertical split if available

"-------------------------------------------------------------------------------
" Load third-party plugins
"-------------------------------------------------------------------------------

"" Specify a directory for plugins
call plug#begin('~/.local/share/nvim/vim-plug')

" List all external plugins managed through vim-plug.
Plug 'bfredl/nvim-miniyank'
Plug 'jez/vim-superman'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'justinmk/vim-sneak'
Plug 'Olical/conjure'
Plug 'pangloss/vim-javascript'
Plug 'sickill/vim-pasta'
Plug 'SirVer/ultisnips'
Plug 'ton/vim-alternate'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'

Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/nvim-cmp'

call plug#end()

"-------------------------------------------------------------------------------
" Text formatting
"-------------------------------------------------------------------------------

set autoindent                       " always set autoindenting on
set expandtab                        " insert spaces when the tab key is pressed
set shiftround                       " use multiple of shiftwidth when indenting
                                     " with '<' and '>'
set shiftwidth=4                     " number of spaces to use for autoindenting
set smarttab                         " insert tabs on the start of a line
                                     " according to shiftwidth, not tabstop
set tabstop=4                        " a tab is four spaces
set wrap                             " wrap overlong lines

set cino=g0                          " do not indent public/protected/private
set nojoinspaces                     " do not insert two spaces after a '.',
                                     " '?', and '!' with the join command

"-------------------------------------------------------------------------------
" UI settings
"-------------------------------------------------------------------------------

syntax on                            " enable syntax highlighting
colorscheme wombat                   " nice colorscheme

set t_so=[7m                       " set escape codes for standout mode
set t_ZH=[3m                       " set escape codes for italics mode
set termguicolors                    " enable 24-bit colors

set backspace=indent,eol,start       " allow backspacing over everything in
                                     " insert mode
set nofoldenable                     " disable code folding by default
set number                           " always show line numbers
set numberwidth=5                    " we are good for up to 99999 lines
set ruler                            " show the cursor position all the time
set showcmd                          " display incomplete commands
set splitright                       " open vertical splits on the right side
set mouse=a                          " allow for mouse scrolling in tmux
set wildmenu                         " add command-line completion menu

" Set leader defaults.
let mapleader = "\\"
let maplocalleader = "\\"

" Enable Doxygen syntax highlighting.
let g:load_doxygen_syntax=1
let g:doxygen_javadoc_autobrief=0

" Use custom colors for Doxygen syntax highlighting.
highlight link doxygenBrief Comment
highlight link doxygenSpecialOneLineDesc Comment
highlight link doxygenSpecialTypeOneLineDesc Comment
highlight link doxygenArgumentWord doxygenParamName
highlight link doxygenCodeWord doxygenParamName
highlight doxygenStart guifg=#494949
highlight doxygenStartL guifg=#494949
highlight doxygenBOther guifg=#494949
highlight doxygenSmallSpecial guifg=#494949
highlight doxygenSpecial guifg=#494949
highlight doxygenParam guifg=#494949

" Custom cursor line number background color.
hi CursorLineNr ctermfg=11 ctermbg=0

" Resize splits when the window is resized.
au VimResized * exe "normal! \<c-w>="

"-------------------------------------------------------------------------------
" Visual cues
"-------------------------------------------------------------------------------

set incsearch                        " show search matches as you type
set listchars=tab:▸\ ,trail:·        " set custom characters for non-printable
                                     " characters
set list                             " always show non-printable characters
set matchtime=3                      " set brace match time
set mps+=<:>                         " also match angle brackets
set scrolloff=3                      " maintain more context around the cursor
set sidescrolloff=3
set linebreak                        " wrap lines at logical word boundaries
set showbreak=↪                      " character to display in front of wrapper
                                     " lines
set showmatch                        " enable brace highlighting
set smartcase                        " ignore case if search pattern is all
                                     " lowercase, case-sensitive otherwise
set visualbell                       " only show a visual cue when an error
                                     " occurs
set laststatus=2                     " always show the status line
set cursorline                       " highlight current cursor line

" Absolute line numbers when in insert mode, relative line numbers when in
" normal mode.
set relativenumber
autocmd InsertEnter * set norelativenumber
autocmd InsertLeave * set relativenumber

"-------------------------------------------------------------------------------
" Behavioural settings
"-------------------------------------------------------------------------------

set autoread                         " automatically reload a file when it has
                                     " been changed
set backup                           " enable backups
set undofile                         " enable persistent undo
set clipboard=unnamed                " use the system clipboard by default
set hidden                           " be able to put the current buffer to the
                                     " background without writing to disk and
                                     " remember marks and undo-history when a
                                     " background buffer becomes current again
set history=50                       " keep 50 lines of command line history
set printoptions=paper:a4,duplex:on  " print on a4 by default and enable duplex
                                     " printing
set nostartofline                    " do not change the X position of the
                                     " cursor when paging up and down

" Setup swap, backup, persistent undo and spell file runtime directories.
set dir=$HOME/.local/share/nvim/swap
set backupdir=$HOME/.local/share/nvim/backup
set undodir=$HOME/.local/share/nvim/undo
set spellfile=$HOME/.local/share/nvim/dict.add

"-------------------------------------------------------------------------------
" Key remappings
"-------------------------------------------------------------------------------

" Leader + 2 toggles between paste modes.
nmap <silent> <leader>2 :set paste!<CR>

" Map Ctrl-BackSpace to delete the previous word. Needs <C-h> remap as well
" for terminal Vim.
noremap! <C-BS> <C-w>
noremap! <C-h> <C-w>

" Quickly edit and reload the vimrc file.
nmap <silent> <leader>ov :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" Map Y to copy to the end of the line (which is more logical, also according
" to the Vim manual).
map Y y$

" Remap Ctrl-s to save the current file.
map <silent> <C-s> :w<CR>
imap <silent> <C-s> <Esc>:w<CR>a

" Switch Ctri-i and Ctrl-o, jumping backwards using Ctrl-i and forwards using
" Ctrl-o seems more logical given the keyboard layout.
nnoremap <C-i> <C-o>
nnoremap <C-o> <C-i>

" Remap Ctrl-q to close the current buffer
nmap <silent> <C-q> :bw!<CR>

" Remap K to do nothing instead of searching the man pages.
nnoremap K <nop>

" Remap Q to do nothing instead of entering ex mode.
nnoremap Q <nop>

" Parse Make results.
function! AsyncMakeOnExit(job_id, data, event) dict
  " It is possible that the user stopped the make, in which case the build
  " results will not be available.
  if filereadable(self.build_log)
    silent exe "cfile " . self.build_log
    silent exe "cw"
  endif
endfunction

" Starts an asynchronous make.
function! AsyncMake()
  " Close the error window in Neovim.
  silent exe "ccl"

  " Create a temporary file that will hold the build output.
  let build_log = substitute(system('mktemp'), '\n$', '', '')

  " Start the build, and redirect all build output to the given log file.
  call jobstart(
  \ ['sh', '-c', ' i3-show-build-output.sh "' . &makeprg . '" ' . build_log],
  \ {'on_exit': function('AsyncMakeOnExit'), 'build_log': build_log})
endfunction

" Remap <leader>m to execute an asynchronous make.
nmap <silent> <leader>m :call AsyncMake()<CR>

" Remap Ctrl-k and Ctrl-j to jump to the previous and next compiler error
" respectively.
nmap <silent> <C-k> :cp<CR>
nmap <silent> <C-j> :cn<CR>

" Remap backspace to switch to the previous buffer.
map <silent> <BS> :b#<CR>

" Open URL under cursor
nmap <silent> <leader>o :!xdg-open <C-R>=escape("<cword>", "#&;\|%")<CR><CR>

"-------------------------------------------------------------------------------
" Configure plugins
"-------------------------------------------------------------------------------

" Enable plugin support based on filetypes.
filetype on
filetype plugin on
filetype indent on

" Configure fzf.
function! Fzf(source, sink, window)
  call fzf#run({
        \ 'source': a:source,
        \ 'window': a:window,
        \ 'sink': a:sink,
        \ })
endfunction

" Use rg_args to specify additional arguments to use when calling rg. Usually
" this is used to specify specific file globbing parameters. For example:
"
"  let g:rg_args = "-g '*.cpp' -g '*.h' -g '*.hpp'"
"
let g:rg_args = ''

" Command for manual Rg invocation.
command! -bang -nargs=1 Rg
    \ call fzf#vim#grep('rg -n --column '.g:rg_args.' '.shellescape(<f-args>), 0, <bang>0)

" Search for word under cursor using rg.
" TODO Use Rg command here.
nmap <leader>g :call fzf#vim#grep('rg -n --column '.g:rg_args.' '.shellescape(expand('<cword>')), 1)<CR>

" Search man pages for word under cursor and open it if available in a
" vertical split.
nmap K :Man<CR>

" Set the command to use for retrieving all input for fzf (custom setting). By
" default, we use rg for this, since rg has nice support for automatically
" ignoring all files listed in .gitignore.

" Set the layout of the result window (custom setting).
let g:fzf_window = 'vertical rightbelow 40new'

nnoremap <leader>e :call Fzf('rg ' . g:rg_args . ' --files', 'e', g:fzf_window)<CR>
nnoremap <leader>s :call Fzf('rg ' . g:rg_args . ' --files', 'sp', g:fzf_window)<CR>
nnoremap <leader>b :Buffers<CR>

" Switch between header and implementation using F4.
map <F4> :Alternate<CR>

" Configure the search paths to look for include/source files.
let g:AlternatePaths = ['../include', '../src', '.', '..']

" Do not let Vim pasta remap default p and P mapping for pasting. We use
" miniyank for that, and call vim-pasta from miniyank remappings.
let g:pasta_paste_before_mapping = '<leader>vP'
let g:pasta_paste_after_mapping = '<leader>vp'

" Configure the miniyank plugin.
map <expr> p miniyank#startput("p",1)
map <C-p> <Plug>(miniyank-cycle)

" Enable label mode, allows jumping to a match further down in the list
" sequence much faster.
let g:sneak#label = 1
" Enable clever-s; repeat search by pressing 's' again.
let g:sneak#s_next = 1

" Set path for private snippets used by UltiSnips.
let g:UltiSnipsSnippetsDir = '~/.config/nvim/UltiSnips'

"-------------------------------------------------------------------------------
" Configure (keyword) completion
"-------------------------------------------------------------------------------

" Remap Ctrl-j and Ctrl-k to move up and down in popup lists.
inoremap <silent> <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <silent> <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"

" Open the completion menu using C-Space, note that C-Space inserts the <Nul> character.
inoremap <silent> <expr> <Nul> pumvisible() ? "" : "\<C-X>\<C-U>\<Down>"

" Configure (keyword) completion.
set completeopt=menuone

" Do not scan Boost include files.
set include=^\\s*#\\s*include\ \\(<boost/\\)\\@!

"-------------------------------------------------------------------------------
" LSP related settings (in Lua since Neovim hates Vimscript)
"-------------------------------------------------------------------------------

" Configures autocompletion through nvim-cmp.
" luafile ~/.config/nvim/lua/lsp.lua

" Custom auto completion; trigger a completion request when typing characters
" at the end of some keyword.
" autocmd TextChangedI,TextChangedP *.c,*.h call s:autocomplete()
function! s:autocomplete() abort
lua <<EOF
  -- Only autocomplete in case completion was requested manually.
  local cmp = require('cmp')
  if not cmp.visible() then
      return
  end

  local line = vim.api.nvim_get_current_line()
  local cursor = vim.api.nvim_win_get_cursor(0)[2]

  local before_cursor = string.sub(line, 1, cursor)
  local after_cursor = string.sub(line, cursor + 1, -1)
  if string.match(before_cursor, '[%w_]+$') and string.match(after_cursor, '%s*$') then
      cmp.complete()
  end
EOF
endfunction

"-------------------------------------------------------------------------------
" File type specific settings
"-------------------------------------------------------------------------------

" Automatically remove trailing whitespace before write.
function! StripTrailingWhitespace()
  normal mZ
  %s/\s\+$//e
  normal `Z
endfunction

" Strip trailing white spaces in source code.
au BufWritePre .vimrc,*.js,*.cpp,*.hpp,*.php,*.h,*.c,*.tcl :call StripTrailingWhitespace()

" Syntax highlighting for Qt qmake project files.
au BufEnter *.pro setlocal syntax=pro

" Set tab stop to 1 for Qt UI definition files.
au BufEnter *.ui setlocal tabstop=1
au BufEnter *.ui setlocal shiftwidth=1

" Set tab stop to 1 for CMake files.
au BufEnter CMakeLists.txt setlocal tabstop=2
au BufEnter CMakeLists.txt setlocal shiftwidth=2

" Set tab stop to 4 for Vimscript files.
au BufEnter *.vim setlocal tabstop=4
au BufEnter *.vim setlocal shiftwidth=4

" Do not expand tabs for web related source code.
au BufEnter *.php,*.html,*.css,*.js setlocal noexpandtab

" Set text width for Git commit messages.
au FileType gitcommit setlocal textwidth=72
au FileType gitcommit setlocal spell spelllang=en_us

" Set text width for Changelogs, and do not expand tabs.
au BufEnter Changelog setlocal textwidth=80
au BufEnter Changelog setlocal expandtab

" Set text width for reStructured text.
au BufEnter *.rst setlocal textwidth=80

" Set text width for Python to 80 to allow for proper docstring and comment formatting.
au FileType python setlocal textwidth=80
au FileType python setlocal formatoptions=croqnj

" Disable syntax highlighting for XML files.
au FileType xml setlocal syntax=off

"-------------------------------------------------------------------------------
" Misc settings
"-------------------------------------------------------------------------------

" Set Python 2 and 3 applications manually to the one provided by the system
" to prevent issues when running Neovim in a sandbox.
let g:python_host_prog = '/usr/bin/python2'
let g:python3_host_prog = '/usr/bin/python3'

" Always start editing a file in case a swap file exists.
augroup SimultaneousEdits
    autocmd!
    autocmd SwapExists * :let v:swapchoice = 'e'
augroup End

" Read in a custom Vim configuration local to the working directory.
if filereadable(".project.vim")
    so .project.vim
endif

" Do not count acronyms / abbreviations as spelling errors (all upper-case
" letters, at least three characters). Also will not count acronym with 's' at
" the end as a spelling error, and will not count numbers that are part of the
" acronym.
syn match AcronymNoSpell '\<\(\u\|\d\)\{3,}s\?\>' contains=@NoSpell

" Do not match URLs.
syn match UrlNoSpell "\w\+:\/\/.\+" contains=@NoSpell
