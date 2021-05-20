#!/bin/sh


cd `dirname $0`
mkdir -p ~/.config/alacritty
ln -sF `pwd`/alacritty.yml ~/.config/alacritty/alacritty.yml
