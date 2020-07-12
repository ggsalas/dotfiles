Plug 'simnalamburt/vim-mundo'

nnoremap <Leader>u :MundoToggle<CR>

" Undo persistent after close file
set undofile
set undodir=$HOME/.vimUndoFiles
set undolevels=5000
