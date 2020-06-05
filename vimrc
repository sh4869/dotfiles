scriptencoding utf-8
""" sh4869 .vimrc

" > 標準設定
set fileencoding=utf-8
set encoding=utf-8
"" 表示関連設定
set number
set wrap
set ambiwidth=double
set display=lastline
set list
set listchars=tab:>-,trail:_
set showmatch
set matchtime=1
set synmaxcol=320
"" 編集系
set expandtab
set tabstop=2
set smartindent
set shiftwidth=2
set backspace=2
"" 操作系
set mouse=a
set clipboard=unnamed,autoselect
set scrolloff=5
"" ファイル系
set nobackup
set noundofile
set noswapfile
"" その他
set notitle
"" カラースキーマ
"> キーボード
inoremap <silent> jj <ESC>
nnoremap sw <C-w>w

colorscheme iceberg
colorscheme default

"> dein.vim
let s:dein_dir = expand('~/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . s:dein_repo_dir
endif

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)
  let g:rc_dir    = expand('~/.vim/rc')
  let s:toml      = g:rc_dir . '/dein.toml'
  let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'
  call dein#load_toml(s:toml)
  call dein#load_toml(s:lazy_toml,{'lazy' : 1})
  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif

" > char count
augroup char_counter
  autocmd!
  autocmd BufNew,BufEnter,BufWrite,InsertCharPre * call <SID>char_count_update()
augroup END

function! s:char_count_update()
  let b:char_counter_count = s:char_count()
endfunction

function! s:char_count()
  let l:result = 0
  for l:linenum in range(0, line('$'))
    let l:line = getline(l:linenum)
    let l:result += strlen(substitute(l:line, ".", "x", "g"))
  endfor
  return l:result
endfunction

" > plugins
if dein#tap('lightline.vim')
  let g:lightline = {
        \ 'colorscheme' : 'wombat',
        \ 'active': {
        \   'left': [ [ 'mode', 'paste' ],
        \             [ 'fugitive','readonly', 'filename', 'modified', 'char_counter' ] ],
        \ },
        \ 'component_visible_condition': {
        \   'readonly': '(&filetype!~# "\v(help|vimfiler|unite)"&& &readonly)',
        \   'modified': '(&filetype!~#"\v(help|vimfiler|unite)"&&(&modified||!&modifiable))',
        \   'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
        \ },
        \ 'component': {
        \   'char_counter': '%{b:char_counter_count}',
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

function! ZenkakuSpace()
  highlight ZenkakuSpace cterm=underline ctermfg=Blue gui=underline guifg=Blue
endfunction

if has('syntax')
  augroup ZenkakuSpace
    autocmd!
    autocmd ColorScheme       * call ZenkakuSpace()
    autocmd VimEnter,WinEnter * match ZenkakuSpace /　/
  augroup END
  call ZenkakuSpace()
endif

if has("win32") && !has("gui_running")
    set term=xterm
    set t_Co=256
    let &t_AB="\e[48;5;%dm"
    let &t_AF="\e[38;5;%dm"
    inoremap <Char-0x07F> <BS>
    nnoremap <Char-0x07F> <BS>
    colorscheme iceberg
endif

nnoremap j gj
nnoremap k gk
nnoremap <Down> gj
nnoremap <Up>   gk

syntax on
filetype plugin indent on
