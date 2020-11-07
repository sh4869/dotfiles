#/bin/sh

cd `dirname $0`
echo '- requirements: git'

ln -sF `pwd`/gitconfig ~/.gitconfig
ln -sF `pwd`/global_gitignore ~/.global_gitignore
