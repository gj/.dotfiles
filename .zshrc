# # Enable shell history in IEx
# export ERL_AFLAGS="-kernel shell_history enabled"
#
# fpath=(${ASDF_DIR}/completions $fpath)

# # Initialize completion
# autoload -Uz compinit && compinit -D
# zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
# zstyle ':completion:*' completer _expand _complete _ignored
# zstyle ':completion:*' max-errors 1
# zstyle ':completion:*' rehash true
# zstyle :compinstall filename '/home/gj/.zshrc'
# setopt COMPLETE_ALIASES

export PATH="$HOME/.npm-global/bin:$PATH"

source "${HOME}/.asdf/asdf.sh"
. ~/.asdf/plugins/java/set-java-home.zsh # Set JAVA_HOME

# Nicer history
export HISTSIZE=100000
export HISTFILE="$HOME/.history"
export SAVEHIST=$HISTSIZE

# Use vim as the editor
export VISUAL=vim
export EDITOR="$VISUAL"

# By default, zsh considers many characters part of a word (e.g., _ and -).
# Narrow that down to allow easier skipping through words via M-f and M-b.
export WORDCHARS='*?[]~&;!$%^<>'

# # Highlight search results in ack.
# export ACK_COLOR_MATCH='red'

# Ignore commands prefixed with a space (great for not accidentally storing secrets in your shell history file
setopt histignorespace

# https://stackoverflow.com/a/23314326
bindkey -e

[[ -f $HOME/.aliases ]] && source $HOME/.aliases

# export FZF_DEFAULT_COMMAND='fd --type f --color=always --hidden --follow --exclude .git/ --exclude node_modules/ --exclude target/ --exclude vendor/ --exclude _build/ 2> /dev/null'
export FZF_DEFAULT_COMMAND='rg --files'
export FZF_DEFAULT_OPTS='--ansi'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

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
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#3c6a76"

# export PATH="/usr/local/opt/openjdk/bin:$PATH"
# export PATH="$PATH:/opt/apache-maven-3.6.3/bin"
# export JAVA_HOME="/usr/local/opt/openjdk/libexec/openjdk.jdk/Contents/Home"

function set_win_title(){
    echo -ne "\033]0; $PWD \007"
}
precmd_functions+=(set_win_title)
eval "$(starship init zsh)"

# export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# https://github.com/LnL7/nix-darwin/issues/158#issuecomment-769360869
no_darwin_in_path="nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixpkgs:/nix/var/nix/profiles/per-user/root/channels"
if [[ $NIX_PATH = $no_darwin_in_path ]]; then
  source_darwin=$(awk 'c&&!--c;/__NIX_DARWIN_SET_ENVIRONMENT_DONE/{c=1}' /etc/zshenv)
  eval $source_darwin
fi

export PATH="$HOME/.cargo/bin:$PATH"

# export PATH="/usr/local/opt/openjdk/bin:$PATH"
# export PATH="$PATH:/opt/apache-maven-3.8.1/bin"
# export JAVA_HOME="/usr/local/opt/openjdk/libexec/openjdk.jdk/Contents/Home"

export PATH="/usr/local/opt/ruby/bin:$PATH"
export PATH="$HOME/.gem/ruby/3.0.0/bin:$PATH"
export PATH="/usr/local/lib/ruby/gems/3.0.0/bin:$PATH"

# export PATH="/usr/local/go/bin:$PATH"

# export PATH="$HOME/Downloads/pypy3.6-v7.3.2-osx64/bin:$PATH"

export FLYCTL_INSTALL="/Users/gj/.fly"
export PATH="$FLYCTL_INSTALL/bin:$PATH"

# Deduplicate $PATH
typeset -U PATH

eval "$(direnv hook zsh)"
