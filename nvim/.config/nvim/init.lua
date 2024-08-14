--------------------------------------------------------------------------------
-- Text formatting
--------------------------------------------------------------------------------

vim.o.expandtab = true                      -- insert spaces when the tab key is pressed
vim.o.shiftround = true                     -- use multiple of shiftwidth when indenting
                                            -- with '<' and '>'
vim.o.tabstop = 4                           -- a tab is four spaces, ensure both shiftwidth
vim.o.shiftwidth = 0                        -- and softtabstop always equal tabstop
vim.o.softtabstop = -1
vim.o.wrap = true                           -- wrap overlong lines

vim.o.cino = 'g0'                           -- do not indent public/protected/private

--------------------------------------------------------------------------------
-- UI settings
--------------------------------------------------------------------------------

vim.cmd.colorscheme('wombat')               -- nice colorscheme

vim.o.termguicolors = true                  -- enable 24-bit colors

vim.o.backspace = 'indent,eol,start'        -- allow backspacing over everything in
                                            -- insert mode
vim.o.number = true                         -- always show line numbers
vim.o.numberwidth = 5                       -- we are good for up to 99999 lines
vim.o.splitright = true                     -- open vertical splits on the right side
vim.o.mouse = 'a'                           -- allow for mouse scrolling in tmux
vim.o.wildmenu = true                       -- add command-line completion menu
vim.o.inccommand = ''                       -- disable command preview

--------------------------------------------------------------------------------
-- Visual cues
--------------------------------------------------------------------------------

vim.o.listchars = 'tab:▸ ,trail:·,nbsp:␣'   -- set custom characters for non-printable
                                            -- characters
vim.o.list = true                           -- always show non-printable characters
vim.o.matchtime = 3                         -- set brace match time
vim.o.matchpairs = '(:),[:],{:},<:>'        -- also match angle brackets
vim.o.scrolloff = 3                         -- maintain more context around the cursor
vim.o.sidescrolloff = 3
vim.o.linebreak = true                      -- wrap lines at logical word boundaries
vim.o.showbreak = '↪'                       -- character to display in front of wrapped
                                            -- lines
vim.o.showmatch = true                      -- enable brace highlighting
vim.o.smartcase = true                      -- ignore case if search pattern is all
                                            -- lowercase, case-sensitive otherwise
vim.o.visualbell = true                     -- only show a visual cue when an error
                                            -- occurs
vim.o.laststatus = 2                        -- always show the status line
vim.o.cursorline = true                     -- highlight current cursor line
vim.o.relativenumber = true                 -- absolute line numbers in insert mode, relative line numbers in normal mode

---------------------------------------------------------------------------------
-- Behavioural settings
---------------------------------------------------------------------------------

vim.o.autoread = true                       -- automatically reload a file when it has been changed
vim.o.backup = true                         -- enable backups
vim.o.backupdir = vim.fn.stdpath('state') .. '/backup'
vim.o.undofile = true                       -- enable persistent undo
vim.o.clipboard = 'unnamedplus'             -- use the system clipboard by default
vim.o.history = 50                          -- keep 50 lines of command line history

vim.g.mapleader = '\\'
vim.g.maplocalleader = ';'

---------------------------------------------------------------------------------
-- Initialize Lazy.nvim
---------------------------------------------------------------------------------

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
require('lazy').setup('plugins')

---------------------------------------------------------------------------------
-- Key mappings
--
-- The <leader> part in the shortcuts below is configurable and set to '\' in
-- this configuration.
---------------------------------------------------------------------------------

vim.keymap.set('!', '<C-h>', '<C-w>', { noremap = true }) -- delete previous word (enables C-BS as well)

vim.keymap.set('', 'Y', 'y$', {})                         -- map Y to copy to the end of the line (which is more logical, also according to the Vim manual)
vim.keymap.set('', '<C-s>', '<ESC>:w<CR>a', {})           -- save the current file

vim.keymap.set('n', '<leader>2', ':set paste!<CR>', {})   -- toggle between paste modes
vim.keymap.set('n', '<leader>oc', ':e $MYVIMRC<CR>', {})  -- quickly open Neovim configuration

vim.keymap.set('n', '<C-q>', ':bw!<CR>', {})              -- close current buffer
vim.keymap.set('n', '<C-s>', ':w<CR>', {})                -- save the current file

vim.keymap.set('n', '<C-k>', ':cp<CR>', {})               -- jump to previous/next error
vim.keymap.set('n', '<C-j>', ':cn<CR>', {})

vim.keymap.set('n', '<C-o>', '<C-i>', { noremap = true })
vim.keymap.set('n', '<Tab>', '<C-o>', { noremap = true }) -- swap C-i and C-o, seems more logical
vim.keymap.set('n', 'Q', '<nop>', { noremap = true })     -- remap Q to do nothing instead of entering ex mode

vim.keymap.set('', '<BS>', ':b#<CR>', {})                 -- remap backspace to switch to the previous buffer

--------------------------------------------------------------------------------
-- Auto commands
--------------------------------------------------------------------------------

-- Automatically resize Vim windows in case the terminal window resizes.
vim.api.nvim_create_autocmd('VimResized', { command = 'wincmd =' })

-- Always start editing a file in case a swap file exists.
vim.api.nvim_create_autocmd('SwapExists', { command = "let v:swapchoice = 'e'" })

-- Strip trailing white spaces in source code.
vim.api.nvim_create_autocmd({'BufWritePre'}, {
    pattern = {'.vimrc', '*.js', '*.cpp', '*.hpp', '*.php', '*.h', '*.c', '*.tcl', '*.java', '*.py', 'CMakeLists.txt', '*.lua'},
    command = [[%s/\s\+$//e]],
})

--------------------------------------------------------------------------------
-- Misc settings
--------------------------------------------------------------------------------

-- Set Python 2 and 3 applications manually to the one provided by the system
-- to prevent issues when running Neovim in a sandbox.
vim.g.python_host_prog = '/usr/bin/python2'
vim.g.python3_host_prog = '/usr/bin/python3'

-- Read in a custom Vim configuration local to the working directory.
if vim.loop.fs_stat('.project.vim') then
    vim.cmd('source .project.vim')
end

-- Do not count acronyms / abbreviations as spelling errors (all upper-case
-- letters, at least three characters). Also will not count acronym with 's' at
-- the end as a spelling error, and will not count numbers that are part of the
-- acronym.
vim.cmd.syntax([[match AcronymNoSpell '\<\(\u\|\d\)\{3,}s\?\>' contains=@NoSpell]])

-- Do not match URLs.
vim.cmd.syntax([[match UrlNoSpell '\w\+:\/\/.\+' contains=@NoSpell]])

---------------------------------------------------------------------------------
-- Configure (keyword) completion
---------------------------------------------------------------------------------

-- Remap Ctrl-j and Ctrl-k to move up and down in popup lists.
vim.keymap.set('i', '<C-j>', [[pumvisible() ? "\<C-n>" : "\<C-j>"]], { silent = true, expr = true })
vim.keymap.set('i', '<C-k>', [[pumvisible() ? "\<C-p>" : "\<C-k>"]], { silent = true, expr = true })

-- Do not scan Boost include files.
vim.o.include = [[^\\s*#\\s*include\ \\(<boost/\\)\\@!]]

---------------------------------------------------------------------------------
-- File type specific settings
---------------------------------------------------------------------------------

-- Syntax highlighting for Qt qmake project files.
vim.api.nvim_create_autocmd('BufEnter', { pattern = '*.pro', command = 'setlocal syntax=pro' })

-- Set tab stop to 1 for Qt UI definition files.
vim.api.nvim_create_autocmd('BufEnter', { pattern = '*.ui', command = 'setlocal tabstop=1' })

-- Treat SWIG files as C++ files, good enough.
vim.api.nvim_create_autocmd('BufEnter', { pattern = '*.i', command = 'setlocal filetype=cpp' })

-- Treat Scons files as Python files.
vim.api.nvim_create_autocmd('BufEnter', { pattern = 'SConscript', command = 'setlocal filetype=python' })

-- Set tab stop to 2 for CMake and Lua files.
vim.api.nvim_create_autocmd('BufEnter', { pattern = {'CMakeLists.txt', '*.lua'}, command = 'setlocal tabstop=2' })

--" Set tab stop to 4 for Vimscript files.
vim.api.nvim_create_autocmd('BufEnter', { pattern = {'*.vim'}, command = 'setlocal tabstop=4' })

-- Do not expand tabs for web related source code.
vim.api.nvim_create_autocmd('BufEnter', { pattern = {'*.php', '*.html', '*.css', '*.js'}, command = 'setlocal noexpandtab' })

-- Do not expand tabs in Git configuration files.
vim.api.nvim_create_autocmd('FileType', { pattern = {'gitconfig'}, command = 'setlocal noexpandtab' })

-- Set text width for Git commit messages and enable spell checking.
vim.api.nvim_create_autocmd('FileType', { pattern = {'gitcommit'}, command = 'setlocal textwidth=72 | setlocal spell spelllang=en_us' })

-- Set text width for change logs and enable spell checking.
vim.api.nvim_create_autocmd('BufEnter', { pattern = {'Changelog'}, command = 'setlocal textwidth=80 | setlocal expandtab | setlocal spell spelllang=en_us' })

-- Set text width for reStructured text.
vim.api.nvim_create_autocmd('BufEnter', { pattern = {'*.rst'}, command = 'setlocal textwidth=80' })

-- Set text width for Python to 80 to allow for proper docstring and comment
--formatting.
vim.api.nvim_create_autocmd('FileType', { pattern = {'python'}, command = 'setlocal textwidth=80 | setlocal fo=croqnj' })

-- Disable syntax highlighting for XML files.
vim.api.nvim_create_autocmd('FileType', { pattern = {'xml'}, command = 'setlocal syntax=off' })

---------------------------------------------------------------------------------
-- Asynchronous build in combination with a floating i3 build output window
---------------------------------------------------------------------------------

-- Start an asynchronous make.
function async_make()
  -- Close the error window in Neovim.
  vim.cmd('ccl')

  -- Create a temporary file that will hold the build output.
  local build_log = vim.fn.substitute(vim.fn.system('mktemp'), '\n$', '', '')

  -- Start the build, and redirect all build output to the given log file.
  vim.loop.spawn('i3-show-build-output.sh', { args = { vim.o.makeprg, build_log }, detached = true },
    function(code, signal)
      vim.schedule(function()
        if vim.fn.filereadable(build_log) then
          vim.cmd('cfile ' .. build_log)
          vim.cmd('cw')
        end
      end)
    end
  )
end

-- Remap <leader>m to execute an asynchronous make.
vim.keymap.set('', '<leader>m', async_make, { silent = true })
