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
set noswapfile
set smartindent
set tabstop=4
set shiftwidth=4
set clipboard=unnamed,autoselect
set synmaxcol=150
set scrolloff=5
set cursorline

syntax on

set mouse=a
set modifiable
set fileencoding=utf-8
setlocal formatoptions-=r
setlocal formatoptions-=o
autocmd FileType * setlocal formatoptions-=ro

colorscheme molokai
set t_Co=256
set background=dark
highlight Normal ctermbg=none

" Key bind
inoremap <silent> jj <ESC>

" 全角スペース
highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=#666666
au BufNewFile,BufRead * match ZenkakuSpace /　/

" Neobundle

if 0 | endif

if has('vim_starting')
	if &compatible
		set nocompatible               " Be iMproved
	endif

	" Required:
	set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle/')) "Installation check.

NeoBundleFetch "Shougo/neobundle.vim"

""" NeoBundleCheck

"" Vim systems extension
" Auto Completion Plugin 
NeoBundle 'Shougo/neocomplcache'
" User Interface
NeoBundle 'Shougo/unite.vim'
" Statusline extension Plugin
NeoBundle 'itchyny/lightline.vim'
" Vim web api plugin
NeoBundle 'mattn/webapi-vim'
" Open URI with browser
NeoBundle 'tyru/open-browser.vim'
" Git wrapper
NeoBundle 'tpope/vim-fugitive'
" A tree explorer plugin
NeoBundle 'scrooloose/nerdtree'
" Git viewer for vim
NeoBundle 'cohama/agit.vim'
" Interactive command execution
NeoBundle 'Shougo/vimproc.vim', {
			\ 'build' : {
			\     'linux' : 'make',
			\    },
			\ }
" EditorConfig File Plugin
NeoBundle 'editorconfig/editorconfig-vim'
" Vim Outliner
NeoBundle 'vim-voom/VOoM'
" Japanese Format
NeoBundle 'fuenor/JpFormat.vim'
" Gist Plugin
NeoBundle 'mattn/gist-vim'
"" Language Plugin
" Vim plugin for Ruby
NeoBundleLazy 'vim-ruby/vim-ruby', {
			\ 'autoload': {'filetypes' : ["ruby"] }
			\ }

" Vim Plugin for Node and javascript
NeoBundleLazy 'myhere/vim-nodejs-complete',{
			\ 'autoload' : {'filetypes' : ["javascript"] }
			\ }
NeoBundleLazy 'moll/vim-node', {
			\ 'autoload' : {'filetypes' : ["javascript"] }
			\ }
NeoBundleLazy 'heavenshell/vim-jsdoc',{
			\ 'autoload':{'filetypes':['javascript']}
			\ }

" Vim Plugin for html
NeoBundleLazy 'othree/html5.vim', {
			\ 'autoload': {'filetypes' : ['html'] }
			\ }

"Vim Plugin for arduino
NeoBundleLazy "sudar/vim-arduino-syntax",{
			\ 'autoload' : {'filetypes' : ['arduino'] }
			\ }

"Vim Plugin for css
NeoBundleLazy 'hail2u/vim-css3-syntax', {
			\ 'autoload' : {'filetypes' : ['css'] }
			\ }

" Vim plugin for dlang
NeoBundleLazy 'JesseKPhillips/d.vim', {
			\ 'autoload' : {'filetypes' : ['d'] }
			\ }

" Vim Plugin for coffee
NeoBundleLazy 'kchmck/vim-coffee-script' ,{
			\ 'autoload' : {'filetypes' : ['coffee'] }
			\ }

" Vim Plugin for haml
NeoBundleLazy 'tpope/vim-haml',{
			\ 'autoload':{'filetypes':['haml']}
			\ }

" Vim Plugin for Dart
NeoBundleLazy 'dart-lang/dart-vim-plugin',{
			\ 'autoload':{'filetypes':['dart']}
			\ }

" Vim Plugin for Typescript
NeoBundleLazy 'leafgarland/typescript-vim',{
			\ 'autoload':{'filetypes':['typescript']}
			\ }

NeoBundleLazy 'rhysd/vim-crystal',{
			\ 'autoload':{'filetypes':['crystal']}
			\ }

call neobundle#end()

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


"" Use neocomplcache.
if neobundle#tap('neocomplcache')
	let g:neocomplcache_enable_at_startup = 1
	" Use smartcase.
	let g:neocomplcache_enable_smart_case = 1
	" " Set minimum syntax keyword length.
	let g:neocomplcache_min_syntax_length = 3
	let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

	let g:neocomplcache_dictionary_filetype_lists = {
				\ 'default' : ''
				\ }
	inoremap <expr><Tab> pumvisible() ? "\<C-n>" : "\<Tab>"

	inoremap <expr><Down> neocomplcache#close_popup() . "\<Down>"
	inoremap <expr><Up> neocomplcache#close_popup() . "\<Up>"
endif

""C++
augroup cpp-path
	autocmd!
	autocmd FileType cpp setlocal path=.,/usr/include,/usr/local/include
augroup END

""NERDTree
nnoremap <silent><C-e> :NERDTreeToggle<CR>

""LightLine.vim
if neobundle#tap('lightline.vim')
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

