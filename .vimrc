" Normal Setting
set number
set title
set nocompatible
set ruler
set showmatch
set matchtime=1
set wildmenu
set display=lastline
set wrap
set smartindent
set expandtab
set tabstop=2
set shiftwidth=2
set clipboard=unnamed,autoselect
set synmaxcol=150
set scrolloff=5

" BackUp File
set noswapfile
set nobackup
set noundofile

syntax on

set mouse=a
set modifiable
set fileencoding=utf-8
setlocal formatoptions-=r
setlocal formatoptions-=o
autocmd FileType * setlocal formatoptions-=ro

if has('win32')
else 
  colorscheme molokai
endif
set t_Co=256
set background=dark
highlight Normal ctermbg=none

" Key bind
inoremap <silent> jj <ESC>

" 全角スペース
highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=#666666
au BufNewFile,BufRead * match ZenkakuSpace /　/

filetype plugin on
filetype indent on

"File set
au BufNewFile,BufRead *.ino set filetype=arduino
au BufNewFile,BufRead *.kn	set filetype=kuin
au BufNewFile,BufRead *.md  set filetype=markdown
au BufNewFile,BufRead *.dart set filetype=dart
au BufNewFile,BufRead *.tex set filetype=tex
au BufNewFile,BufRead *.qml set filetype=qml
au BufNewFile,BufRead *.qrc set filetype=xml
au BufNewFile,BufRead *.cpp set filetype=cpp
au BufNewFile,BufRead *.d set filetype=d
au BufNewFile,BufRead *.coffee set filetype=coffee
au BufNewFile,BufRead *.cr set filetype=crystal
au BufNewFile,BufRead *.hs set filetype=haskell

""C++
augroup cpp-path
	autocmd!
	autocmd FileType cpp setlocal path=.,/usr/include,/usr/local/include
augroup END

""NERDTree
nnoremap <silent><C-e> :NERDTreeToggle<CR>

let s:dein_dir = expand('~/.cache/dein')
" dein.vim 本体
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" dein.vim がなければ github から落としてくる
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

" 設定開始
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  " プラグインリストを収めた TOML ファイル
  " 予め TOML ファイル（後述）を用意しておく
  let g:rc_dir    = expand('~/.vim/rc')
  let s:toml      = g:rc_dir . '/dein.toml'
  let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'

  " TOML を読み込み、キャッシュしておく
  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  " 設定終了
  call dein#end()
  call dein#save_state()
endif

" もし、未インストールものものがあったらインストール
if dein#check_install()
  call dein#install()
endif
