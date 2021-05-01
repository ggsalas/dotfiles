" Plug 'simnalamburt/vim-mundo'
Plug 'mbbill/undotree'

nnoremap <Leader>u :UndotreeToggle<CR>

" Undo persistent after close file
set undofile
set undodir=$HOME/.vimUndoFiles
set undolevels=5000
