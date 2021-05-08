Plug 'tpope/vim-commentary'

autocmd FileType javascript.jsx setlocal commentstring={/*\ %s\ */}
autocmd FileType javascript.jsx setlocal commentstring={ \ 'jsComment' : '// %s', \ 'jsImport' : '// %s', \ 'jsxStatment' : '// %s', \ 'jsxRegion' : '{/*%s*/}' \}

" Plug 'preservim/nerdcommenter'

" let g:NERDSpaceDelims = 1
" let g:NERDCompactSexyComs=1
" let g:NERDToggleCheckAllLines=1
" 
" nmap gcc <plug>NERDCommenterToggle
" nmap gcc <plug>NERDCommenterToggle
" vmap gcc <plug>NERDCommenterMinimal
" map gcu <plug>NERDCommenterUncomment
" nmap gca <plug>NERDCommenterAltDelims
