# Enable Powerlevel10k instant prompt. Keep this near the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=1000
setopt INC_APPEND_HISTORY_TIME

# Git's completion definition is installed by Debian's git package.
for completion_dir in /usr/share/zsh/functions/Completion/Unix /usr/share/zsh/vendor-completions /usr/share/zsh/site-functions; do
  [[ -d "$completion_dir" ]] && fpath=("$completion_dir" $fpath)
done
autoload -Uz compinit
compinit

POWERLEVEL10K_HOME="${POWERLEVEL10K_HOME:-$HOME/.powerlevel10k}"
source "$POWERLEVEL10K_HOME/powerlevel10k.zsh-theme"
P10K_CONFIG="${ZDOTDIR:-$HOME}/.p10k.zsh"
[[ ! -r "$P10K_CONFIG" ]] || source "$P10K_CONFIG"
unset P10K_CONFIG

eval "$(direnv hook zsh)"
