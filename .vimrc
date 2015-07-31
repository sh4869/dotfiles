set number
set title
set nocompatible
set ruler
set showmatch
set wildmenu
set noswapfile
set smartindent
set tabstop=4
set shiftwidth=4
set clipboard=unnamed,autoselect
set synmaxcol=120
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

"---neobundle--"

if 0 | endif

if has('vim_starting')
	if &compatible
		set nocompatible               " Be iMproved
	endif

	" Required:
	set runtimepath+=~/.vim/bundle/neobundle.vim/
endif
"
"      " Required:
call neobundle#begin(expand('~/.vim/bundle/'))"Installation check.
"NeoBundleCheck
" GitHubリポジトリにあるプラグインを利用する
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'vim-ruby/vim-ruby'
NeoBundle 'mattn/emmet-vim'
NeoBundle 'marijnh/tern'
NeoBundle 'mattn/gist-vim'
NeoBundle 'mattn/webapi-vim'
NeoBundle 'myhere/vim-nodejs-complete'
NeoBundle 'othree/html5.vim'
NeoBundle 'thinca/vim-quickrun'
NeoBundle "sudar/vim-arduino-syntax"
NeoBundle 'hail2u/vim-css3-syntax'
NeoBundle 'tyru/open-browser.vim'
NeoBundle 'davidhalter/jedi-vim'
NeoBundle 'vim-scripts/gnuplot.vim'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'Shougo/vimproc.vim'
NeoBundle 'Shirk/vim-gas'
NeoBundle 'JesseKPhillips/d.vim'
NeoBundle 'cohama/agit.vim'
NeoBundle 'justinmk/vim-dirvish.git'
NeoBundle 'moll/vim-node'
NeoBundle 'scrooloose/nerdtree'
NeoBundleLazy 'peterhoeg/vim-qml',{'autoload':{'filetypes':['qml']}}
NeoBundleLazy 'tpope/vim-haml',{'autoload':{'filetypes':['haml']}}
NeoBundleLazy 'dart-lang/dart-vim-plugin',{'autoload':{'filetypes':['dart']}}
NeoBundleLazy 'leafgarland/typescript-vim',{'autoload':{'filetypes':['typescript']}}
NeoBundleLazy 'jelera/vim-javascript-syntax', {'autoload':{'filetypes':['javascript']}}
NeoBundleLazy 'heavenshell/vim-jsdoc',{'autoload':{'filetypes':['javascript']}}
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'itchyny/lightline.vim'

call neobundle#end()

filetype plugin on
filetype indent on

let g:uer_emmet_settings = {'lang' : 'ja'}

"File set
au BufNewFile,BufRead *.ino set filetype=arduino
au BufNewFile,BufRead *.kn	set filetype=kuin
au BufNewFile,BufRead *.md  set filetype=markdown
au BufNewFile,BufRead *.dart set filetype=dart
au BufNewFile,BufRead *.tex set filetype=tex
au BufNewFile,BufRead *.qml set filetype=qml
au BufNewFile,BufRead *.qrc set filetype=xml
au BufNewFile,BufRead *.cpp set filetype=cpp
au BufNewFile *.tex 0r $HOME/.vim/template/tex.txt


"Neocomplcachelet g:acp_enableAtStartup = 0
"" Use neocomplcache.
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
let g:html_indent_script1="inc"
let g:html_indent_style1="inc"
let g:html_indent_inctags="html,body,head"

inoremap <expr><Down> neocomplcache#close_popup() . "\<Down>"
inoremap <expr><Up> neocomplcache#close_popup() . "\<Up>"

let g:indent_guides_auto_colors=0
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level=2
"autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=lightcyan
"autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=lightblue

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
