" search current selection
function! s:VSetSearch(cmdtype)
  let temp = @s
  norm! gv"sy
  let @/ = '\V' . substitute(escape(@s, a:cmdtype.'\'), '\n', '\\n', 'g')
  let @s = temp
endfunction

" Paste banch name
function! Branch()
  return  gitbranch#name()
endfunction

" Map leader
nnoremap <SPACE> <Nop>
let mapleader=" "
let maplocalleader=" "

" clear screen (alt-l)
noremap ¬ <C-l>

" copy and paste with the system register
noremap y "+y
noremap yy <S-V>"+y<esc>
inoremap <C-r>r <C-r>+
cnoremap <C-r>r <C-r>+

" Paste not replace the copy in visual mode
xnoremap p pgvy 

" Use %% on the command line to expand to the dir of the current file
cnoremap %% <C-R>=fnameescape(expand("%:h")) . "/" <CR>

" Copy path current buffer
nnoremap <Leader>c :let @+=expand('%:p')<CR>

" zoom a vim pane, <C-w>= to re-balance
nnoremap <leader>- :wincmd _<cr>:wincmd \|<cr>
nnoremap <leader>= :wincmd =<cr>

" Re-select the last pasted text text Normal
nnoremap gp `[v`]

" close quick fix on "enter" and open with "o"
autocmd FileType qf nnoremap <buffer> <CR> <CR>:cclose<CR>
autocmd FileType qf nnoremap <buffer> o <CR>

" replace and save quick fix list
command! -bang QuickFix :copen<bang>
command -nargs=1 QuickFixDoMacro :cdo execute "norm @<args>" | update
command -nargs=1 QuickFixDoReplace :cdo %s/<args> | update
command! -bang QuickFixUpdate :cdo update<bang>
" command! -bang QuickFixClean :call setqflist([])<bang>


" Tabs & splits
nmap <silent> <C-j> :wincmd j<CR>
nmap <silent> <C-k> :wincmd k<CR>
nmap <silent> <C-h> :wincmd h<CR>
nmap <silent> <C-l> :wincmd l<CR>
nmap <silent> <leader>t :tabnew<CR>
" noremap <Leader>s :<C-u>split<CR>
" noremap <Leader>v :<C-u>vsplit<CR>

" Disable arrow movement, resize splits instead.
nnoremap <Up>    :resize -2<CR>
nnoremap <Down>  :resize +2<CR>
nnoremap <Left>  :vertical resize -2<CR>
nnoremap <Right> :vertical resize +2<CR>

" Moovments
nnoremap <C-u> <S-M><C-U>zz
nnoremap <C-d> <S-M><C-D>zz
nmap <C-f> <C-f>zz
nmap <C-b> <C-b>zz

" Center moovments
nmap n nzz
nmap N Nzz
nmap * *zz
nmap # #zz
nmap g* g*zz
nmap g# g#zz

" so I can go up an down wrapped lines
map j gj
map k gk

" Mappings for moving lines and preserving indentation
" http://vim.wikia.com/wiki/Moving_lines_up_or_down
nnoremap ∆ :m .+1<CR>==
nnoremap ˚ :m .-2<CR>==
vnoremap ∆ :m '>+1<CR>gv=gv
vnoremap ˚ :m '<-2<CR>gv=gv

" search current selection
xnoremap * :<C-u>call <SID>VSetSearch('/')<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call <SID>VSetSearch('?')<CR>?<C-R>=@/<CR><CR>

command! -bang ColorDark call ColorDark()<bang>
command! -bang ColorLight call ColorLight()<bang>

" Config Reload
nnoremap <silent> <leader>. :lua package.loaded.config = nil <cr>:source ~/.config/nvim/init.vim <cr>:echo 'Neovim Config Reloaded' <cr>

" NewsBoat urls
command! -bang Feeds :e ~/.newsboat/urls<bang>

" Git
inoremap ∫ <C-R>=Branch()<CR>

" Execute current file with node
nmap <leader>n :!node %<CR>

" replace word under cursor, globally, with confirmation
nnoremap <Leader>r :%s/\<<C-r><C-w>\>//gc<Left><Left><Left>
vnoremap <Leader>r y :%s/<C-r>"//gc<Left><Left><Left>

if has("nvim")
  au TermOpen * tnoremap <Esc> <c-\><c-n>
  au TermOpen set nonumber
  nnoremap gq :bd!<CR>
endif

