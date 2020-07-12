function! s:SourceConfigFile(fileName)
  execute 'source' '~/.config/nvim/config/' . a:fileName . '.vim'
endfunction

call s:SourceConfigFile('main_settings')
call s:SourceConfigFile('main_mappings')

call plug#begin()
call s:SourceConfigFile('main_visual')
call s:SourceConfigFile('main_undo')
call s:SourceConfigFile('plug_coc')
call s:SourceConfigFile('plug_dirvish')
call s:SourceConfigFile('plug_grep')
call s:SourceConfigFile('plug_slime')
call s:SourceConfigFile('plug_sneak')
call s:SourceConfigFile('plug_fzf')
call s:SourceConfigFile('plug_without_config')
call plug#end()


