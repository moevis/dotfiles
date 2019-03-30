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

# git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
ZSH_THEME=powerlevel10k/powerlevel10k

# wget -O ~/.purepower.sh https://raw.githubusercontent.com/romkatv/dotfiles-public/master/.purepower
source ~/.purepower.sh
