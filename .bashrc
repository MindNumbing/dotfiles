export TERM=xterm-256color
export EDITOR=vim

# Prompt
BGREEN='\[\033[1;32m\]'
GREEN='\[\033[0;32m\]'
BRED='\[\033[1;31m\]'
RED='\[\033[0;31m\]'
BBLUE='\[\033[1;34m\]'
BLUE='\[\033[0;34m\]'
NORMAL='\[\033[00m\]'
PURPLE='\[\033[0;35m\]'
PS1="${PURPLE}\u@\h ${BBLUE}{${RED}\w${BBLUE}} ${BRED}\$ ${NORMAL}"

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
