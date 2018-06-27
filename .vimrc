" Normal Setting
"
" cmder
if has('win32')
  set t_Co=256
  let &t_AB="\e[48;5;%dm"
  let &t_AF="\e[38;5;%dm"
  "" For Cmder
  inoremap <Char-0x07F> <BS>
  noremap <Char-0x07F> <BS>
endif

set number
set nocompatible
set showmatch
set matchtime=1
set display=lastline
set wrap
set clipboard=unnamed,autoselect
set synmaxcol=320
set scrolloff=5
set backspace=2
set notitle

set noswapfile
set nobackup
set noundofile

set mouse=a

set fileencoding=utf-8
set encoding=utf-8

set ambiwidth=double

" Key bind
inoremap <silent> jj <ESC>
"" for window
nnoremap sw <C-w>w

" indent
set expandtab
set tabstop=2
set smartindent
set shiftwidth=2
set list
set listchars=tab:>-,trail:_,eol:↲

colorscheme iceberg

" Scheme
function! ZenkakuSpace()
  highlight ZenkakuSpace cterm=underline ctermfg=Red gui=reverse guifg=DarkMagenta
endfunction

syntax on

if has('syntax')
  augroup ZenkakuSpace
    autocmd!
    autocmd ColorScheme       * call ZenkakuSpace()
    autocmd VimEnter,WinEnter * match ZenkakuSpace /　/
  augroup END
  call ZenkakuSpace()
endif

" File set
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
au BufNewFile,BufRead *.rs set filetype=rust
au BufNewFile,BufRead *.ts set filetype=typescript
au BufNewFile,BufRead *.tsx set filetype=typescript
au BufNewFile,BufRead *.md set filetype=markdown
au BufNewFile,BufRead *.pug set filetype=pug
au BufNewFile,BufRead *.wat set filetype=wat
au BufNewFile,BufRead *.wasm set filetype=wasm
au BufNewFile,BufRead *.re set filetype=review

"--- Tab
nnoremap <S-Tab> gt
nnoremap <Tab><Tab> gT
for i in range(1, 9)
  execute 'nnoremap <Tab>' . i . ' ' . i . 'gt'
endfor

" dein.vim
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
        \   'readonly': '(&filetype!~# "\v(help|vimfiler|unite)"&& &readonly)',
        \   'modified': '(&filetype!~#"\v(help|vimfiler|unite)"&&(&modified||!&modifiable))',
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

if dein#tap('neosnippet.vim')
  imap <C-k>     <Plug>(neosnippet_expand_or_jump)
  smap <C-k>     <Plug>(neosnippet_expand_or_jump)
  xmap <C-k>     <Plug>(neosnippet_expand_target)
  smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
        \ "\<Plug>(neosnippet_exapnd_or_jump)"  : "\<TAB>"
endif

if dein#tap('rust.vim')
  let g:rustfmt_autosave = 1
endif

if dein#tap('syntastic')
  set statusline+=%#warningmsg#
  set statusline+=%{SyntasticStatuslineFlag()}
  set statusline+=%*
  let g:syntastic_always_populate_loc_list = 1
  let g:syntastic_auto_loc_list = 1
  let g:syntastic_check_on_open = 1
  let g:syntastic_check_on_wq = 0
endif

if dein#tap("vimfiler.vim")
  let g:vimfiler_as_default_explorer = 1
  let g:vimfiler_force_overwrite_statusline = 0
  let g:vimfiler_ignore_pattern = []
  nnoremap <silent><C-e> :VimFilerExplorer<CR>
endif

if dein#tap("vim-indent-guides")
  let g:indent_guides_start_level = 2
  let g:indent_guides_enable_on_vim_startup = 1
  let g:indent_guides_guide_size = 1
  let g:indent_guides_auto_colors = 0
  autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=white
  autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=darkgrey
endif

if dein#tap("vim-clang")
  let g:clang_cpp_options = '-std=c++11 -stdlib=libc++'
  let g:clang_include_sysheader = 0
endif

if dein#tap("lexima.vim")
  let g:lexima_enable_basic_rules = 1
endif

if dein#tap("AOJ.vim")
  let g:aoj#user_id = "sh4869"
endif

if dein#tap("vim-markdown")
  let g:vim_markdown_folding_disabled = 1
endif

if dein#tap("vimtex") 
  let g:vimtex_latexmk_continuous = 1
  let g:vimtex_view_general_viewer = "SumatraPDF"
  let g:vimtex_view_general_options
        \ = '-reuse-instance -forward-search @tex @line @pdf'
  let g:vimtex_view_general_options_latexmk = '-reuse-instance'
endif

filetype plugin on
filetype indent on
