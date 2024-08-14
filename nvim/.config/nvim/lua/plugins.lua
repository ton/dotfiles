return {
  {
    'bfredl/nvim-miniyank',
    keys = {
      { 'p', [[miniyank#startput("p`[v`]=", 1)]], expr = true },
      { 'P', [[miniyank#startput("P`[v`]=", 1)]], expr = true },
      { '<C-p>', [[<Plug>(miniyank-cycle)]] }
    },
  },
  {
    'hrsh7th/nvim-cmp',
    enabled = false,
    event = 'InsertEnter',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'neovim/nvim-lspconfig',
    },
    config = function()
      -- Configures autocompletion through nvim-cmp.
      -- require('lsp')

      -- Custom auto completion; trigger a completion request when typing characters
      -- at the end of some keyword.
      function autocomplete()
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
      end

      vim.api.nvim_create_autocmd({'TextChangedI,TextChangedP'}, {
        pattern = {'*.c', '*.h'},
        command = autocomplete
      })
    end,
  },
  {
    'jez/vim-superman',
    keys = { 'K' },
  },
  {
    'junegunn/fzf',
    keys = {
      -- fuzzy search the current project directory and open in the current buffer
      { '<leader>e', [[:call fzf#run({'source': 'rg ' . g:rg_args . ' --files', 'sink': 'e', 'right': '40%'})<CR>]], mode = 'n' },
      -- fuzzy search the current project directory and open in a new vertical split
      { '<leader>s', [[:call fzf#run({'source': 'rg ' . g:rg_args . ' --files', 'sink': 'vs', 'right': '40%'})<CR>]], mode = 'n' },
      -- fuzzy search open buffers
      { '<leader>b', [[:Buf<CR>]], mode = 'n' },
      -- search for word under cursor using Rg
      { '<leader>g', [[:call fzf#vim#grep('rg -n --column ' .g:rg_args . ' ' . shellescape(expand('<cword>')), 1)<CR>]], mode = 'n' },
    },
    cmd = 'Rg',
    init = function()
      vim.g.rg_args = ''
    end,
    dependencies = { 'junegunn/fzf.vim' },
  },
  {
    'lbrayner/vim-rzip',
    lazy = true,
    ft = '*.fgp,*.rgc,*.fnl,*.fgr',
    config = function()
      vim.g.rzipPlugin_extra_ext = '*.fgp,*.rgc,*.fnl,*.fgr'
    end,
  },
  {
    'KabbAmine/zeavim.vim',
    keys = { { 'gz'} , { '<leader>z' } }
  },
  {
    'Olical/conjure',
    ft = { 'scheme', 'scheme.guile' },
    lazy = true,
    config = function()
      vim.g['conjure#filetype#scheme'] = 'conjure.client.guile.socket'
    end,
  },
  {
    'pangloss/vim-javascript',
    ft = 'javascript'
  },
  {
    'SirVer/ultisnips',
    config = function()
      vim.g.UltiSnipsSnippetsDir = vim.fn.stdpath('config') .. '/UltiSnips'
    end,
  },
  {
    'ton/vim-alternate',
    keys = { { '<F4>', ':Alternate<CR>', 'Toggle alternate' } },
    init = function()
      vim.g.AlternatePaths = {'../include', '../src', '.', '..'}
    end,
  },
  {
    'tpope/vim-commentary',
  },
  {
    'tpope/vim-fugitive',
  },
  {
    'tpope/vim-repeat',
  },
  {
    'tpope/vim-surround',
  }
}
