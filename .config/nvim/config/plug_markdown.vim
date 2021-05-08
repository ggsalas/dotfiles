" AutoSave for markdown files
au BufRead,BufNewFile     *.md set autowriteall 
au BufRead,BufNewFile     *.md set wrap
au FocusLost,WinLeave     *.md :silent! w 
au BufRead,BufNewFile     *.mkd set autowriteall
au FocusLost,WinLeave     *.mkd :silent! w 

" set fold level
au BufRead,BufNewFile     *.md set foldlevel=1

" set conceallevel
au BufRead,BufNewFile     *.md set conceallevel=2

" Config plasticboy/vim-markdown plugin 
" is used in Polyglot plugin
" ******************************************************************************
" let g:markdown_folding = 1
" let g:vim_markdown_folding_level = 1
" let g:vim_markdown_follow_anchor = 1
" let g:markdown_fenced_languages = [
"   \ 'css', 'less',
"   \ 'html',
"   \ 'javascript', 'js=javascript',
"   \ 'json',
"   \ 'python',
"   \ 'ruby', 'rb=ruby',
"   \ ]
" let g:vim_markdown_new_list_item_indent = 2
" let g:vim_markdown_no_extensions_in_markdown = 1
