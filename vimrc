" CREDIT TO dotfiles
" this .vimrc is taken from https://github.com/skwp/dotfiles/blob/master/vimrc
" Modified by kc1212

" Note: Skip initialization for vim-tiny or vim-small.
if 0 | endif

if &compatible
  set nocompatible               " Be iMproved
endif

" Start of plug
call plug#begin()

" My plugins here:
Plug 'kien/ctrlp.vim'
Plug 'altercation/vim-colors-solarized'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'scrooloose/syntastic' " make sure external syntax checkers are installed, e.g. hlint
Plug 'majutsushi/tagbar'
Plug 'jlanzarotta/bufexplorer'

" Latex plugins
Plug 'lervag/vimtex'

" Haskell plugins
Plug 'eagletmt/neco-ghc', { 'for': 'haskell' }
Plug 'eagletmt/ghcmod-vim', { 'for': 'haskell' }

" Go plugins
Plug 'fatih/vim-go'

" Rust plugins
Plug 'rust-lang/rust.vim'

" GNU Plot
Plug 'vim-scripts/gnuplot.vim'

call plug#end()

" Required:
filetype plugin indent on


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

" enable mouse activities for all, including scrolling
set mouse=a

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

" exception for c/cpp and golang source files, alternatively use ftplugin
autocmd BufRead,BufNewFile *.c,*.cpp,*.h,*.hpp,*.go set sw=8 sts=8 ts=8 noic cin noexpandtab

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

set scrolloff=4         "Start scrolling when we're 4 lines away from margins
set sidescrolloff=15
set sidescroll=1

" ================ Key Bindings =====================
" TODO probably bad to use recursive mapping, see:
" http://learnvimscriptthehardway.stevelosh.com/chapters/05.html

" map escape sequence to alt, works for gvim?
" for i in range(48,57) + range(65,90) + range(97,122)
"   let c = nr2char(i)
"   exec "set <A-".c.">=\e".c
" endfor
" set timeoutlen=1000 ttimeoutlen=0

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

" copy and paste to os clipboard
" to enable system clipboard, i.e. "* and "+ registers, vim need to have clipboard enabled.
" try to install vim-gtk package and see below
" http://stackoverflow.com/questions/11489428/how-to-make-vim-paste-from-and-copy-to-systems-clipboard
nmap <leader>y "+y
vmap <leader>y "+y
nmap <leader>d "+d
vmap <leader>d "+d
nmap <leader>p "+p
vmap <leader>p "+p

" With the following, you can press F8 to show all buffers in tabs, or to
" close all tabs (toggle: it alternately executes :tab ball and :tabo)
let notabs = 1
nnoremap <silent> <F8> :let notabs=!notabs<Bar>:if notabs<Bar>:tabo<Bar>:else<Bar>:tab ball<Bar>:tabn<Bar>:endif<CR>

" ctags stuff
" adapted from http://stackoverflow.com/questions/563616/vim-and-ctags-tips-and-tricks
nmap <A-]> :pop<CR>
nmap <F3> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
" map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

" wrap lines for text-type files, taken from:
" http://vim.wikia.com/wiki/Word_wrap_without_line_breaks
autocmd BufRead,BufNewFile *.tex\|*.txt\|*.md\|*.markdown set wrap linebreak nolist textwidth=0 wrapmargin=0

" markdown highlighting
" https://stackoverflow.com/questions/10964681/enabling-markdown-highlighting-in-vim
au BufNewFile,BufFilePre,BufRead *.md set filetype=markdown

" unmap ex mode
nnoremap Q <Nop>

" gui stuff
if has('gui_running')
    set guifont=DejaVu\ Sans\ Mono\ 12
endif


" ==================== Plugins =========================
" ==== solarized colour ====
  set background=dark
  colorscheme solarized
  " call togglebg#map("<F6>")

" == prolog mode ===
  autocmd BufRead,BufNewFile *.pl set filetype=prolog

" ==== NERDTree ====
  nmap <leader>d :NERDTreeToggle<CR>
  nmap <leader>f :NERDTreeFind<CR>
  " autocmd vimenter * NERDTree
  " autocmd vimenter * if !argc() | NERDTree | endif
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
  " map <f2> :NERDTreeToggle<CR>:NERDTreeMirror<CR>
  " Run NERDTree using :NERDTree
  " Type ? in NERDTree for help

" ======= ctrlp =========
  let g:ctrlp_map = '<c-p>'
  let g:ctrlp_cmd = 'CtrlP'
  let g:ctrlp_working_path_mode = 'ra'
  let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/]\.(git|hg|svn|bzr)$',
    \ 'file': '\v\.(o|so|exe|dll|hi|dyn_o|dyn_hi|aux|lof|fls|out|pyc|class)$',
    \ 'link': 'some_bad_symbolic_links',
    \ }
  " Check :help ctrlp-options for other options.
  " http://kien.github.io/ctrlp.vim/

" ======= tagbar ========
  nmap <F9> :TagbarToggle<CR>

" ====== syntastic ======
  "let g:syntastic_haskell_checkers = ['hlint']

" ====== ghcmod-vim =====
  " Type of expression under cursor
  au FileType haskell nmap <silent> <leader>ht :GhcModType<CR>
  " Insert type of expression under cursor
  au FileType haskell nmap <silent> <leader>hT :GhcModTypeInsert<CR>
  " GHC errors and warnings
  au FileType haskell nmap <silent> <leader>hc :GhcModCheck<CR>

" ======= vim-go ========
" Disable scratch window
" https://github.com/fatih/vim-go/issues/415
  set completeopt=menu

" ======= vimtex ========
  if !exists('g:ycm_semantic_triggers')
    let g:ycm_semantic_triggers = {}
  endif
  let g:ycm_semantic_triggers.tex = [
        \ 're!\\[A-Za-z]*cite[A-Za-z]*(\[[^]]*\]){0,2}{[^}]*',
        \ 're!\\[A-Za-z]*ref({[^}]*|range{([^,{}]*(}{)?))',
        \ 're!\\hyperref\[[^]]*',
        \ 're!\\includegraphics\*?(\[[^]]*\]){0,2}{[^}]*',
        \ 're!\\(include(only)?|input){[^}]*',
        \ 're!\\\a*(gls|Gls|GLS)(pl)?\a*(\s*\[[^]]*\]){0,2}\s*\{[^}]*',
        \ 're!\\includepdf(\s*\[[^]]*\])?\s*\{[^}]*',
        \ 're!\\includestandalone(\s*\[[^]]*\])?\s*\{[^}]*',
        \ ]


" ======= rust-lang =====
  " let g:rustfmt_autosave = 1

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

