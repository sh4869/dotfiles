[ -z "$PS1" ] && return

HISTCONTROL=ignoreboth

shopt -s histappend

HISTSIZE=10000
HISTFILESIZE=10000

HISTTIMEFORMAT='%y/%m/%d %H:%M:%S  '
HISTIGNORE=ls:la:ll:lla:history
HISTCONTROL=ignoreboth


shopt -s checkwinsize


[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
  debian_chroot=$(cat /etc/debian_chroot)
fi

case "$TERM" in
  xterm-color) color_prompt=yes;;
esac


if [ -n "$force_color_prompt" ]; then
  if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	color_prompt=yes
  else
	color_prompt=
  fi
fi

if [ "$color_prompt" = yes ]; then
  PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
  PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

case "$TERM" in
  xterm*|rxvt*)
	PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
	;;
  *)
	;;
esac

if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'

  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

#aliases
alias ls='ls -F --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias sl='ls'
alias lcd='cd'
alias lscd='cd'
alias cdvim='vim'
alias vvim='vim'
alias vimm='vim'
alias ks='ls'


if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
  . /etc/bash_completion
fi
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

#Added PATHs
PATH=$PATH:/home/sh4869/Build/dart
PATH=$PATH:/home/sh4869/Build/dart/dart-sdk/bin
PATH=$PATH:/home/sh4869/arduino/
PATH=$PATH:/home/sh4869/Build/Qt/5.3/gcc/bin
PATH=$PATH:/home/sh4869/Build/Qt/Tools/QtCreator/bin
PATH=$PATH:/home/sh4869/Build/skype-4.3.0.37
PATH=$PATH:/home/sh4869/.pub-cache/bin
PATH=$PATH:/home/sh4869/.vim/script
PATH=$PATH:/home/sh4869/Build/dmd2/linux/bin32
PATH=$PATH:/home/sh4869/Build/sublime_text_3

source ~/.git-completion.bash

#My original Functions
texcompile() {
  platex $1.tex
  dvipdfmx $1
}
function length()
{
  echo -n ${#1}
}

function init-prompt-git-branch()
{
  git symbolic-ref HEAD 2>/dev/null >/dev/null &&
	echo "($(git symbolic-ref HEAD 2>/dev/null | sed 's/^refs\/heads\///'))"
}

if which git 2>/dev/null >/dev/null
then
  export PS1_GIT_BRANCH='\[\e[$[COLUMNS]D\]\[\e[1;31m\]\[\e[$[COLUMNS-$(length $(init-prompt-git-branch))]C\]$(init-prompt-git-branch)\[\e[$[COLUMNS]D\]\[\e[0m\]'
else
  export PS1_GIT_BRANCH=
fi
GIT_PS1_SHOWDIRTYSTATE=true

PS1="\n\`
if [ \$? = 0 ]; then 
  echo \[\e[34m\]; 
else
  echo \[\e[31m\]; 
fi
\`\e[47m[\u@\H \w ] \e[37;41m \t $PS1_GIT_BRANCH\[\e[0m\]\n$"

case $TERM in
  kterm|xterm|mlterm|cygwin|vt102)
	_termtitle="\h:\w"
	PS1="\[\e]0;${_termtitle}\007\]${PS1}"
	;;
esac

mycd(){
  cd $1 && ls --color=auto -F
}
alias cd='mycd'
alias c='clear'
alias subl='sublime_text'

function gi() { curl -L -s https://www.gitignore.io/api/$@ ;}
function server(){
	python -mSimpleHTTPServer  $1 &
}
alias qmake='/home/sh4869/Build/Qt/5.3/gcc/bin/qmake'
