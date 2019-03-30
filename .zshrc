fancy-ctrl-z () {
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fg"
    zle accept-line
  else
    zle push-input
    zle clear-screen
  fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z

# wget -O ~/.purepower.sh https://raw.githubusercontent.com/romkatv/dotfiles-public/master/.purepower
source ~/.purepower.sh
