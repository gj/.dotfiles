# Modify PATH per Stack's instructions (Haskell)
export PATH="$PATH:$HOME/.local/bin"

# Enable ZSH Autosuggestions
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Configure ZSH Autosuggestions
export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
export ZSH_AUTOSUGGEST_USE_ASYNC=true
bindkey '^ ' autosuggest-accept

# Don't send analytics information to Homebrew
export HOMEBREW_NO_ANALYTICS=1

# Enable shell history in IEx
export ERL_AFLAGS="-kernel shell_history enabled"

# Initialize completion
autoload -U compinit
compinit -D
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# Nicer history
export HISTSIZE=100000
export HISTFILE="$HOME/.history"
export SAVEHIST=$HISTSIZE

# Stop wget from creating ~/.wget-hsts file. I don't care about HSTS (HTTP
# Strict Transport Security) for wget; it's not as if I'm logging into my bank
# with it.
alias wget='wget --no-hsts'

# Use vim as the editor
export VISUAL=vim
export EDITOR="$VISUAL"

# Use C-x C-e to edit the current command line
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line

# By default, zsh considers many characters part of a word (e.g., _ and -).
# Narrow that down to allow easier skipping through words via M-f and M-b.
export WORDCHARS='*?[]~&;!$%^<>'

# Highlight search results in ack.
export ACK_COLOR_MATCH='red'

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

autoload -U colors && colors
setopt promptsubst
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' actionformats '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '
zstyle ':vcs_info:*' formats '%F{5}%F{8}[%F{7}%b%F{8}]%f '
zstyle ':vcs_info:(git):*' branchformat '%b%F{1}:%F{3}%r'
precmd () { vcs_info }
PS1=' %F{6}%1~ ${vcs_info_msg_0_}%f%# '
autoload -U promptinit; promptinit

[[ -f $HOME/.aliases ]] && source $HOME/.aliases
[[ -d $HOME/.zsh_functions ]] && fpath=( $HOME/.zsh_functions "${fpath[@]}" )

if [ -d $HOME/.zsh_functions ]; then
  for FUNCTION in $(ls $HOME/.zsh_functions)
  do
    autoload -Uz $FUNCTION
  done
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

export NVM_DIR=~/.nvm

# For GPG setup
export GPG_TTY=$(tty)

# For pyenv with YouCompleteMe (Vim)
export PYTHON_CONFIGURE_OPTS="--enable-framework"
