# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
source "${ZINIT_HOME}/zinit.zsh"

# Load Zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
autoload -U compinit && compinit
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab
zinit light desyncr/auto-ls
AUTO_LS_NEWLINE=false

# Load snippets
zinit snippet OMZP::git
zinit snippet OMZP::colored-man-pages

# Keybindings
bindkey '^p' history-beginning-search-backward
bindkey '^n' history-beginning-search-forward
bindkey '^[w' kill-region
bindkey '^x' autosuggest-clear
bindkey '^d' forward-word

# History settings
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Shell integrations
export PATH="$HOME/.local/bin:$PATH"
eval "$(fzf --zsh)"
eval "$(zoxide init zsh)"
eval "$(oh-my-posh init zsh --config ~/.cache/oh-my-posh/themes/atomicBit.omp.json)"

# Aliases
alias ip='ip -c'
alias ls='ls --color'
alias ll='ls -l'
alias la='ls -a'
alias c='clear'
alias cd='z'
alias cat='bat'

# Python environment
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# Add .NET Core SDK tools
export PATH="$PATH:$HOME/.dotnet/tools"
