" search current selection
function! s:VSetSearch(cmdtype)
  let temp = @s
  norm! gv"sy
  let @/ = '\V' . substitute(escape(@s, a:cmdtype.'\'), '\n', '\\n', 'g')
  let @s = temp
endfunction

function! CustomFoldText() abort
  let s:middot='•'
  let s:raquo='»'
  let s:small_l='ℓ'

  let l:lines='' . (v:foldend - v:foldstart + 1) . ' ' . s:small_l . ''
  let l:first=substitute(getline(v:foldstart), '\v *', '', '')
  return s:raquo . ' ' . l:lines . ' // ' . l:first
endfunction

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

set nospell
au BufNewFile,BufReadPost,FilterReadPost,FileReadPost  * set nospell


if has("nvim")
  set inccommand=nosplit          " preview replace
endif

" don't give |ins-completion-menu| messages.
set shortmess+=c

" ignore folders for :find
set wildignore+=*/min/*,*/vendor/*,*/node_modules/*,*/bower_components/*

" ckeck for external changes with buffer gains focus
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
