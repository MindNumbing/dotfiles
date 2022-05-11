# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH

  autoload -Uz compinit
  compinit
fi

source ~/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
antigen bundle pip
antigen bundle command-not-found
antigen bundle zsh-users/zsh-syntax-highlighting
antigen theme romkatv/powerlevel10k
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle wting/autojump
antigen bundle unixorn/git-extra-commands
antigen bundle psprint/zsh-navigation-tools
antigen bundle MichaelAquilina/zsh-you-should-use
antigen bundle common-aliases
antigen bundle colorls

antigen bundle zsh-users/zsh-syntax-highlighting

alias ls='colorls'
alias weather='curl wttr.in/belfast'
alias emacs='emacs -nw'

[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# Tell Antigen that you're done.
antigen apply

# Python
# alias python=/usr/local/bin/python3.9
# alias pip=/usr/local/bin/pip3

#setup path
#export PATH=":$PATH"

#setup environment variables
export GITHUB_USERNAME=MindNumbing
export GITHUB_TOKEN=
eval "$(gh completion -s zsh)"
export EDITOR=vim

#Setup thefuck
eval $(thefuck --alias)

# Common git commands
alias prepare_repo='git pull --all; git checkout master; git pull --all; black app tests; make stop; make clean; make db.migrate; make test && make lint;'
alias rebase_master='git checkout master; git pull --all; git checkout -; git rebase master;'
alias test_repo='black app tests; make stop; make clean; make db.migrate; make test && make lint;'
alias clear_merged="git checkout master; git branch | grep -v '^*' | xargs -I % sh -c 'git branch -d %; git push --delete origin %;'"
alias purge_docker='docker rm -f $(docker ps -a -q); docker volume rm $(docker volume ls -q)'

eval "$(rbenv init -)"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
export PATH="/usr/local/opt/ruby/bin:$PATH"
export PATH="/Users/Aarvo/.gem/ruby/2.7.0/bin:$PATH"
export PATH="/Users/Aarvo/Library/Python/3.9/bin:$PATH"

#Get pyenv to work
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
