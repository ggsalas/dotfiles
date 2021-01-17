" To find text inside files install globally rg: https://github.com/BurntSushi/ripgrep

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" remove file preview
let g:fzf_preview_window = ''
let g:fzf_history_dir = '~/.local/share/fzf-history'
let g:fzf_layout = { 'down': '40%' }
" let g:fzf_layout = { 'window': { 'width': 1, 'height': 0.4, 'yoffset': 1, 'border': 'none' } }
" let g:fzf_action = {
"   \ 'ctrl-d': 'bd',
"   \ 'ctrl-t': 'tab split',
"   \ 'ctrl-x': 'split',
"   \ 'ctrl-v': 'vsplit' }

" Close with Esc
autocmd! FileType fzf tnoremap <buffer> <Esc> <c-c>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Functios
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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

" using fzf to search for a file and generate a relative path
" relative to the current buffer
" https://github.com/FabioAntunes/dotfiles/blob/c05f7ff3dc6061068b6de39485f5ff801cc557db/nvim/config/plugins-keymaps.vim
function! s:make_path(path)
  let l:currentFile = expand('%:p:h')
  let l:filePath = fnamemodify(join(a:path), ":p")

  " my implementation to generate relative paths, a golang binary
  " check if it exists, if not we default to perl
  if executable("rel-path")
    let l:relPath = system("rel-path " . l:filePath . " " . l:currentFile)
  else
    let l:relPath = system("perl -e 'use File::Spec; print File::Spec->abs2rel(@ARGV) . \"\n\"' " . l:filePath . " " . l:currentFile)
    if l:relPath !~ '^\.\.\/'
      let l:relPath = \"./" . l:relPath
    endif
  endif

  " strip extensions from the file, if it's tsx? jsx?
  " or strip the entire name if it's an "index.jsx?" or "index.tsx?"
  return substitute(l:relPath, '\(\(\/index\)\?\(\.tsx\?\|\.jsx\?\)\)\?\n\+$', '', '')
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Commands
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Ag search only on file contents
command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, {'options': '--delimiter : --nth 4..'}, <bang>0)

" Create a new note inside note folder
command! -nargs=1 -bang NoteNew :e ~/Google Drive/Notas/<args><bang>

" list and search inside notes folder
command! -bang NoteList call NoteList()<bang>
command! -bang NoteSearch call NoteSearch()<bang>

" Delete buffers
" https://github.com/junegunn/fzf.vim/pull/733#issuecomment-559720813
function! s:list_buffers()
  redir => list
  silent ls
  redir END
  return split(list, "\n")
endfunction

function! s:delete_buffers(lines)
  execute 'bwipeout' join(map(a:lines, {_, line -> split(line)[0]}))
endfunction

command! BD call fzf#run(fzf#wrap({
  \ 'source': s:list_buffers(),
  \ 'sink*': { lines -> s:delete_buffers(lines) },
  \ 'options': '--multi --bind ctrl-a:select-all'
\ }))


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" complete relative file path
inoremap <expr> <c-x><c-f> fzf#complete(fzf#wrap({
  \ 'source':  'ag -g ""',
  \ 'reducer': function('<sid>make_path')}))

" complete lines
inoremap <expr> <c-x><c-l> fzf#vim#complete(fzf#wrap({
  \ 'prefix': '^.*$',
  \ 'source': 'rg -n ^ --color always',
  \ 'options': '--ansi --delimiter : --nth 3..',
  \ 'reducer': { lines -> join(split(lines[0], ':\zs')[2:], '') }}))

" nnoremap <leader><leader> :Commands<CR>

" File search
nnoremap <leader>f :call FzfOmniFiles()<CR>
nnoremap <leader>gf :GFiles?<CR>
nmap <leader>s :Ag<CR>
" Buffers
nmap <leader>j :Buffers<CR>
nmap <leader>J :BD<CR>
nnoremap <leader>k :b#<CR>
nnoremap <leader>bn :bn<CR>
nnoremap <leader>bm :bm<CR>

" nnoremap <leader>S :Ag<C-r>=txt<CR>
" search word under cursor
nnoremap <silent> <Leader>S :Ag <C-R><C-W><CR>
vnoremap <silent> <Leader>S :Ag <C-R><C-W><CR>
