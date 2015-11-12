" CREDIT TO dotfiles
" this .vimrc is taken from https://github.com/skwp/dotfiles/blob/master/vimrc
" Modified by kc1212

" Note: Skip initialization for vim-tiny or vim-small.
if 0 | endif

if has('vim_starting')
  if &compatible
    set nocompatible               " Be iMproved
  endif

  " Required:
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" My Bundles here:
" Refer to |:NeoBundle-examples|.
" Note: You don't set neobundle setting in .gvimrc!
NeoBundle 'kien/ctrlp.vim'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'christoomey/vim-tmux-navigator'
" NeoBundle 'itchyny/lightline.vim'
NeoBundle 'Shougo/neocomplete.vim' " need to have lua enabled, try install vim-youcompleteme package with vim-gtk
NeoBundle 'scrooloose/syntastic' " make sure external syntax checkers are installed, e.g. hlint
NeoBundle 'majutsushi/tagbar'
NeoBundle 'jlanzarotta/bufexplorer'

NeoBundle 'Shougo/vimproc.vim', {
\ 'build' : {
\     'windows' : 'tools\\update-dll-mingw',
\     'cygwin' : 'make -f make_cygwin.mak',
\     'mac' : 'make',
\     'linux' : 'make',
\     'unix' : 'gmake',
\    },
\ }

" Latex plugins
NeoBundle 'LaTeX-Box-Team/LaTeX-Box'

" Haskell plugins
NeoBundle 'eagletmt/neco-ghc'
NeoBundle 'eagletmt/ghcmod-vim'

call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck



" ================ General Config ====================

set number                      "Line numbers are good
set backspace=indent,eol,start  "Allow backspace in insert mode
set history=500                 "Store lots of :cmdline history
set showcmd                     "Show incomplete cmds down the bottom
set showmode                    "Show current mode down the bottom
set showmatch                   "Show matching brackets
set gcr=a:blinkon0              "Disable cursor blink
set visualbell                  "No sounds
set autoread                    "Reload files changed outside vim
set lazyredraw                  " Don't redraw while executing macros (good performance config)

" This makes vim act like all other editors, buffers can
" exist in the background without being in a window.
" http://items.sjbach.com/319/configuring-vim-right
set hidden

" turn on syntax highlighting
syntax on

" turn on ruler (vertical line)
set colorcolumn=80
highlight ColorColumn guibg=Gray14

" makefile
" take from http://stackoverflow.com/questions/729249/how-to-efficiently-make-with-vim
set makeprg=[[\ -f\ Makefile\ ]]\ &&\ make\ \\\|\\\|\ make\ -C\ ..
" map <F5> :make<CR><C-w><Up>

set mouse=a             " enable mouse activities for all, including scrolling

" ================ Search Settings  =================

set incsearch                       "Find the next match as we type the search
set hlsearch                        "Hilight searches by default, use :noh to reset
set viminfo='100,f1                 "Save up to 100 marks, enable capital marks
set tags=./tags;/,codex.tags;/      "set the ctags search directory, and for codex

" ================ Turn Off Swap Files ==============

set noswapfile
set nobackup
set nowb

" ================ Persistent Undo ==================
" Keep undo history across sessions, by storing in file.
" Only works all the time.

silent !mkdir ~/.vim/backups > /dev/null 2>&1
set undodir=~/.vim/backups
set undofile

" ================ Indentation ======================

set autoindent
set smartindent
set smarttab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set expandtab

" exception for c/cpp source files, alternatively use ftplugin
autocmd BufRead,BufNewFile *.c,*.cpp,*.h,*.hpp, set sw=8 sts=8 ts=8 noic cin noexpandtab

" Display tabs and trailing spaces visually
set list listchars=tab:\ \ ,trail:·

set nowrap       "Don't wrap lines
set linebreak    "Wrap lines at convenient points

" ================ Folds ============================

set foldmethod=indent   "fold based on indent
set foldnestmax=3       "deepest fold is 3 levels
set nofoldenable        "dont fold by default

" ================ Completion =======================

"set wildmode=list:longest
"set wildmenu                                   "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore+=*.o,*.so,*.exe,*.dll,*.obj,*~   "stuff to ignore when tab completing
"set wildignore+=*vim/backups*
"set wildignore+=*sass-cache*
set wildignore+=*DS_Store*
"set wildignore+=vendor/rails/**
"set wildignore+=vendor/cache/**
set wildignore+=*.gem
"set wildignore+=log/**
"set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif

" ================ Scrolling ========================

set scrolloff=8         "Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1

" ================ Key Bindings =====================
" TODO probably bad to use recursive mapping, see:
" http://learnvimscriptthehardway.stevelosh.com/chapters/05.html

" map escape sequence to alt, works for gvim?
for i in range(48,57) + range(65,90) + range(97,122)
  let c = nr2char(i)
  exec "set <A-".c.">=\e".c
endfor
set timeoutlen=1000 ttimeoutlen=0

nnoremap ; :

" don't move cursor after pressing * or #
nnoremap * *<C-o>
nnoremap # #<C-o>

" map <C-a> GVgg
" map <C-n> :enew
" map <C-o> :e . <CR>
" map <C-s> :w <CR>
" imap <C-s> <Esc><C-s>
" map <C-c> y

" moving in wraped text, nmap = normal mode map
nmap j gj
nmap k gk
nmap <Down> gj
nmap <Up> gk
xmap j gj
xmap k gk
xmap <Down> gj
xmap <Up> gk

" tabs
" map <C-t> :tabnew <CR>
" nnoremap <C-Left> :tabprevious<CR>
" nnoremap <C-Right> :tabnext<CR>
nnoremap <silent> <A-Left> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
nnoremap <silent> <A-Right> :execute 'silent! tabmove ' . tabpagenr()<CR>
map <A-1> 1gt
imap <A-1> <C-O>1gt " ctrl+o switches to normal mode for one command
map <A-2> 2gt
imap <A-2> <C-O>2gt
map <A-3> 3gt
imap <A-3> <C-O>3gt
map <A-4> 4gt
imap <A-4> <C-O>4gt
map <A-5> 5gt
imap <A-5> <C-O>5gt
map <A-6> 6gt
imap <A-6> <C-O>6gt
map <A-7> 7gt
imap <A-7> <C-O>7gt
map <A-8> 8gt
imap <A-8> <C-O>8gt

" leader remap
let mapleader = ','
nmap <leader>d :NERDTreeToggle<CR>
nmap <leader>f :NERDTreeFind<CR>

" copy and paste to os clipboard
" to enable system clipboard, i.e. "* and "+ registers, vim need to have clipboard enabled.
" try to install vim-gtk package and see below
" http://stackoverflow.com/questions/11489428/how-to-make-vim-paste-from-and-copy-to-systems-clipboard
nmap <leader>y "*y
vmap <leader>y "*y
nmap <leader>d "*d
vmap <leader>d "*d
nmap <leader>p "*p
vmap <leader>p "*p

" With the following, you can press F8 to show all buffers in tabs, or to
" close all tabs (toggle: it alternately executes :tab ball and :tabo)
let notabs = 1
nnoremap <silent> <F8> :let notabs=!notabs<Bar>:if notabs<Bar>:tabo<Bar>:else<Bar>:tab ball<Bar>:tabn<Bar>:endif<CR>

" ctags stuff
" adapted from http://stackoverflow.com/questions/563616/vim-and-ctags-tips-and-tricks
nmap <A-]> :pop<CR>
nmap <F3> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
" map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

" wrap lines for *.tex or *.txt files, taken from:
" http://vim.wikia.com/wiki/Word_wrap_without_line_breaks
autocmd BufRead,BufNewFile *.tex\|*.txt set wrap linebreak nolist textwidth=0 wrapmargin=0

" unmap ex mode
nnoremap Q <Nop>

" ==================== Plugins =========================
" ==== solarized colour ====
  set background=dark
  colorscheme solarized
  " call togglebg#map("<F6>")

" == prolog mode ===
  autocmd BufRead,BufNewFile *.pl set filetype=prolog

" ==== NERDTree ====
  " autocmd vimenter * NERDTree
  " autocmd vimenter * if !argc() | NERDTree | endif
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
  let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']
  map <f2> :NERDTreeToggle<CR>:NERDTreeMirror<CR>
  " Run NERDTree using :NERDTree
  " Type ? in NERDTree for help

" " ==== vim-lightline ====
"   set laststatus=2
"   let g:lightline = {
"     \ 'colorscheme': 'solarized',
"     \ }
"   " :help lightline

" ======= ctrlp =========
  let g:ctrlp_map = '<c-p>'
  let g:ctrlp_cmd = 'CtrlP'
  let g:ctrlp_working_path_mode = 'ra'
  let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/]\.(git|hg|svn)$',
    \ 'file': '\v\.(exe|so|dll|o|hi)$',
    \ 'link': 'some_bad_symbolic_links',
    \ }
  " Check :help ctrlp-options for other options.
  " http://kien.github.io/ctrlp.vim/

" ======= tagbar ========
  nmap <F9> :TagbarToggle<CR>

" ====== neocomplete ====
" taken from https://github.com/Shougo/neocomplete.vim
  " Disable AutoComplPop.
  let g:acp_enableAtStartup = 0
  " Use neocomplete.
  let g:neocomplete#enable_at_startup = 1
  " Use smartcase.
  let g:neocomplete#enable_smart_case = 1
  " Set minimum syntax keyword length.
  let g:neocomplete#sources#syntax#min_keyword_length = 3
  let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

  " Define dictionary.
  let g:neocomplete#sources#dictionary#dictionaries = {
      \ 'default' : '',
      \ 'vimshell' : $HOME.'/.vimshell_hist',
      \ 'scheme' : $HOME.'/.gosh_completions'
          \ }

  " Define keyword.
  if !exists('g:neocomplete#keyword_patterns')
      let g:neocomplete#keyword_patterns = {}
  endif
  let g:neocomplete#keyword_patterns['default'] = '\h\w*'

  " Plugin key-mappings.
  inoremap <expr><C-g>     neocomplete#undo_completion()
  inoremap <expr><C-l>     neocomplete#complete_common_string()

  " Recommended key-mappings.
  " <CR>: close popup and save indent.
  inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
  function! s:my_cr_function()
    return neocomplete#close_popup() . "\<CR>"
    " For no inserting <CR> key.
    "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
  endfunction
  " <TAB>: completion.
  inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
  " <C-h>, <BS>: close popup and delete backword char.
  inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
  inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
  inoremap <expr><C-y>  neocomplete#close_popup()
  inoremap <expr><C-e>  neocomplete#cancel_popup()
  " Close popup by <Space>.
  "inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"

  " For cursor moving in insert mode(Not recommended)
  "inoremap <expr><Left>  neocomplete#close_popup() . "\<Left>"
  "inoremap <expr><Right> neocomplete#close_popup() . "\<Right>"
  "inoremap <expr><Up>    neocomplete#close_popup() . "\<Up>"
  "inoremap <expr><Down>  neocomplete#close_popup() . "\<Down>"
  " Or set this.
  "let g:neocomplete#enable_cursor_hold_i = 1
  " Or set this.
  "let g:neocomplete#enable_insert_char_pre = 1

  " AutoComplPop like behavior.
  "let g:neocomplete#enable_auto_select = 1

  " Shell like behavior(not recommended).
  "set completeopt+=longest
  "let g:neocomplete#enable_auto_select = 1
  "let g:neocomplete#disable_auto_complete = 1
  "inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

  " Enable omni completion.
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

  " Disable omni completion.
  autocmd FileType tex,bib NeoCompleteLock

  " Enable heavy omni completion.
  if !exists('g:neocomplete#sources#omni#input_patterns')
    let g:neocomplete#sources#omni#input_patterns = {}
  endif
  "let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
  "let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
  "let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

  " For perlomni.vim setting.
  " https://github.com/c9s/perlomni.vim
  let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

" ====== syntastic ======
  "let g:syntastic_haskell_checkers = ['hlint']

" ====== ghcmod-vim =====
  " Type of expression under cursor
  nmap <silent> <leader>ht :GhcModType<CR>
  " Insert type of expression under cursor
  nmap <silent> <leader>hT :GhcModTypeInsert<CR>
  " GHC errors and warnings
  nmap <silent> <leader>hc :GhcModCheck<CR>



" ===================== OTHER ==========================
" Return to last edit position when opening files
augroup last_edit
  autocmd!
  autocmd BufReadPost *
       \ if line("'\"") > 0 && line("'\"") <= line("$") |
       \   exe "normal! g`\"" |
       \ endif
augroup END

" Remember info about open buffers on close
set viminfo^=%

" Switch between source and header, requires ctags
" TODO need to keep cursor position - we can do this using buffers
" perhaps find file path (cscope?) and do :e, leveraging on JumpCursorOnEdit
function! SwitchSourceHeader()
  if (expand ("%:e") == "cpp")
    exec "tag /^" . expand("%:t:r") . "\\.h\\(pp\\)\\?$"
    " exec "JumpCursorOnEdit_foo"
  elseif (expand ("%:e") == "c")
    exec "tag " . expand("%:t:r") . ".h"
  elseif (expand ("%:e") == "hpp")
    exec "tag " . expand("%:t:r") . ".cpp"
  elseif (expand ("%:e") == "h")
    exec "tag /^" . expand("%:t:r") . "\\.c\\(pp\\)\\?$"
  endif
endfunction
" disable this feature until this is implemented using buffers
" nmap <f4> :call SwitchSourceHeader()<CR>

" Fix Cursor in TMUX
" if exists('$TMUX')
"   let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
"   let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
" else
"   let &t_SI = "\<Esc>]50;CursorShape=1\x7"
"   let &t_EI = "\<Esc>]50;CursorShape=0\x7"
" endif


