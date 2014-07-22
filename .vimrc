set number
set notitle
set nocompatible
set title
set showmatch
set wildmenu
set showcmd
set noswapfile
set smartindent
set tabstop=4
set shiftwidth=2
set clipboard=unnamed,autoselect
syntax on
set mouse=a
set fileencoding=utf-8
setlocal formatoptions-=r
setlocal formatoptions-=o
"---calendar--"
let g:calendar_google_calendar = 1
let g:calendar_google_task = 1

"---neobundle--"
set nocompatible               " Be iMproved
filetype off                   " Required!

if has('vim_starting')
	  set runtimepath+=~/.vim/bundle/neobundle.vim/
  endif

  call neobundle#rc(expand('~/.vim/bundle/'))

  filetype plugin indent on     " Required!

  "Installation check.
  if neobundle#exists_not_installed_bundles()
  echomsg 'Not installed bundles : ' .
             \ string(neobundle#get_not_installed_bundle_names())
               echomsg 'Please execute ":NeoBundleInstall" command.'
    "finish
  endif
"Installation check.
"NeoBundleCheck
" GitHubリポジトリにあるプラグインを利用する
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'vim-ruby/vim-ruby'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'tatt61880/kuin_vim'
NeoBundle 'mattn/emmet-vim'
NeoBundle 'marijnh/tern'
NeoBundle 'mattn/gist-vim'
NeoBundle 'mattn/webapi-vim'
NeoBundle 'myhere/vim-nodejs-complete'
NeoBundle 'othree/html5.vim'
NeoBundle 'itchyny/calendar.vim'
NeoBundle 'scrooloose/nerdtree.git'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'rbtnn/puyo.vim'
NeoBundle "sudar/vim-arduino-syntax"
NeoBundle 'hail2u/vim-css3-syntax'
NeoBundle 'tpope/vim-rails'
NeoBundle 'dart-lang/dart-vim-plugin'
NeoBundle 'jcf/vim-latex'
NeoBundle 'tyru/open-browser.vim'
NeoBundle 'basyura/twibill.vim'
NeoBundle 'basyura/TweetVim'
"GitHub以外のGitリポジトリにあるプラグインを利用するn on
" vim-scripts リポジトリにあるプラグインを利用する
"Git以外のリポジトリにあるプラグインを利用する
filetype plugin on
filetype indent on
nmap <silent> <C-e>      :NERDTreeToggle<CR>
vmap <silent> <C-e> <Esc>:NERDTreeToggle<CR>
omap <silent> <C-e>      :NERDTreeToggle<CR>
imap <silent> <C-e> <Esc>:NERDTreeToggle<CR>
cmap <silent> <C-e> <C-u>:NERDTreeToggle<CR>
autocmd vimenter * if !argc() | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
let g:NERDTreeIgnore=['\.clean$', '\.swp$', '\.bak$', '\~$']
let g:NERDTreeShowHidden=1
let g:NERDTreeMinimalUI=1
let g:NERDTreeDirArrows=0
let g:NERDTreeMouseMode=2
let g:uer_emmet_settings = {'lang' : 'ja'}
au BufNewFile,BufRead *.ino set filetype=arduino
au BufNewFile,BufRead *.kn	set filetype=kuin
au BufNewFile,BufRead *.md  set filetype=markdown
au BufNewFile,BufRead *.dart set filetype=dart
au BufNewFile,BufRead *.tex set filetype=tex
au BufNewFile *.tex 0r $HOME/.vim/template/tex.txt

"Dart
au BufNewFile pubspec.yaml 0r $HOME/.vim/template/pubspec.yaml
"Vim LaTeX
