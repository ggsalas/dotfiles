Plug 'neoclide/coc.nvim', {'branch': 'release'}                 " LSP, completion, linting

" Coc Plugins
Plug 'neoclide/coc-prettier', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-eslint', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-json', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-css', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-git', {'do': 'yarn install --frozen-lockfile'}
" Plug 'iamcco/coc-spell-checker', {'do': 'yarn install --frozen-lockfile'}

let g:coc_global_extensions = ['coc-prettier', 'coc-eslint',  'coc-tsserver', 'coc-json', 'coc-css', 'coc-git']

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
" vmap <leader>a <Plug>(coc-codeaction-selected)
" nmap <leader>a <Plug>(coc-codeaction-selected)
