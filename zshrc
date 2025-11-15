#===============================================================================
# SOURCE FILES
#===============================================================================  

DOTFILES="$HOME/.dotfiles"
[ -f "$DOTFILES/aliases" ] && source "$DOTFILES/aliases"
[ -f "$DOTFILES/bashrc" ] && source "$DOTFILES/bashrc"

#===============================================================================
# PROMPT CONFIGURATION
#===============================================================================

# Check the UID to set user and operation prompt colors and symbols
if [[ $UID -ne 0 ]]; then # normal user
  PR_USER='%F{green}%n%f'
  PR_USER_OP='%F{green}%#%f'
  PR_PROMPT='%f➤ %f'
else # root
  PR_USER='%F{red}%n%f'
  PR_USER_OP='%F{red}%#%f'
  PR_PROMPT='%F{red}➤ %f'
fi

# Check if we are on SSH or not
if [[ -n "$SSH_CLIENT"  ||  -n "$SSH2_CLIENT" ]]; then
  PR_HOST='%F{red}%M%f' # SSH
else
  PR_HOST='%F{green}%m%f' # no SSH
fi

# Configure return code display
return_code="%(?..%F{red}%? ↵%f)"

# Compile parts of the prompt
user_host="${PR_USER}%F{cyan}@${PR_HOST}"
current_dir="%B%F{blue}%~%f%b"

# Set PROMPT (PS1) and RPROMPT (PS2)
PROMPT="
╭─${user_host} ${current_dir}
╰─$PR_PROMPT "
RPROMPT="${return_code}"

#===============================================================================
# Aliases
#===============================================================================

# Directory Stack Options
setopt AUTO_PUSHD          # Automatically push the old directory onto the stack when using 'cd'.
setopt PUSHD_IGNORE_DUPS   # Do not store duplicate entries in the directory stack.
setopt PUSHD_SILENT        # Do not display the directory stack after using 'pushd' or 'popd'.

#===============================================================================
# HISTORY SETTINGS
#===============================================================================

# History Management
setopt EXTENDED_HISTORY       # Save each command's timestamp and duration to history.
setopt SHARE_HISTORY          # Share command history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST # When trimming the history, remove older duplicate entries before removing the oldest entries.
setopt HIST_IGNORE_DUPS       # Do not save duplicate commands consecutively in the history file.
setopt HIST_IGNORE_SPACE      # Commands starting with a space are not added to the history list.
setopt INC_APPEND_HISTORY     # Append commands to the history file as they are executed, not when the shell exits.

# History configuration: where to store the command history and its size
export HISTFILE="$HOME/.zhistory"  # Location of the zsh command history file
export HISTSIZE=10000              # Number of commands to store in memory
export SAVEHIST=10000              # Number of commands to store in the history file

# Set default editors for command-line and GUI-based applications
export EDITOR="vim"
export VISUAL="vim"  # VISUAL is used when a full screen editor is preferred

# Terminal setup: use a 256-color terminal
export TERM="xterm-256color"

# Set system language and character encoding
export LANG="en_US.UTF-8"

# Source shared files
DOTFILES="$HOME/.dotfiles"
[ -f "$DOTFILES/aliases" ] && source "$DOTFILES/aliases"
[ -f "$DOTFILES/bashrc" ] && source "$DOTFILES/bashrc"

# Make ls look better
if [[ "$OSTYPE" == "darwin"* ]]; then
  alias ls='ls -G'      # macOS
else
  alias ls='ls --color=auto'  # Linux
fi

# Add bin path
export PATH="$HOME/.dotfiles/bin:$PATH"
export PATH="$HOME/Library/Python/3.9/bin:$PATH"
