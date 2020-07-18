kittyDarkMode() {
  if [[ $(echo $TERM) == 'xterm-kitty' ]] then
    local LIGHT=(kitty @ set-colors --all --configured $HOME/.config/kitty/kitty_colorLight.conf)
    local DARK=(kitty @ set-colors --all --configured $HOME/.config/kitty/kitty_colorDark.conf)

    if [[ ( $(dark-mode status) =~ 'on' ) ]]; then
      export BAT_THEME=Dracula
      $DARK
    else
      export BAT_THEME=OneHalfLight
      $LIGHT
    fi
  fi
}

alias clear="clear && kittyDarkMode"
alias colorDark="dark-mode on && kittyDarkMode"
alias colorLight="dark-mode off && kittyDarkMode"

