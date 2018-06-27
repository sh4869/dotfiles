if &compatible
	set nocompatible 
endif
augroup MyAutoCmd
	autocmd!
augroup END

let g:python3_host_prog = '/home/sh4869/.anyenv/envs/pyenv/versions/3.5.4/bin/python'

let s:dein_cache_path = expand('~/.cache/nvim/dein')
let s:dein_dir = s:dein_cache_path
			\ .'/repos/github.com/Shougo/dein.vim'

if &runtimepath !~ '/dein.vim'
	if !isdirectory(s:dein_dir)
		execute '!git clone https://github.com/Shougo/dein.vim' s:dein_dir
	endif
	execute 'set runtimepath+=' . fnamemodify(s:dein_dir, ':p')
endif

if dein#load_state(s:dein_cache_path)
	call dein#begin(s:dein_cache_path)
	call dein#load_toml('~/.vim/rc/nvim_dein.toml', {'lazy' : 0})
	call dein#load_toml('~/.vim/rc/nvim_dein_lazy.toml', {'lazy' : 1})
	call dein#end()
	call dein#save_state()
endif

if dein#check_install()
	call dein#install()
endif

set tabstop=2
set shiftwidth=2
set expandtab

let g:deoplete#enable_at_startup = 1

filetype plugin indent on
syntax enable

set number
