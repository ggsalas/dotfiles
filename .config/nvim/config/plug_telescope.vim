" files & grep
nnoremap <leader>j <cmd>lua require'config.telescopeconfig'.buffer_list({ prompt_title = 'Search Buffers'})<CR>
nnoremap <leader>f <cmd>lua require'config.telescopeconfig'.find_files()<CR>
nnoremap <leader>s <cmd>SearchTelescope .<CR>
" nnoremap <leader>S <cmd>lua require'config.telescopeconfig'.grep_last_search()<CR>
nnoremap <leader>* <cmd>lua require'telescope.builtin'.grep_string({ prompt_title = 'Live Grep "under cursor" in working dir' , shorten_path = true, disable_devicons = true})<CR>
nnoremap <leader>- <cmd>lua require'config.telescopeconfig'.file_browser()<CR>
command! -complete=dir -nargs=* -bang SearchTelescope lua require'config.telescopeconfig'.grep_string(<f-args>)<cr>

" lsp mapings
nnoremap <silent>gr <cmd>lua require'telescope.builtin'.lsp_references()<CR>
nnoremap <silent>gd <cmd>lua require'telescope.builtin'.lsp_definitions()<CR>
nnoremap <silent>ga <cmd>lua require'telescope.builtin'.lsp_code_actions(require'telescope.themes'.get_dropdown())<CR>

" git mappingrequire'telescope.themes'.get_dropdown()s
nnoremap <leader>gt <cmd>lua require'telescope.builtin'.git_stash()<CR>
nnoremap <leader>gb <cmd>lua require'telescope.builtin'.git_branches()<CR>
nnoremap <leader>gc <cmd>lua require'telescope.builtin'.git_bcommits()<CR>
nnoremap <leader>gC <cmd>lua require'telescope.builtin'.git_commits()<CR>
nnoremap <leader>gf <cmd>lua require'telescope.builtin'.git_status()<CR>
command! -bang Branches lua require'telescope.builtin'.git_branches()<CR>

" vim
nnoremap <leader>gh <cmd>lua require'telescope.builtin'.help_tags({ prompt_title = 'Search Vim Help' })<cr>
nnoremap <leader>gn <cmd>lua require'telescope.builtin'.man_pages({ prompt_title = 'Search Man Pages' })<cr>
nnoremap <leader>gm <cmd>lua require'telescope.builtin'.marks({ prompt_title = 'Search Marks' })<cr>
nnoremap <leader>gq <cmd>lua require'telescope.builtin'.quickfix({ prompt_title = 'Search QuickFix list' })<cr>
nnoremap <leader>gk <cmd>lua require'telescope.builtin'.keymaps()<cr>
nnoremap <leader>z <cmd>lua require'telescope.builtin'.spell_suggest(require'telescope.themes'.get_dropdown({ prompt_title = 'Spell Suggestions' }))<cr>
nnoremap <leader>df <cmd>lua require'config.telescopeconfig'.search_dot_files()<cr>
command! -bang Dotfiles lua require'config.telescopeconfig'.search_dot_files()<cr>
command! -bang Notes lua require'config.telescopeconfig'.search_notes()<cr>
