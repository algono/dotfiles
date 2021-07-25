# Shared autostart commands (with output)
if [ -f ~/.shared_autostart ]; then
    . ~/.shared_autostart --with-output
fi

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Set up the prompt

autoload -Uz promptinit
promptinit
prompt adam1

setopt histignorealldups sharehistory

# Custom variables 
EDITOR=vim

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# Load powerline
if [ -f /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme ]
then
  # If the Arch Linux package 'zsh-theme-powerlevel10k' is installed, source it
  source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
else
  # In any other case, assume that it is located in the home folder
  source ~/powerlevel10k/powerlevel10k.zsh-theme
fi

# Custom ZSH Binds
bindkey '^ ' autosuggest-accept

# Load aliases and shortcuts if existent.
[ ! -f "$HOME/zsh/aliasrc" ] || source "$HOME/zsh/aliasrc"

# Load autosuggestions, syntax highlighting, and autojump
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
source /usr/share/autojump/autojump.zsh 2>/dev/null

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Shared autostart commands (no output)
if [ -f ~/.shared_autostart ]; then
    . ~/.shared_autostart --no-output
fi

# Source zsh-nvm plugin (if it exists)
# (https://github.com/lukechilds/zsh-nvm)

[ ! -f "$HOME/.zsh-nvm/zsh-nvm.plugin.zsh" ] || source "$HOME/.zsh-nvm/zsh-nvm.plugin.zsh"
