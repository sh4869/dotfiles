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
					ln -s ~/.dotfiles/.vimrc ~/.vimrc
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
		ln -s ~/.dotfiles/.vimrc ~/.vimrc
		echo "Replce .vimrc!!"
	fi

	echo "[NeoBundle Setting]"
	##Setting of NeoBundle
	
	if [ ! -d ~/.vim/bundle/neobundle.vim ]
	then
		if type git > /dev/null
		then 
			#SetUp Neobundle
			echo "Installing NeoBundle....."	
			mkdir -p ~/.vim/bundle
			git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim

			#Change mode of ~/.vim
			chmod +r -R ~/.vim/
			chmod +w -R ~/.vim/

			echo "Install Neobundle.vim"
			echo "And Change mode ~/.vim dir"
		else
			echo "Please Install Git for setting Neobundle"
		fi	
	else
		echo  "Neobundle Alredy Exists"
	fi
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
					ln -s ~/.dotfiles/.bashrc ~/.bashrc
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
		ln -s ~/.dotfiles/.bashrc ~/.bashrc
		echo "Replce .bashrc!!"
	fi
}

setting_vimrc
setting_bash

#rm ~/.vimrc ~/.bashrc ~/.gitconfig
#ln -s ~/.dotfiles/.vimrc ~/.vimrc
#ln -s ~/.dotfiles/.bashrc ~/.bashrc
#ln -s ~/.dotfiles/.gitconfig ~/.gitconfig
