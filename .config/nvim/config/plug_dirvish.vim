Plug 'justinmk/vim-dirvish'                                   " file explorer 

" Replace netrw plugin
let g:loaded_netrwPlugin = 1
command! -nargs=? -complete=dir Explore Dirvish <args>
command! -nargs=? -complete=dir Sexplore belowright split | silent Dirvish <args> | belowright resize 15
command! -nargs=? -complete=dir Vexplore belowright vsplit | silent Dirvish <args> | vertical resize 50

" Sort folders first, then files
let g:dirvish_mode = ':sort ,^.*[\/],'

" vim-dirvish
nnoremap _ :Explore<CR>
nnoremap <leader>e :Vex %<CR>
nnoremap <leader>E :Vex<CR>

augroup dirvish_config
  autocmd!

  " Map `gh` to hide dot-prefixed files.  Press `R` to "toggle" (reload).
  autocmd FileType dirvish nnoremap <silent><buffer>
    \ gh :silent keeppatterns g@\v/\.[^\/]+/?$@d _<cr>:setl cole=3<cr>

  " Map `t` to open in new tab.
  autocmd FileType dirvish
    \  nnoremap <silent><buffer> t :call dirvish#open('tabedit', 0)<CR>
    \ |xnoremap <silent><buffer> t :call dirvish#open('tabedit', 0)<CR>

  " Map `o` to open in same buffer
  autocmd FileType dirvish
    \  nnoremap <silent><buffer> o :call dirvish#open('edit', 0)<CR>
    \ |xnoremap <silent><buffer> o :call dirvish#open('edit', 0)<CR>

  " New Folder
  autocmd FileType dirvish
    \  nnoremap <buffer> md :!mkdir %

  " New File
  autocmd FileType dirvish
    \  nnoremap <buffer> mm :e %
augroup END
