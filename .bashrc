[ -z "$PS1" ] && return


#history command setting
shopt -s histappend
HISTSIZE=10000
HISTFILESIZE=10000
HISTTIMEFORMAT='%y/%m/%d %H:%M:%S  '
HISTIGNORE=ls:la:ll:lla:history
HISTCONTROL=ignoreboth

shopt -s checkwinsize #ウィンドウの大きさのチェック & LINESとCOLUMNSの大きさの変更

#Gitの補完用のファイルを読み込みます
source ~/.git-completion.bash

#Gitのbranchを右側に表示する
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

#bashのプロンプトの設定
PS1="\n\` 
if [ \$? = 0 ]; then 
  echo \[\e[34m\];  
else
  echo \[\e[31m\]; 
fi
\`\e[47m[\u@\H \w ] \e[37;41m \t $PS1_GIT_BRANCH\[\e[0m\]\n$"


#ターミナルのタイトルを動的に変更していく
case $TERM in
  kterm|xterm|mlterm|cygwin|vt102)
	_termtitle="\h:\w"
	PS1="\[\e]0;${_termtitle}\007\]${PS1}"
	;;
esac


#cdを置き換える
function mycd(){
  cd $1 && ls --color=auto -F
}

function gi() { 
  curl -L -s https://www.gitignore.io/api/$@ 
}
function server(  ){
 python -m http.server  & 
}

#alias settings
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
alias cd='mycd'
alias c='clear'
alias subl='sublime_text'



#rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

#環境変数
PATH=$PATH:$HOME/arduino/
PATH=$PATH:$HOME/Build/Qt/5.3/gcc/bin
PATH=$PATH:$HOME/Build/Qt/Tools/QtCreator/bin
PATH=$PATH:$HOME/Build/skype-4.3.0.37
PATH=$PATH:$HOME/.pub-cache/bin
PATH=$PATH:$HOME/.vim/script
PATH=$PATH:$HOME/Build/dmd2/linux/bin32
PATH=$PATH:$HOME/Build/sublime_text_3
PATH=$PATH:$HOME/Build/dart-sdk/bin
PATH=$PATH:$HOME/Build/dub
PATH=$PATH:$HOME/.nodebrew/current/bin
PATH=$PATH:$HOME/Build/cmake-3.2.3-Linux-i386/bin
# pkg config
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:${PKG_CONFIG_PATH}

# The next line updates PATH for the Google Cloud SDK.
source '/home/sh4869/google-cloud-sdk/path.bash.inc'

# The next line enables bash completion for gcloud.
source '/home/sh4869/google-cloud-sdk/completion.bash.inc'
