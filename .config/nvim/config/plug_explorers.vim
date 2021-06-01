Plug 'justinmk/vim-dirvish'                                   " file explorer 
Plug 'kyazdani42/nvim-tree.lua'

nnoremap _ :Dirvish<CR>
nnoremap <leader>_ :NvimTreeFindFile<CR>

let g:nvim_tree_auto_close = 1
let g:nvim_tree_quit_on_open = 1
let g:nvim_tree_show_icons = {
    \ 'git': 1,
    \ 'folders': 1,
    \ 'files': 0,
    \ }

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

  " Faster navigation (instead enter)
  autocmd FileType dirvish
        \ nnoremap <silent><buffer>l :call dirvish#open('edit', 0)<CR>

  " Faster navigation (instead -)
  autocmd FileType dirvish
        \ nmap <buffer> h <Plug>(dirvish_up)

  " Move 1 item
  autocmd FileType dirvish
        \ nnoremap <buffer>m :!mv <C-R>=expand('<cfile>:p', 0)<CR> <C-R>=expand('<cfile>:p', 0)<CR>

  " New File
  autocmd FileType dirvish
        \ nnoremap <buffer>e :e <C-R>=expand('%', 0)<CR>

  " No support for 2 chars conceal
  " https://github.com/justinmk/vim-dirvish/issues/145
  "
  " autocmd FileType dirvish 
  "       \ call dirvish#add_icon_fn({p -> luaeval("require('nvim-web-devicons').get_icon(vim.fn.fnamemodify('" .. p .. "', ':e')) or ' '")})

augroup END

""
" NvimTree
""
" nnoremap <leader>- :NvimTreeToggle<CR>
" nnoremap <leader>-r :NvimTreeRefresh<CR>

""
" Netrw
""
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 0
let g:netrw_winsize = 20
let g:netrw_altv= 1
  
" vim-dirvish
" nnoremap <leader>- :Explore<CR>
" nnoremap <leader>e :Vex %<CR>
" nnoremap <leader>E :Vex<CR>

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
