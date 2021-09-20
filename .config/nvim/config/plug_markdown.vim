" Plug 'plasticboy/vim-markdown'
" Plug 'tpope/vim-markdown'
" Plug 'vim-pandoc/vim-pandoc-syntax'

" AutoSave for markdown files
au BufRead,BufNewFile     *.md set autowriteall 
au BufRead,BufNewFile     *.md set wrap
au FocusLost,WinLeave     *.md :silent! w 
au BufRead,BufNewFile     *.mkd set autowriteall
au FocusLost,WinLeave     *.mkd :silent! w 

" set conceallevel
au BufRead,BufNewFile     *.md set conceallevel=2

let g:markdown_folding = 1

" let g:markdown_fenced_languages = [
"   \ 'txt', '',
"   \ 'css', 'less',
"   \ 'html',
"   \ 'javascript', 'js=javascript',
"   \ 'json',
"   \ 'python',
"   \ 'ruby', 'rb=ruby',
"   \ ]

" " Configuration for vim-markdown
" let g:vim_markdown_conceal = 1
" let g:vim_markdown_conceal_code_blocks = 0
" let g:vim_markdown_math = 1
" let g:vim_markdown_toml_frontmatter = 1
" let g:vim_markdown_frontmatter = 1
" let g:vim_markdown_strikethrough = 1
" " let g:vim_markdown_autowrite = 1
" let g:vim_markdown_edit_url_in = 'tab'
" let g:vim_markdown_follow_anchor = 1

" augroup pandoc_syntax
"     au! BufNewFile,BufFilePre,BufRead *.md set filetype=markdown.pandoc
"   augroup END


" " Config plasticboy/vim-markdown plugin 
" " is used in Polyglot plugin
" " ******************************************************************************
" " disable header folding
" let g:vim_markdown_folding_disabled = 1

" " do not use conceal feature, the implementation is not so good
" let g:vim_markdown_conceal = 0

" " disable math tex conceal feature
" let g:tex_conceal = ""
" let g:vim_markdown_math = 1

" " support front matter of various format
" let g:vim_markdown_frontmatter = 1  " for YAML format
" let g:vim_markdown_toml_frontmatter = 1  " for TOML format
" let g:vim_markdown_json_frontmatter = 1  " for JSON format


" let g:markdown_folding = 1
" let g:vim_markdown_folding_level = 1
" let g:vim_markdown_follow_anchor = 1
" let g:vim_markdown_new_list_item_indent = 2
" let g:vim_markdown_no_extensions_in_markdown = 1
let g:markdown_fenced_languages = [
  \ 'css', 'less',
  \ 'html',
  \ 'javascript', 'js=javascript',
  \ 'json',
  \ 'python',
  \ 'ruby', 'rb=ruby',
  \ ]

" let g:markdown_minlines = 100

