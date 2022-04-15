# Path to your oh-my-zsh installation.
export ZSH="$HOME/.config/zsh"

ZSH_THEME="avit_custom"

#bindkey -v

plugins=(git fzf drush abbrev-alias zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

HIST_STAMPS="%d/%m/%Y %H:%M"

# Do not store in history commands that start with space
setopt HIST_IGNORE_SPACE

# zsh-autosuggestion
ZSH_AUTOSUGGEST_USE_ASYNC=true
ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd completion)

# Abbreviations
abbrev-alias -g G="| grep"
abbrev-alias -g H="| head"

abbrev-alias i="vim ~/.config/i3/config"
abbrev-alias b="vim ~/.config/bspwm/bspwmrc"
abbrev-alias s="vim ~/.config/sxhkd/sxhkdrc"
abbrev-alias p="vim ~/.config/polybar/main.conf"

abbrev-alias t="vim ~/.tmux.conf"
abbrev-alias v="vim ~/.vimrc"
abbrev-alias z="vim ~/.zshrc"

abbrev-alias sd="sudo"
abbrev-alias sv="sudo -E vim"
abbrev-alias S="sudo systemctl"
abbrev-alias f="find . -name \"**\""
abbrev-alias j="journalctl -f"

# Ctrl-left/right
bindkey "\e[1;5C" forward-word
bindkey "\e[1;5D" backward-word
# Home / End
bindkey "\e[H"    beginning-of-line
bindkey "^[[1~"   beginning-of-line
bindkey "\e[F"    end-of-line
bindkey "^[[4~"   end-of-line
# Ctlr-u
bindkey \^U       backward-kill-line
# Up / Down
bindkey "^[[A"    history-beginning-search-backward
bindkey "^[[B"    history-beginning-search-forward

###########
# ALIASES #
###########
# reducted

alias ll="ls -lh"
alias la="ls -lha"

alias ..="cd .."
alias vim="nvim"
alias r="ranger"

###########
# EXPORTS #
###########
export EDITOR=vim
export LC_TIME="el_GR.UTF-8"
#export TERM=xterm-256color
#export TERM=termite
#export TERM=xterm-256color

# PATH
export PATH=$PATH:$HOME/.local/bin
# Android SDK
export ANDROID_SDK_ROOT="$HOME/Android/Sdk"
export ANDROID_TOOLS="$HOME/Android/Sdk/tools"
export ANDROID_PLATFORM_TOOLS="$HOME/Android/Sdk/platform-tools"
export PATH="$PATH:/opt/android-studio/bin:$ANDROID_HOME:$ANDROID_TOOLS:$ANDROID_PLATFORM_TOOLS:$ANDROID_SDK_ROOT/emulator"
#export JAVA_HOME=/usr/lib/jvm/default

# FZF default options
export FZF_PREVIEW_COMMAND="bat --color=always --style numbers,changes --theme=gruvbox-dark {}"
export FZF_DEFAULT_OPTS="--height=40% --preview='$FZF_PREVIEW_COMMAND'"
export FZF_CTRL_T_OPTS="--height=40% --preview='($FZF_PREVIEW_COMMAND)'"
export FZF_CTRL_R_OPTS="--height=40% --reverse --preview=''"
export FZF_ALT_C_OPTS="--height=40% --preview=''"

# Gnome keyring
#eval $(/usr/bin/gnome-keyring-daemon --components=secrets)
#export SSH_AUTH_SOCK

# Use kwallet for ssh and git keys
export SSH_ASKPASS='/usr/bin/ksshaskpass'
export GIT_ASKPASS='/usr/bin/ksshaskpass'

# Start ssh agent and Unlock ssh keys
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
  ssh-agent > "$XDG_RUNTIME_DIR/ssh-agent.env"
  #eval "$(<"$XDG_RUNTIME_DIR/ssh-agent.env")"
  #ssh-add
fi
if [[ ! "$SSH_AUTH_SOCK" ]]; then
  source "$XDG_RUNTIME_DIR/ssh-agent.env" > /dev/null
  #eval "$(<"$XDG_RUNTIME_DIR/ssh-agent.env")"
  #ssh-add
fi

# autostart X
if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
  #exec startx -- -keeptty 2> /dev/null
  exec startx
fi

# Transfer.sh
# https://transfer.sh/
transfer(){ if [ $# -eq 0 ];then echo "No arguments specified.\nUsage:\n  transfer <file|directory>\n  ... | transfer <file_name>">&2;return 1;fi;if tty -s;then file="$1";file_name=$(basename "$file");if [ ! -e "$file" ];then echo "$file: No such file or directory">&2;return 1;fi;if [ -d "$file" ];then file_name="$file_name.zip" ,;(cd "$file"&&zip -r -q - .)|curl --progress-bar --upload-file "-" "https://transfer.sh/$file_name"|tee /dev/null,;else cat "$file"|curl --progress-bar --upload-file "-" "https://transfer.sh/$file_name"|tee /dev/null;fi;else file_name=$1;curl --progress-bar --upload-file "-" "https://transfer.sh/$file_name"|tee /dev/null;fi;}
