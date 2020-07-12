" To find text inside files install globally rg: https://github.com/BurntSushi/ripgrep

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

"FZF decide what file find to use
function! FzfOmniFiles()
  let is_git = system('git status')

  if v:shell_error
    :Files
  else
    :GitFiles
  endif
endfunction

" Notes
function! NoteList()
  let path = getcwd()
  execute "cd ~/Google Drive/Notas/"
  execute FzfOmniFiles()
  execute "cd ".path
endfunction

function! NoteSearch()
  let path = getcwd()
  execute "cd ~/Google Drive/Notas/"
  execute "Ag"
  execute "cd ".path
endfunction

let g:fzf_preview_window = ''
" Ag search only on file contents
command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, {'options': '--delimiter : --nth 4..'}, <bang>0)

inoremap <expr> <c-x><c-f> fzf#vim#complete#path(
    \ "find . -path '*/\.*' -prune -o -print \| sed '1d;s:^..::'",
    \ fzf#wrap({'dir': expand('%:p:h')}))

let g:fzf_history_dir = '~/.local/share/fzf-history'

inoremap <expr> <c-x><c-l> fzf#vim#complete(fzf#wrap({
  \ 'prefix': '^.*$',
  \ 'source': 'rg -n ^ --color always',
  \ 'options': '--ansi --delimiter : --nth 3..',
  \ 'reducer': { lines -> join(split(lines[0], ':\zs')[2:], '') }}))


command! -nargs=1 -bang NoteNew :e ~/Google Drive/Notas/<args><bang>
command! -bang NoteList call NoteList()<bang>
command! -bang NoteSearch call NoteSearch()<bang>

" Mappings
nnoremap <leader><leader> :Commands<CR>

" File search
nmap   :Ag<CR>
nnoremap <C-p> :call FzfOmniFiles()<CR>

nnoremap <leader>f :call FzfOmniFiles()<CR>
nmap <leader>s :Ag<CR>

" Buffers
nmap <leader>b :Buffers<CR>
nnoremap <silent> <leader>] :bn<CR>
nnoremap <silent> <leader>[ :bp<CR>

" Close with Esc
autocmd! FileType fzf tnoremap <buffer> <Esc> <c-c>

