Plug 'justinmk/vim-sneak'                                     " easy motions
"
" remove search on esc
nmap <expr> <Esc> sneak#is_sneaking() ? '<Right><Left>' : ':noh<return>'

"Sneak reemplaces f and t commands and not use 's' command
map f <Plug>Sneak_s
map F <Plug>Sneak_S
map t <Plug>Sneak_t
map T <Plug>Sneak_T
nnoremap s s


" Sneak
let g:sneak#use_ic_scs = 0        " use global case sensitive
let g:sneak#f_reset = 1
" Sneak use global colors
hi! link Sneak Search        

