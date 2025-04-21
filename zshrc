# Source shared files
DOTFILES="$HOME/git/dotfiles"
[ -f "$DOTFILES/aliases" ] && source "$DOTFILES/aliases"
[ -f "$DOTFILES/bashrc" ] && source "$DOTFILES/bashrc"

# Prompt
autoload -Uz vcs_info
precmd() { vcs_info }

setopt prompt_subst
PROMPT='%F{cyan}%~%f${vcs_info_msg_0_} %(#.%F{red}#%f.%F{green}$%f) '

zstyle ':vcs_info:git:*' formats ' [%b]'

# History settings
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt inc_append_history
setopt share_history

# Tab completion
autoload -Uz compinit
compinit

# Make ls look better
if [[ "$OSTYPE" == "darwin"* ]]; then
  alias ls='ls -G'      # macOS
else
  alias ls='ls --color=auto'  # Linux
fi

# Add bin path
export PATH="$HOME/git/dotfiles/bin:$PATH"
