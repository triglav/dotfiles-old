# ADD LOCAL CONFIGURATION HERE

export LANGUAGE="en_US:en"
export LC_MESSAGES="POSIX"
export LC_CTYPE="sk_SK"
export LC_COLLATE="sk_SK"
export LC_TIME="sk_SK"
export LC_NUMERIC="sk_SK"
export LC_MONETARY="sk_SK"
export LC_PAPER="sk_SK"
export LC_TELEPHONE="sk_SK"
export LC_ADDRESS="sk_SK"
export LC_MEASUREMENT="sk_SK"
export LC_NAME="sk_SK"

# DO NOT EDIT BELOW THIS LINE

export HISTFILE=~/.zsh_history
export HISTSIZE=1000
export SAVEHIST=1000

# colors!
autoload -U colors && colors
eval `dircolors -b`

# <3 Vim
bindkey -v
export EDITOR="vim"
export PAGER="less"

setopt nobeep nohistbeep nolistbeep                    # Don't be annoying
setopt autopushd pushdminus pushdsilent pushdtohome    # Keep directory history
setopt autocd                                          # Enter directories without cd
setopt cdablevars                                      # Follow directories in variables
setopt ignoreeof                                       # Type 'exit' to close shell
setopt nobanghist                                      # Banish csh bang hist
setopt noclobber                                       # Don't overwrite with '>'
setopt histreduceblanks histignorespace histignoredups # Remove useless things from hist
setopt shwordsplit                                     # Use compatible split
setopt nohup                                           # Don't kill bg processes
setopt prompt_subst                                    # Expand functions

autoload -U compinit && compinit
# Allow approximate
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric

# Tab completion for PID
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*' force-list always

# Don't select parent dir when cd
zstyle ':completion:*:cd:*' ignore-parents parent pwd

# Normal aliases
alias ls='ls --color=auto -F -1'
alias la='ls -A'
alias ll='ls -lh'
alias lla='ls -lhA'
alias lsd='ls -lhd *(-/DN)'
alias lsa='ls -lhd .*'
alias grep='grep --color=auto -n'
alias df='df -h'
alias du='du -c -h'
alias dh='dirs -v'
alias mkdir='mkdir -p -v'
alias f='find |grep'
alias c='clear'
alias hist="cat $HOME/.zsh_history |grep $1"
alias mem='free -m'
$(which colordiff &> /dev/null) && alias diff='colordiff'
alias sudo='command sudo '
alias :q='exit'
alias g='git'

# command L equivalent to command |less
alias -g L='|less'
# command S equivalent to command &> /dev/null &
alias -g S='&> /dev/null &'

# cute little todo list script
todo() {
  todo_file=$HOME/.todo
  if [ -z $1 ]; then
    awk '{ i += 1; print i": "$0 }' $todo_file
    return
  fi

  case $1 in
    add|a|-a)
      echo $2 >> $todo_file
    ;;
    del|d|-d)
      if [ -z $2 ]; then
        read -q "reply?clear entire todo list? [y|N] "
        [ $reply = 'y' ] || return
      fi
      sed -i "$2d" $todo_file
    ;;
    search|s|-s)
      grep -ni --color=never $2 $todo_file | sed -e 's/:/: /'
    ;;
  esac
}

preexec() {
}

precmd() {
  set-prompt
}

chpwd() {
  set-prompt
}

set-prompt() {
  git-prompt
  PS1="%{$fg_no_bold[white]%}%~ $GIT_PROMPT%(?.%{$fg_no_bold[green]%}>%{$fg_bold[green]%}>%{$fg_bold[yellow]%}>.%{$fg_no_bold[magenta]%}>%{$fg_bold[red]%}>%{$fg_bold[magenta]%}>)%{$reset_color%} "
  RPROMPT="%(?.%{$fg_bold[yellow]%}<%{$fg_bold[green]%}<%{$fg_no_bold[green]%}<.%{$fg_bold[magenta]%}<%{$fg_bold[red]%}<%{$fg_no_bold[magenta]%}<) %{$fg_no_bold[white]%}%n@%m%{$reset_color%}"
}

git-prompt() {
  st="$(git status 2>/dev/null)"
  if [[ -n "$st" ]]; then
    local -a arr
    arr=(${(f)st})

    if [[ $arr[1] =~ 'Not currently on any branch.' ]]; then
      git_branch='no-branch'
    else
      git_branch="${arr[1][(w)4]}";
    fi

    git_upstream=''
    # only do this if it's easy
    git_revs=($(git rev-list --count --left-right "@{upstream}"...HEAD 2>/dev/null))
    if [ $? -eq 0 ]; then
      [[ $git_revs[2] != "0" ]] && git_upstream+=":+$git_revs[2]"
      [[ $git_revs[1] != "0" ]] && git_upstream+=":-$git_revs[1]"
    fi

    if [[ $st =~ 'nothing to commit' ]]; then
      git_color='%{$fg_no_bold[green]%}'
    elif [[ $st =~ 'Changes to be committed' ]]; then
      git_color='%{$fg_no_bold[yellow]%}'
    else
      git_color='%{$fg_no_bold[red]%}'
    fi

    GIT_PROMPT="(${git_color}${git_branch}${git_upstream}%{$fg_no_bold[white]%}) "
  else
    unset GIT_PROMPT
  fi
}

# special keys shall work!
bindkey "\e[1~" beginning-of-line
bindkey "\e[2~" quoted-insert
bindkey "\e[3~" delete-char
bindkey "\e[4~" end-of-line
bindkey "\e[5~" beginning-of-history
bindkey "\e[6~" end-of-history
bindkey "\e[7~" beginning-of-line
bindkey "\e[8~" end-of-line
bindkey "\e[H" beginning-of-line
bindkey "\e[F" end-of-line
bindkey "\eOH" beginning-of-line
bindkey "\eOF" end-of-line
bindkey "\eOd" backward-word
bindkey "\eOc" forward-word
bindkey "\e[A" history-search-backward
bindkey "\e[B" history-search-forward

bindkey "^J" push-line
bindkey "^R" history-incremental-search-backward

set-prompt

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

