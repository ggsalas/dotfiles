Plug 'vim-scripts/grep.vim'

" grep.vim
let Grep_Default_Options = '-IR'
let Grep_Skip_Files = '*.log *.db'
let Grep_Skip_Dirs = '.git node_modules'

command! Search :Rgrep
