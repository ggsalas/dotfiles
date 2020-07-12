Plug 'jpalardy/vim-slime'                                     " 

" Slime
let g:slime_target = "neovim"

" command! -nargs=* T split | terminal <args>
" command! -nargs=* VT vsplit | terminal <args>

noremap <leader>n :vertical belowright split term://node<cr>:echo b:terminal_job_id<cr>

" let g:slime_target = "tmux"
" let g:slime_default_config = {"socket_name": get(split($TMUX, ","), 0), "target_pane": ":.2"}
" noremap <leader>t. :SlimeSend1 yarn run test --findRelatedTests <c-r>%<CR>


