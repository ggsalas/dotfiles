Plug 'justinmk/vim-dirvish'                                   " file explorer 

" Replace netrw plugin
" let g:loaded_netrwPlugin = 1
" command! -nargs=? -complete=dir Explore Dirvish <args>
" command! -nargs=? -complete=dir Sexplore belowright split | silent Dirvish <args> | belowright resize 15
" command! -nargs=? -complete=dir Vexplore belowright vsplit | silent Dirvish <args> | vertical resize 50

nnoremap _ :Dirvish<CR>

" Sort folders first, then files
let g:dirvish_mode = ':sort ,^.*[\/],'

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



""
" Netrw
""
" vim-dirvish
nnoremap <leader>- :Explore<CR>
" nnoremap <leader>e :Vex %<CR>
" nnoremap <leader>E :Vex<CR>



let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 0
let g:netrw_winsize = 20
let g:netrw_altv= 1

" function! NetrwMappings()
"     " Hack fix to make ctrl-l work properly
"     " noremap <buffer> <A-l> <C-w>l
"     " noremap <buffer> <C-l> <C-w>l
"     noremap <silent> _ :call ToggleNetrw()<CR>
"     noremap <buffer> T :call OpenTab()<cr>
" endfunction
"
" augroup netrw_mappings
"     autocmd!
"     autocmd filetype netrw call NetrwMappings()
" augroup END
