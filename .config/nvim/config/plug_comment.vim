Plug 'tpope/vim-commentary'

autocmd FileType javascript.jsx setlocal commentstring={/*\ %s\ */}
autocmd FileType javascript.jsx setlocal commentstring={ \ 'jsComment' : '// %s', \ 'jsImport' : '// %s', \ 'jsxStatment' : '// %s', \ 'jsxRegion' : '{/*%s*/}' \}
