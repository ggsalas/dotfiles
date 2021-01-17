function! s:SourceConfigFile(fileName)
  execute 'source' '~/.config/nvim/config/' . a:fileName . '.vim'
endfunction

call s:SourceConfigFile('main_settings')
call s:SourceConfigFile('main_mappings')

call plug#begin()
  call s:SourceConfigFile('main_visual')
  call s:SourceConfigFile('main_undo')
  call s:SourceConfigFile('plug_coc')
  call s:SourceConfigFile('plug_dirvish')
  call s:SourceConfigFile('plug_grep')
  call s:SourceConfigFile('plug_slime')
  call s:SourceConfigFile('plug_sneak')
  call s:SourceConfigFile('plug_fzf')
  call s:SourceConfigFile('plug_test')
  call s:SourceConfigFile('plug_syntax')
  call s:SourceConfigFile('plug_markdown')

  " Plugins witout config
  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  Plug 'pbrisbin/vim-mkdir'                                     " create new dirs on save file
  Plug 'tpope/vim-fugitive'                                     " Git 
  Plug 'itchyny/vim-gitbranch'                                  " Git branch name
  Plug 'tomtom/tcomment_vim'

  " helpers
  Plug 'tmhedberg/matchit'                                      " extendeds % matching
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-unimpaired'                                   " userful mappings

  Plug 'machakann/vim-highlightedyank'
  Plug 'tpope/vim-rhubarb'                                      " Github

  " extras
  " Plug 'godlygeek/tabular'                                      " tables format, and more.
  " Plug 'christoomey/vim-tmux-navigator'                         " same navigation for vim and tmux
call plug#end()
