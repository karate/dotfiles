# AVIT ZSH Theme

# settings
typeset +H _current_dir="%{$fg[yellow]%}%~%{$reset_color%} "
typeset +H _return_status="%{$fg_bold[red]%}%(?..⍉)%{$reset_color%}"
typeset +H _user_host="%{$fg[green]%}%n@%m%{$reset_color%} "

PROMPT='
${_user_host}${_current_dir} $(git_prompt_info) 
%{$fg[$CARETCOLOR]%}$%{$resetcolor%} '

RPROMPT='%{$(echotc UP 3)%} ${_return_status} %{$(echotc DO 3)%}'

# Git prompt settings
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[blue]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=" %{$fg[green]%}✔%{$reset_color%}"

#ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[green]%}✚ "
#ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[yellow]%}⚑ "
#ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%}✖ "
#ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[blue]%}▴ "
#ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[cyan]%}§ "
#ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[white]%}◒ "

# LS colors, made with https://geoff.greer.fm/lscolors/
export LSCOLORS="excxdxdxBxegedabagacad"
export LS_COLORS='di=34:ln=32:so=33:pi=33:ex=1;31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43'
export GREP_COLOR='1;33'
