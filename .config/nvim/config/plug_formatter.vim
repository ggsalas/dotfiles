augroup fmt
  autocmd!
  au BufWritePre *.md,*.js,*.jsx,*.ts,*.tsx,*.json,*.css,*.scss try | undojoin | Neoformat | catch /^Vim\%((\a\+)\)\=:E790/ | finally | silent Neoformat | endtry
augroup END

let g:neoformat_run_all_formatters = 1
let g:neoformat_verbose = 0
let g:neoformat_enabled_javascript = ['eslint_d', 'prettier']
let g:neoformat_enabled_javascriptreact = ['eslint_d', 'prettier']
let g:neoformat_enabled_typescript = ['eslint_d', 'prettier']
let g:neoformat_enabled_typescriptreact = ['eslint_d', 'prettier']
let g:neoformat_enabled_markdown = ['prettier']

command! -bang Format :Neoformat
