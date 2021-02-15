Plug 'justinmk/vim-dirvish'                                   " file explorer 

" Replace netrw plugin
" let g:loaded_netrwPlugin = 1
" command! -nargs=? -complete=dir Explore Dirvish <args>
" command! -nargs=? -complete=dir Sexplore belowright split | silent Dirvish <args> | belowright resize 15
" command! -nargs=? -complete=dir Vexplore belowright vsplit | silent Dirvish <args> | vertical resize 50


" nmap <silent> - :<C-U>call <SID>dirvish_toggle()<CR>
" nmap <silent> _ :<C-U>call <SID>dirvish_toggle('home')<CR>
" 
" function! s:dirvish_open(cmd, bg) abort
"     let path = getline('.')
"     if isdirectory(path)
"         if a:cmd ==# 'edit' && a:bg ==# '0'
"             call dirvish#open(a:cmd, 0)
"         endif
"     else
"         if a:bg
"             call dirvish#open(a:cmd, 1)
"         else
"             bwipeout
"             execute a:cmd ' ' path
"         endif
"     endif
" endfunction
" 
" 
" function! s:dirvish_toggle(home) abort
"     let width  = float2nr(&columns * 0.4)
"     let height = float2nr(&lines * 0.8)
"     let top    = ((&lines - height) / 2) - 1
"     let left   = (&columns - width) / 2
"     let opts   = {'relative': 'editor', 'row': top, 'col': left, 'width': width, 'height': height, 'style': 'minimal' }
" 
"     let fdir = expand('%:h')
"     let path = expand('%:p')
"     call nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)
"     if fdir ==# ''
"         let fdir = '.'
"     endif
" 
"     call dirvish#open(fdir)
" 
"     if !empty(path)
"         call search('\V\^'.escape(path, '\').'\$', 'cw')
"     endif
" endfunction
" 
" augroup vimrc
"     autocmd FileType dirvish nmap <silent> <buffer> <CR>  :<C-U>call <SID>dirvish_open('edit'   , 0)<CR>
"     autocmd FileType dirvish nmap <silent> <buffer> <C-v>     :<C-U>call <SID>dirvish_open('vsplit' , 0)<CR>
"     autocmd FileType dirvish nmap <silent> <buffer> <C-V>     :<C-U>call <SID>dirvish_open('vsplit' , 1)<CR>
"     autocmd FileType dirvish nmap <silent> <buffer> <C-s>     :<C-U>call <SID>dirvish_open('split'  , 0)<CR>
"     autocmd FileType dirvish nmap <silent> <buffer> <C-S>     :<C-U>call <SID>dirvish_open('split'  , 1)<CR>
"     autocmd FileType dirvish nmap <silent> <buffer> <C-t>     :<C-U>call <SID>dirvish_open('tabedit', 0)<CR>
"     autocmd FileType dirvish nmap <silent> <buffer> <C-T>     :<C-U>call <SID>dirvish_open('tabedit', 1)<CR>
"     autocmd FileType dirvish nmap <silent> <buffer> -     <Plug>(dirvish_up)
"     autocmd FileType dirvish nmap <silent> <buffer> <ESC> :bd<CR>
"     autocmd FileType dirvish nmap <silent> <buffer> q     :bd<CR>
"     autocmd FileType dirvish nmap <silent> <buffer> gq     :bd<CR>
" augroup END

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
