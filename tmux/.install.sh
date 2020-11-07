#/bin/sh

cd `dirname $0`
echo '- requirements: tmux, git'

ln -sF `pwd`/tmux.conf ~/.tmux.conf
mkdir -p ~/.local

# tmux-powerline
git clone https://github.com/erikw/tmux-powerline ~/.local/tmux-powerline

ln -sF `pwd`/tmux-powerlinerc ~/.tmux-powerlinerc
ln -sF `pwd`/mytheme.sh ~/.local/tmux-powerline/themes/mytheme.sh