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
set backspace=indent,eol,start

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
"" for window
nnoremap sw <C-w>w

set list 
set listchars=tab:>-,trail:_

function! ZenkakuSpace()
  highlight ZenkakuSpace cterm=reverse ctermfg=DarkMagenta gui=reverse guifg=DarkMagenta
endfunction

if has('syntax')
  augroup ZenkakuSpace
    autocmd!
    autocmd ColorScheme       * call ZenkakuSpace()
    autocmd VimEnter,WinEnter * match ZenkakuSpace /　/
  augroup END
  call ZenkakuSpace()
endif

"File set
au BufNewFile,BufRead Gemfile set filetype=ruby
au BufNewFile,BufRead *.ino set filetype=arduino
au BufNewFile,BufRead *.kn  set filetype=kuin
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
au BufNewFile,BufRead *.go set filetype=go

""NERDTree
nnoremap <silent><C-e> :NERDTreeToggle<CR>

"------------------- dein.vim ------------------------"

if &compatible
  set nocompatible
endif
let s:dein_dir = expand('~/.cache/dein')
" dein.vim 本体
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . s:dein_repo_dir
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
  call dein#load_toml(s:toml)
  call dein#load_toml(s:lazy_toml,{'lazy' : 1})
  " 設定終了
  call dein#end()
  call dein#save_state()
endif

" もし、未インストールものものがあったらインストール
if dein#check_install()
  call dein#install()
endif

if dein#tap('lightline.vim')
  let g:lightline = {
        \ 'colorscheme' : 'wombat',
        \ 'active': {
        \   'left': [ [ 'mode', 'paste' ],
        \             [ 'fugitive','readonly', 'filename', 'modified' ] ]
        \ },
        \ 'component_visible_condition': {
        \   'readonly': '(&filetype!="help"&& &readonly)',
        \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
        \   'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
        \ },
        \ 'component': {
        \   'readonly': '%{&readonly?"RO":""}',
        \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
        \   'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}'
        \ },
        \ 'separator': { 'left': "", 'right': "" },
        \ 'subseparator': { 'left': "|", 'right': "|" }
        \}
  set laststatus=2
endif

if dein#tap('neocomplete.vim')
  let g:acp_enableAtStartup = 0
  let g:neocomplete#enable_at_startup = 1
  let g:neocomplete#enable_smart_case = 1 
  " Set minimum syntax keyword length. 
  let g:neocomplete#sources#syntax#min_keyword_length = 3 
  let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'  
  " Define dictionary. 
  let g:neocomplete#sources#dictionary#dictionaries = {     
        \ 'default' : '',     
        \ 'vimshell' : $HOME.'/.vimshell_hist',     
        \ 'scheme' : $HOME .'/.gosh_completions',
        \ 'ruby' : $HOME . '/.dicts/ruby.dict'  
        \ }
  if !exists('g:neocomplete#keyword_patterns')     
    let g:neocomplete#force_omni_input_patterns = {}
    let g:neocomplete#keyword_patterns = {} 
  endif 
  let g:neocomplete#keyword_patterns['default'] = '\h\w*'
  inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
  let g:neocomplete#force_omni_input_patterns.cpp =
        \ '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'
endif

" CPP setting
"" NameSpace Setting

augroup cpp-namespace
  autocmd!
  autocmd FileType cpp inoremap <buffer><expr>; <SID>expand_namespace()
augroup END
function! s:expand_namespace()
  let s = getline('.')[0:col('.')-1]
  if s =~# '\<b;$'
    return "\<BS>oost::"
  elseif s =~# '\<s;$'
    return "\<BS>td::"
  elseif s =~# '\<d;$'
    return "\<BS>etail::"
  else
    return ';'
  endif
endfunction

augroup cpp-path
  autocmd!
  autocmd FileType cpp setlocal path=.,/usr/include,/usr/local/include,/usr/include/c++/4.8
augroup END

filetype plugin on
filetype indent on
syntax enable
