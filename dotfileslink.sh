#! /bin/bash
echo "[START DOTFILES SETTING]"
#Check File exit
setting_vimrc(){
  echo "[.vimrc Setting]"
  #Setting of .vimrc
  if [ -e ~/.vimrc ]
  then
	while true;do
	  echo ">> Do you remove .vimrc and replace .vimrc? [y/n]"
	  read answer
	  case $answer in
		y)
		  rm ~/.vimrc 
		  echo "Remove .vimrc"
		  ln -s ~/dotfiles/.vimrc ~/.vimrc
		  echo "And Replace .vimrc!!"
		  break
		  ;;
		n)
		  echo "Don't remove .vimrc"
		  break
		  ;;
		*)
		  echo "Plese input y or n"
		  ;;
	  esac
	done
  else
	ln -s ~/dotfiles/.vimrc ~/.vimrc
	echo "Replce .vimrc!!"
  fi
  rm ~/.vim/rc/*.toml
  ln -s ~/dotfiles/vim/dein.toml ~/.vim/rc/dein.toml
  ln -s ~/dotfiles/vim/dein_lazy.toml ~/.vim/rc/dein_lazy.toml

}

setting_bash(){
  echo "[.bashrc Setting]"
  #Setting of .bash
  if [ -e ~/.bashrc ]
  then
	while true;do
	  echo ">> Do you remove .bashrc and replace .bashrc? [y/n]"
	  read answer
	  case $answer in
		y)
		  rm ~/.bashrc 
		  echo "Remove .bashrc"
		  ln -s ~/dotfiles/.bashrc ~/.bashrc
		  echo "And Replace .bashrc!!"
		  break
		  ;;
		n)
		  echo "Don't remove .bashrc"
		  break
		  ;;
		*)
		  echo "Plese input y or n"
		  ;;
	  esac
	done
  else
	ln -s ~/dotfiles/.bashrc ~/.bashrc
	echo "Replce .bashrc!!"
  fi
}

setting_gitconfig(){
  echo "[.gitconfig Setting]"
  #Setting of .bash
  if type git > /dev/null
  then
	if [ -e ~/.gitconfig ]
	then
	  while true;do
		echo ">> Do you remove .gitconfig and replace .gitconfig? [y/n]"
		read answer
		case $answer in
		  y)
			rm ~/.gitconfig 
			echo "Remove .gitconfig"
			ln -s ~/dotfiles/.gitconfig ~/.gitconfig
			echo "And Replace .gitconfig!!"
			break
			;;
		  n)
			echo "Don't remove .gitconfig"
			break
			;;
		  *)
			echo "Plese input y or n"
			;;
		esac
	  done
	else
	  ln -s ~/dotfiles/.gitconfig ~/.gitconfig
	  echo "Replce .gitconfig!!"
	fi
  else
	echo "Please Install Git"
  fi
  
  if type curl > /dev/null
  then
	  if [ ! -e ~/.git-completion.bash ]
	  then
	  	echo "Installing .git-completion.bash file....."
		curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash > ~/.git-completion.bash
	    echo "DONE!"
	  fi
   fi
}

setting_vimrc
setting_bash
setting_gitconfig
