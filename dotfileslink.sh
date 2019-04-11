#! /bin/bash
echo "[START DOTFILES SETTING]"
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
          ln -s `pwd`/.vimrc ~/.vimrc
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
    ln -s `pwd`/vimrc ~/.vimrc
    echo "Replce .vimrc!!"
  fi
  rm -f ~/.vim/rc/*.toml
  mkdir -p $HOME/.vim/rc 
  ln -s `pwd`/vim/dein.toml ~/.vim/rc/dein.toml
  ln -s `pwd`/vim/dein_lazy.toml ~/.vim/rc/dein_lazy.toml
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
          ln -s `pwd`/bashrc ~/.bashrc
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
    ln -s `pwd`/bashrc ~/.bashrc
    echo "Replce .bashrc!!"
  fi
}

setting_gitconfig(){
  echo "[.gitconfig Setting]"
  #Setting of .bash
  if type curl > /dev/null
  then
    if [ ! -e ~/.git-completion.bash ]
    then
      echo "Installing .git-completion.bash file....."
      curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash > ~/.git-completion.bash
      curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh > ~/.git-prompt.sh
      echo "DONE!"
    fi
  fi
}

setting_vimrc
setting_bash
setting_gitconfig
