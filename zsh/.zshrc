# Enable Powerlevel10k instant prompt. Keep this near the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export HISTFILE=~/.zsh_history
export HISTSIZE=50000
export SAVEHIST=50000

# Smart History Options
setopt SHARE_HISTORY          # Share history across all active terminals immediately
setopt EXTENDED_HISTORY       # Save Unix timestamps and command execution duration
setopt HIST_IGNORE_ALL_DUPS   # Delete older duplicate entries if a new one is typed
setopt HIST_IGNORE_SPACE      # Don't record commands starting with a space (good for secrets)
setopt HIST_REDUCE_BLANKS     # Remove superfluous blanks from commands
setopt HIST_FIND_NO_DUPS      # Do not display a line previously found during a search

# Load the beginning search functions
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

# Dynamically bind keys using terminfo
if [[ -n "${terminfo[kcuu1]}" ]]; then
  bindkey "${terminfo[kcuu1]}" up-line-or-beginning-search
fi
if [[ -n "${terminfo[kcud1]}" ]]; then
  bindkey "${terminfo[kcud1]}" down-line-or-beginning-search
fi

# Fallback codes if terminfo is missing (covers both macOS and Linux variants)
bindkey '^[[A' up-line-or-beginning-search   # Standard ANSI Up
bindkey '^[OA' up-line-or-beginning-search   # Application mode Up
bindkey '^[[B' down-line-or-beginning-search # Standard ANSI Down
bindkey '^[OB' down-line-or-beginning-search # Application mode Down

# Git's completion definition is installed by Debian's git package.
for completion_dir in /usr/share/zsh/functions/Completion/Unix /usr/share/zsh/vendor-completions /usr/share/zsh/site-functions; do
  [[ -d "$completion_dir" ]] && fpath=("$completion_dir" $fpath)
done
autoload -Uz compinit
compinit

POWERLEVEL10K_HOME="${POWERLEVEL10K_HOME:-$HOME/.powerlevel10k}"
if [[ -r "$POWERLEVEL10K_HOME/powerlevel10k.zsh-theme" ]]; then
  source "$POWERLEVEL10K_HOME/powerlevel10k.zsh-theme"
fi
P10K_CONFIG="${ZDOTDIR:-$HOME}/.p10k.zsh"
[[ ! -r "$P10K_CONFIG" ]] || source "$P10K_CONFIG"
unset P10K_CONFIG

eval "$(direnv hook zsh)"
