Plug 'janko-m/vim-test'

let test#strategy = {
  \ 'nearest': 'neovim',
  \ 'file':    'dispatch',
  \ 'suite':   'basic',
\}

" Tests JS mappings
nmap <leader>tc :!npm run test -- --coverage<CR>
nmap <silent> <leader>tt :TestNearest<CR>
nmap <silent> <leader>tf :TestFile<CR>
nmap <silent> <leader>ts :TestSuite<CR>
nmap <silent> <leader>tl :TestLast<CR>
nmap <silent> <leader>tv :TestVisit<CR>
" nmap <silent> <leader>tf :!kitty @ launch --env PATH="/usr/local/bin:$PATH" --cwd=current yarn test --findRelatedTests %<cr>
