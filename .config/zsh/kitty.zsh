# exec /bin/ls --hyperlink=auto --color=auto "$@"

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

function ks() {
  session=$@

  kitty \
    --session ~/Google\ Drive/My\ Drive/.config-private/kitty-sessions/${session}.conf \
    --title ${session} \
    --single-instance \
    </dev/null &>/dev/null &
}

alias clear="clear && kittyDarkMode"
alias colorDark="dark-mode on && kittyDarkMode"
alias colorLight="dark-mode off && kittyDarkMode"


bindkey '^[[1;3D' backward-word # alt-left
bindkey '^[[1;3C' forward-word # alt-right
