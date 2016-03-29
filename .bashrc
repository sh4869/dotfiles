[ -z "$PS1" ] && return

# history command setting
shopt -s histappend
HISTSIZE=10000
HISTFILESIZE=10000
HISTTIMEFORMAT='%y/%m/%d %H:%M:%S  '
HISTIGNORE=ls:la:ll:lla:history
HISTCONTROL=ignoreboth

# Check Window Size
shopt -s checkwinsize 

# read git completion file
source ~/.git-completion.bash
source ~/.git-prompt.sh

# Display Git branch		
length()  		
{		
	echo -n ${#1}		
}		

init-prompt-git-branch()		
{		
	git symbolic-ref HEAD 2>/dev/null >/dev/null &&		
	echo "($(git symbolic-ref HEAD 2>/dev/null | sed 's/^refs\/heads\///'))"		
}		

if which git 2>/dev/null >/dev/null		
then		
	export PS1_GIT_BRANCH='\[\e[$[COLUMNS]D\]\[\e[30m\]\[\e[$[COLUMNS-$(length $(init-prompt-git-branch))]C\]$(init-prompt-git-branch)\[\e[$[COLUMNS]D\]\[\e[0m\]'		
else		
	export PS1_GIT_BRANCH=		
fi		
GIT_PS1_SHOWDIRTYSTATE=true		

# bash prompt
PS1="\` 
if [ \$? = 0 ]; then 
	echo \[\e[34m\];  
else
	echo \[\e[31m\]; 
fi
\`\e[47m[\u@\H:\w]\e[30;46m \t $PS1_GIT_BRANCH \[\e[0m\]\n$"

GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWSTASHSTATE=true
GIT_PS1_SHOWUPSTREAM=auto

# terminal title
case $TERM in
	kterm|xterm|mlterm|cygwin|vt102)
		_termtitle="\h:\w"
		PS1="\[\e]0;${_termtitle}\007\]${PS1}"
		;;
esac

## My Function
# cd
mycd(){
	cd $1 && ls --color=auto -F
}

# gi ( gitignore.io command ) 
gi() { 
	curl -L -s https://www.gitignore.io/api/$@ 
}

# color
colors() {
	local fgc bgc vals seq0

	printf "Color escapes are %s\n" '\e[${value};...;${value}m'
	printf "Values 30..37 are \e[33mforeground colors\e[m\n"
	printf "Values 40..47 are \e[43mbackground colors\e[m\n"
	printf "Value  1 gives a  \e[1mbold-faced look\e[m\n\n"

	# foreground colors
	for fgc in {30..37}; do
		# background colors
		for bgc in {40..47}; do
			fgc=${fgc#37} # white
			bgc=${bgc#40} # black

			vals="${fgc:+$fgc;}${bgc}"
			vals=${vals%%;}

			seq0="${vals:+\e[${vals}m}"
			printf "  %-9s" "${seq0:-(default)}"
			printf " ${seq0}TEXT\e[m"
			printf " \e[${vals:+${vals+$vals;}}1mBOLD\e[m"
		done
		echo; echo
	done
}

#alias
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

# pkg config
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:${PKG_CONFIG_PATH}

# read local setting
[ -f ~/.bash_profile ] && source ~/.bash_profile

export NVM_DIR="/home/sh4869/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
