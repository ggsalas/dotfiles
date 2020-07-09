" To find text inside files install globally rg: https://github.com/BurntSushi/ripgrep
" spell-checker: disable

" PLUGINS
" ******************************************************************************
call plug#begin()

" main
Plug 'chriskempson/base16-vim'

Plug 'justinmk/vim-dirvish'                                   " file explorer 
Plug 'pbrisbin/vim-mkdir'                                     " create new dirs on save file
Plug 'tpope/vim-fugitive'                                     " Git 
Plug 'itchyny/vim-gitbranch'                                  " Git branch name
Plug 'tomtom/tcomment_vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}                 " LSP, completion, linting

" Coc Plugins
Plug 'neoclide/coc-prettier', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-eslint', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-json', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-css', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-git', {'do': 'yarn install --frozen-lockfile'}
Plug 'iamcco/coc-spell-checker', {'do': 'yarn install --frozen-lockfile'}

" helpers
Plug 'justinmk/vim-sneak'                                     " easy motions
Plug 'tmhedberg/matchit'                                      " extendeds % matching
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'                                   " userful mappings
Plug 'janko-m/vim-test'

Plug 'vim-scripts/grep.vim'
Plug 'machakann/vim-highlightedyank'
Plug 'tpope/vim-rhubarb'                                      " Github

" syntax
Plug 'sheerun/vim-polyglot'

" extras
Plug 'jpalardy/vim-slime'                                     " 
" Plug 'godlygeek/tabular'                                      " tables format, and more.
" Plug 'christoomey/vim-tmux-navigator'                         " same navigation for vim and tmux

call plug#end()

" BASE CONFIG
" ******************************************************************************
set expandtab         " spaces not tabs // :reatb to fix
set tabstop=2         " size of a tab
set shiftwidth=2      " size for auto/smartindent
set softtabstop=2     " a tab is this size
set smartindent       " indents for you
set autoindent        " always set autoindenting on
set smarttab          " tabs at start of lines
set list
set listchars=tab:--  " alert if I use tabs!! : retab to fix
set number            " display line numbers
set showmatch         " show matching bracket
set noswapfile
set ignorecase
set smartcase         " Use case insensitive search, except when using capital letters
set wildignorecase    " Use case insensitive search for filenames
set mouse=a
set path+=**          " Search files into subfolders
set hidden            " Required for operations modifying multiple buffers like rename.
set iskeyword+=-      " Allow word with dashes
set nobackup
set nowritebackup
set signcolumn=yes
set nowrap
set updatetime=300
set laststatus=2
set wildmenu
set incsearch
set hlsearch

" highlighted yank
set inccommand=nosplit          " preview replace

" Undo persistent after close file
set undofile
set undodir=$HOME/.vimUndoFiles
set undolevels=5000
" don't give |ins-completion-menu| messages.
set shortmess+=c

" ignore folders for :find
set wildignore+=*/min/*,*/vendor/*,*/node_modules/*,*/bower_components/*

" ckeck for external changes with buffer gains focus
" au FocusGained,BufEnter * :silent! checktime " automatic reload changed files
set autoread

" " comments
filetype plugin on

" check if with lazyredraw cursorline works more fluid on scroll
set lazyredraw
set cursorline

" AutoSave for markdown files
au BufRead,BufNewFile     *.md set autowriteall
au BufRead,BufNewFile     *.md set wrap
au FocusLost,WinLeave     *.md :silent! w 
au BufRead,BufNewFile     *.mkd set autowriteall
au FocusLost,WinLeave     *.mkd :silent! w 

" Help File speedups, <enter> to follow tag, delete for back
au filetype help nnoremap <buffer><cr> <c-]>
au filetype help nnoremap <buffer><bs> <c-T>
au filetype help nnoremap <buffer>q :q<CR>
au filetype help set nonumber
set splitbelow " Split windows, ie Help, make more sense to me below

" Folds
set foldmethod=syntax
set foldlevelstart=99         " start unfold
set foldtext=CustomFoldText()
let g:markdown_folding = 1

" Open all folds on load markdown file
au BufRead,BufNewFile *.md normal zR
au BufRead,BufNewFile *.mkd normal zR

let g:markdown_fenced_languages = [
  \ 'css', 'less',
  \ 'html',
  \ 'javascript', 'js=javascript',
  \ 'json',
  \ 'python',
  \ 'ruby', 'rb=ruby',
  \ ]

" VISUAL  
" ******************************************************************************
set termguicolors
syntax enable

" base 16 colors
" Color list: http://chriskempson.com/projects/base16/
function! s:base16_customize() abort
  call Base16hi("StatusLine", g:base16_gui00, g:base16_gui05, g:base16_cterm00, g:base16_cterm05, "bold", "")
  call Base16hi("StatusLineNC", g:base16_gui05, g:base16_gui02, g:base16_cterm01, g:base16_cterm05, "bold", "")

  call Base16hi("LineNr", g:base16_gui03, g:base16_gui00, g:base16_cterm00, g:base16_cterm05, "", "")
  call Base16hi("FoldColumn", g:base16_gui03, g:base16_gui00, g:base16_cterm00, g:base16_cterm05, "", "")
  call Base16hi("SignColumn", g:base16_gui03, g:base16_gui00, g:base16_cterm00, g:base16_cterm05, "bold", "")
  call Base16hi("CocErrorHighlight", g:base16_gui03, g:base16_gui00, g:base16_cterm00, g:base16_cterm05, "bold", "")
  call Base16hi("CocErrorSign", g:base16_gui08, g:base16_gui00, g:base16_cterm00, g:base16_cterm05, "bold", "")
  call Base16hi("CocWarningSign", g:base16_gui09, g:base16_gui00, g:base16_cterm00, g:base16_cterm05, "bold", "")
  call Base16hi("CocInfoSign", g:base16_gui0E, g:base16_gui00, g:base16_cterm00, g:base16_cterm05, "bold", "")
  call Base16hi("CocHintSign", g:base16_gui03, g:base16_gui00, g:base16_cterm00, g:base16_cterm05, "bold", "")

  call Base16hi("TabLineSel", g:base16_gui0B, g:base16_gui00, g:base16_cterm00, g:base16_cterm05, "bold", "")
endfunction

let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

augroup on_change_colorschema
  autocmd!
  autocmd ColorScheme * call s:base16_customize()
augroup END

augroup ChangeColorsBasedOnMacos
  autocmd!
  autocmd VimEnter,FocusGained  * call s:changeColorsBasedOnMacos()  
augroup END

" Syntax config
" let g:jsx_ext_required = 0
" let g:polyglot_disabled = ['graphql']

" Status Line 
set statusline =\[%{gitbranch#name()}]\ %f\ %m
set statusline +=\ %*%=\ %*
set statusline +=\ %*%=\ %*%{StatusDiagnostic()}\ %*

" ******************************************************************************
" grep.vim
let Grep_Default_Options = '-IR'
let Grep_Skip_Files = '*.log *.db'
let Grep_Skip_Dirs = '.git node_modules'

" FZF
" ***********
let g:fzf_preview_window = ''
" Ag search only on file contents
command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, {'options': '--delimiter : --nth 4..'}, <bang>0)

inoremap <expr> <c-x><c-f> fzf#vim#complete#path(
    \ "find . -path '*/\.*' -prune -o -print \| sed '1d;s:^..::'",
    \ fzf#wrap({'dir': expand('%:p:h')}))

let g:fzf_history_dir = '~/.local/share/fzf-history'

" Sneak
let g:sneak#use_ic_scs = 0        " use global case sensitive
let g:sneak#f_reset = 1
" Sneak use global colors
hi! link Sneak Search        

" vim-dirvish 
" Replace netrw plugin
let g:loaded_netrwPlugin = 1
command! -nargs=? -complete=dir Explore Dirvish <args>
command! -nargs=? -complete=dir Sexplore belowright split | silent Dirvish <args> | belowright resize 15
command! -nargs=? -complete=dir Vexplore belowright vsplit | silent Dirvish <args> | vertical resize 50

" Sort folders first, then files
let g:dirvish_mode = ':sort ,^.*[\/],'

" Slime
let g:slime_target = "tmux"
let g:slime_default_config = {"socket_name": get(split($TMUX, ","), 0), "target_pane": ":.2"}
noremap <leader>t. :SlimeSend1 yarn run test --findRelatedTests <c-r>%<CR>

" automatically rebalance windows on vim resize
autocmd VimResized * :wincmd =

" " tmux
" let g:tmux_navigator_disable_when_zoomed = 1

" MAPINGS
" ******************************************************************************
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

" COC
" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <leader>rn <Plug>(coc-rename)
nnoremap <silent> K :call <SID>show_documentation()<CR>
nnoremap <silent><C-c> :CocRestart<CR>
nnoremap <silent>ç :CocRebuild<CR>
" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()
" CocDetail similar to AleDetail
command! -nargs=0 CocDetail :call CocAction('diagnosticInfo')
nmap <silent> <leader>l <Plug>(coc-diagnostic-info)
nmap <silent> [l <Plug>(coc-diagnostic-prev)
nmap <silent> ]l <Plug>(coc-diagnostic-next)
" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Coc git
" navigate chunks of current buffer
nmap [g <Plug>(coc-git-prevchunk)
nmap ]g <Plug>(coc-git-nextchunk)
" show chunk diff at current position
nmap gs <Plug>(coc-git-chunkinfo)

" coc Spell
vmap <leader>a <Plug>(coc-codeaction-selected)
nmap <leader>a <Plug>(coc-codeaction-selected)

" grep
nnoremap <silent> <leader>F :Rgrep<CR>

" close quick fix on "enter" and open with "o"
autocmd FileType qf nnoremap <buffer> <CR> <CR>:cclose<CR>
autocmd FileType qf nnoremap <buffer> o <CR>

" replace and save quick fix list
nnoremap <leader>r :cfdo %s%%%gc
nnoremap <silent> <leader>rs :cfdo update<CR>

" find
" nnoremap <leader>f :find

" Tabs & splits
nnoremap <C-J> <C-w><C-w>
nnoremap <C-K> <C-w><C-p>
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

" Tabularize
vmap <leader>ta :Tabularize /

" remove search on esc
nmap <expr> <Esc> sneak#is_sneaking() ? '<Right><Left>' : ':noh<return>'

"Sneak reemplaces f and t commands and not use 's' command
map f <Plug>Sneak_s
map F <Plug>Sneak_S
map t <Plug>Sneak_t
map T <Plug>Sneak_T
nnoremap s s

" search current selection
xnoremap * :<C-u>call <SID>VSetSearch('/')<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call <SID>VSetSearch('?')<CR>?<C-R>=@/<CR><CR>

" FZF
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

inoremap <expr> <c-x><c-l> fzf#vim#complete(fzf#wrap({
  \ 'prefix': '^.*$',
  \ 'source': 'rg -n ^ --color always',
  \ 'options': '--ansi --delimiter : --nth 3..',
  \ 'reducer': { lines -> join(split(lines[0], ':\zs')[2:], '') }}))

" Notes
" map <C-n> :call NoteList()<CR>
" map <C-A-n> :call NoteSearch()<CR>
command! -nargs=1 -bang NoteNew :e ~/Google Drive/Notas/<args><bang>
command! -bang NoteList call NoteList()<bang>
command! -bang NoteSearch call NoteSearch()<bang>

command! -bang ColorDark call ColorDark()<bang>
command! -bang ColorLight call ColorLight()<bang>

" Config
command! -bang ConfigNvim :e ~/.config/nvim/init.vim<bang>
nnoremap <silent> <c-s>s :so $MYVIMRC<CR>

" NewsBoat urls
command! -bang Feeds :e ~/.newsboat/urls<bang>

" Git
inoremap ∫ <C-R>=Branch()<CR>

" Tests JS
nmap <leader>tc :!npm run test -- --coverage<CR>
nmap <silent> <leader>tt :TestNearest<CR>
nmap <silent> <leader>tf :TestFile<CR>
nmap <silent> <leader>ts :TestSuite<CR>
nmap <silent> <leader>tl :TestLast<CR>
nmap <silent> <leader>tv :TestVisit<CR>
" nmap <silent> <leader>tf :!kitty @ launch --env PATH="/usr/local/bin:$PATH" --cwd=current yarn test --findRelatedTests %<cr>

" Execure current file with node
nmap <leader>en :!node %<CR>

" replace word under cursor, globally, with confirmation
nnoremap <Leader>k :%s/\<<C-r><C-w>\>//gc<Left><Left><Left>
vnoremap <Leader>k y :%s/<C-r>"//gc<Left><Left><Left>

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

" if has("nvim")
"   au TermOpen * tnoremap <Esc> <c-\><c-n>
"   au FileType fzf tunmap <Esc>
" endif

" FUNCTIONS
" ******************************************************************************
"FZF decide what file find to use
fun! FzfOmniFiles()
  let is_git = system('git status')
  if v:shell_error
    :Files
  else
    :GitFiles
  endif
endfunction

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

function! ColorLight()
  set background=light
  color base16-solarized-light
endfunction

function! ColorDark()
  set background=dark
  color base16-dracula
endfunction

" COC documentation
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" COC Use tab for trigger completion
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" COC statusline
function! StatusDiagnostic() abort
  let info = get(b:, 'coc_diagnostic_info', {})
  if empty(info) | return '' | endif
  let msgs = []
  if get(info, 'error', 0)
    call add(msgs, 'E' . info['error'])
  endif
  if get(info, 'warning', 0)
    call add(msgs, 'W' . info['warning'])
  endif
  return join(msgs, ' ') . ' ' 
endfunction

function! s:changeColorsBasedOnMacos() abort
  let hasDarkmode = system('dark-mode status')

  if (hasDarkmode=~'on')
    call ColorDark()
    call s:base16_customize()
  else 
    call ColorLight()
    call s:base16_customize()
  endif
endfunction

function! CustomFoldText() abort
  let s:middot='•'
  let s:raquo='»'
  let s:small_l='ℓ'

  let l:lines='' . (v:foldend - v:foldstart + 1) . ' ' . s:small_l . ''
  let l:first=substitute(getline(v:foldstart), '\v *', '', '')
  return s:raquo . ' ' . l:lines . ' // ' . l:first
endfunction
