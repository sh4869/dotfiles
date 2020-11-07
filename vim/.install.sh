#/bin/sh

cd `dirname $0`
echo '- requirements: vim, git, wget'

mkdir -p ~/.vim/rc
mkdir -p ~/.vim/colors

ln -sF `pwd`/vimrc ~/.vimrc
ln -sF `pwd`/gvimrc ~/.gvimrc
# dein
ln -sF `pwd`/dein.toml ~/.vim/rc/dein.toml
ln -sF `pwd`/dein_lazy.toml ~/.vim/rc/dein_lazy.toml
# color scheme
wget https://raw.githubusercontent.com/cocopon/iceberg.vim/master/colors/iceberg.vim -O ~/.vim/colors/iceberg.vim
