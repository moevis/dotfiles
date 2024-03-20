export EDITOR=nvim
export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git"
export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git"
export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles"
export GOPROXY=https://goproxy.io

eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(starship init zsh)"

if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

  autoload -Uz compinit
  compinit

  source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
  source $(brew --prefix)/share/zsh-history-substring-search/zsh-history-substring-search.zsh
fi

alias l='exa -bF --git --icons'
alias ll='exa -lbGF --git --icons'
alias lt='exa --tree --level=2 --icons'

# define append_path and prepend_path to add directory paths, e.g. PATH, MANPATH
# add to end of path
append_path()
{
  if ! eval test -z "\"\${$1##*:$2:*}\"" -o -z "\"\${$1%%*:$2}\"" -o -z "\"\${$1##$2:*}\"" -o -z "\"\${$1##$2}\"" ; then
    eval "$1=\$$1:$2"
  fi
}

# add to front of path
prepend_path()
{
  if ! eval test -z "\"\${$1##*:$2:*}\"" -o -z "\"\${$1%%*:$2}\"" -o -z "\"\${$1##$2:*}\"" -o -z "\"\${$1##$2}\"" ; then
    eval "$1=$2:\$$1"
  fi
}

prepend_path PATH ~/opt/bin
prepend_path PATH ~/opt/flutter/bin
prepend_path PATH ~/go/bin
prepend_path PATH ~/Library/Python/3.8/bin
prepend_path PATH ~/.cargo/bin

bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
