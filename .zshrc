# Enable shell history in IEx
export ERL_AFLAGS="-kernel shell_history enabled"

# Initialize completion
autoload -Uz compinit && compinit -D
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' completer _expand _complete _ignored
zstyle ':completion:*' max-errors 1
zstyle ':completion:*' rehash true
zstyle :compinstall filename '/home/gj/.zshrc'
setopt COMPLETE_ALIASES

. $HOME/.asdf/asdf.sh

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

# By default, zsh considers many characters part of a word (e.g., _ and -).
# Narrow that down to allow easier skipping through words via M-f and M-b.
export WORDCHARS='*?[]~&;!$%^<>'

# Highlight search results in ack.
export ACK_COLOR_MATCH='red'

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# Ignore commands prefixed with a space (great for not accidentally storing secrets in your shell history file
setopt histignorespace

# For GPG setup
export GPG_TTY=$(tty)

# https://stackoverflow.com/a/23314326
bindkey -e

[[ -f $HOME/.aliases ]] && source $HOME/.aliases

# export FZF_DEFAULT_COMMAND='
#   (git ls-tree -r --name-only HEAD ||
#     fd --type f --color=always --hidden --follow --exclude .git/ --exclude node_modules/ --exclude target/ --exclude vendor/) 2> /dev/null'
export FZF_DEFAULT_COMMAND='fdfind --type f --color=always --hidden --follow --exclude .git/ --exclude node_modules/ --exclude target/ --exclude vendor/ 2> /dev/null'
export FZF_DEFAULT_OPTS='--ansi'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export PATH="$HOME/.cargo/bin:$PATH"

[[ -d $HOME/.zsh_functions ]] && fpath=( $HOME/.zsh_functions "${fpath[@]}" )

if [ -d $HOME/.zsh_functions ]; then
  for FUNCTION in $(/bin/ls $HOME/.zsh_functions)
  do
    autoload -Uz $FUNCTION
  done
fi

### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing DHARMA Initiative Plugin Manager (zdharma/zinit)…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zinit-zsh/z-a-patch-dl \
    zinit-zsh/z-a-as-monitor \
    zinit-zsh/z-a-bin-gem-node

### End of Zinit's installer chunk

zinit wait lucid for \
 atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
    zdharma/fast-syntax-highlighting \
 blockf \
    zsh-users/zsh-completions \
 atload"!_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions

zinit load zdharma/history-search-multi-word
zstyle ":history-search-multi-word" page-size "LINES/4"
zstyle :plugin:history-search-multi-word reset-prompt-protect 1
zstyle ":history-search-multi-word" highlight-color "fg=yellow,bold"

# Configure ZSH Autosuggestions
export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
export ZSH_AUTOSUGGEST_USE_ASYNC=true
# bindkey '^ ' autosuggest-accept

# # # Enable ZSH History Substring Search
# # source ~/.zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
# # bindkey '^[[A' history-substring-search-up
# # bindkey '^[[B' history-substring-search-down
# # bindkey -M emacs '^P' history-substring-search-up
# # bindkey -M emacs '^N' history-substring-search-down
# # bindkey -M vicmd 'k' history-substring-search-up
# # bindkey -M vicmd 'j' history-substring-search-down

# Deduplicate $PATH
typeset -U PATH

function set_win_title(){
    echo -ne "\033]0; $PWD \007"
}
precmd_functions+=(set_win_title)
eval "$(starship init zsh)"
