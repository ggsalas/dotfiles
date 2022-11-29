" Disable unused providers
let g:loaded_python_provider = 0
let g:loaded_python3_provider = 0
let g:loaded_ruby_provider = 0
let g:loaded_perl_provider = 0

function! s:SourceConfigFile(fileName)
  execute 'source' '~/.config/nvim/config/' . a:fileName . '.vim'
endfunction

call s:SourceConfigFile('main_settings')
call s:SourceConfigFile('main_mappings')

" Plugins
"""""""""
call plug#begin()
  call s:SourceConfigFile('main_undo')
  call s:SourceConfigFile('plug_explorers')
  call s:SourceConfigFile('plug_sneak')
  call s:SourceConfigFile('plug_grep')
  call s:SourceConfigFile('plug_test')
  call s:SourceConfigFile('plug_markdown')
  call s:SourceConfigFile('plug_comment')
  call s:SourceConfigFile('plug_syntax')
  call s:SourceConfigFile('plug_draw')
  call s:SourceConfigFile('plug_presenting')

  " plug_lsp.vim && lspconfig.lua
  Plug 'neovim/nvim-lspconfig'
  Plug 'neovim/nvim-lspconfig'
  Plug 'williamboman/nvim-lsp-installer'
  Plug 'hrsh7th/nvim-compe'
  Plug 'nvim-lua/lsp-status.nvim'

  " plug_telescope & telescopeConfig.lua
  " require fzf and rg
  Plug 'nvim-lua/popup.nvim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'nvim-telescope/telescope-fzy-native.nvim'
  Plug 'nvim-telescope/telescope-fzf-writer.nvim'
  Plug 'jose-elias-alvarez/nvim-lsp-ts-utils'
  Plug 'jose-elias-alvarez/null-ls.nvim'
  Plug 'kyazdani42/nvim-web-devicons'                           " for file icons
  Plug 'nvim-telescope/telescope-ui-select.nvim'

  " treeSitter.lua
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

  " git
  Plug 'tpope/vim-fugitive'                                     " Git 
  Plug 'tpope/vim-rhubarb'
  Plug 'itchyny/vim-gitbranch'                                  " Git branch name
  " Plug 'airblade/vim-gitgutter'
  Plug 'lewis6991/gitsigns.nvim'                                " Same as gitgutter

  " plug_search_replace
  Plug 'windwp/nvim-spectre'

  " colors
  Plug 'RRethy/nvim-base16'

  " File explorer
  Plug 'kyazdani42/nvim-tree.lua'

  " Comment
  Plug 'numToStr/Comment.nvim'
  Plug 'JoosepAlviste/nvim-ts-context-commentstring'

  " helpers
  Plug 'pbrisbin/vim-mkdir'                                     " create new dirs on save file
  Plug 'tmhedberg/matchit'                                      " extendeds % matching
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-unimpaired'                                   " userful mappings
  Plug 'machakann/vim-highlightedyank'
  Plug 'tpope/vim-eunuch'
  Plug 'tjdevries/train.nvim'
  Plug 'norcalli/nvim-colorizer.lua'

call plug#end()


" Configs after plug
""""""""""""""""""""
set termguicolors
lua require("config")
call s:SourceConfigFile('plug_telescope')
call s:SourceConfigFile('plug_lsp')
call s:SourceConfigFile('plug_search_replace')
call s:SourceConfigFile('main_visual')
