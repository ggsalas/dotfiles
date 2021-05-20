" FUNCTIONS
" ******************************************************************************
function! CustomFoldText()
    let line = getline(v:foldstart)

    let nucolwidth = &foldcolumn + &number * &numberwidth
    let windowwidth = winwidth(0) - nucolwidth - 3
    let foldedlinecount = v:foldend - v:foldstart . ' lines '

    " expand tabs into spaces
    let chunks = split(line, "\t", 1)
    let line = join(map(chunks[:-2], 'v:val . repeat(" ", &tabstop - strwidth(v:val) % &tabstop)'), '') . chunks[-1]

    let line = strpart(line, 0, windowwidth - 2 - len(foldedlinecount)) . ' '
    let fillcharcount = windowwidth - len(line) - len(foldedlinecount)

    return line . repeat('.', fillcharcount) . ' ' . foldedlinecount
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
set hidden            " Switch buffers without need to save
set iskeyword+=-      " Allow word with dashes
set nobackup
set nowritebackup
set nowrap
set updatetime=300
set laststatus=2
set wildmenu
set incsearch
set hlsearch
set relativenumber
set scrolloff=1

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

if has("nvim")
  set inccommand=nosplit          " preview replace
endif

" don't give |ins-completion-menu| messages.
set shortmess+=c

" ignore folders for :find
set wildignore+=*/min/*,*/vendor/*,*/node_modules/*,*/bower_components/*

" check for external changes with buffer gains focus
set autoread

" " comments
filetype plugin on

" check if with lazy-redraw cursor-line works more fluid on scroll
set lazyredraw
set cursorline

" Help File speedups, <enter> to follow tag, delete for back
au filetype help nnoremap <buffer><cr> <c-]>
au filetype help nnoremap <buffer><bs> <c-T>
au filetype help nnoremap <buffer>q :q<CR>
au filetype help set nonumber

set splitbelow " Split windows, ie Help, make more sense to me below

" Folds
"""""""
function SetFold()
  setlocal foldmethod=expr
  setlocal foldexpr=nvim_treesitter#foldexpr() " nvim_treesitter
  setlocal foldlevel=99         " start unfold
  setlocal foldtext=CustomFoldText()
endfunction

function SetFoldMarkdown()
  setlocal foldmethod=syntax
  setlocal foldlevel=1
  setlocal foldtext=CustomFoldText()
endfunction

augroup doSetFold
  autocmd FileType javascript,typescript,typescriptreact,json call SetFold()
  autocmd FileType markdown call SetFoldMarkdown()
augroup END

" Spell
"""""""
set nospell

function SetSpellOptions()
  setlocal spell spelllang=en_us
  setlocal spelloptions=camel 
endfunction

augroup doSpell
    autocmd FileType markdown,javascript,typescript,typescriptreact call SetSpellOptions()
augroup END

