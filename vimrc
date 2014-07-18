" CREDIT TO dotfiles
" this .vimrc is taken from https://github.com/skwp/dotfiles/blob/master/vimrc
" Modified by kc

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" =============== Vundle Initialization ===============
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

Plugin 'kien/ctrlp.vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'scrooloose/nerdtree'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'itchyny/lightline.vim'

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

" makefile
" take from http://stackoverflow.com/questions/729249/how-to-efficiently-make-with-vim
set makeprg=[[\ -f\ Makefile\ ]]\ &&\ make\ \\\|\\\|\ make\ -C\ ..
" map <F5> :make<CR><C-w><Up>

set mouse=a             " enable mouse activities for all, including scrolling

" ================ Search Settings  =================

set incsearch        "Find the next match as we type the search
set hlsearch         "Hilight searches by default, use :noh to reset
set viminfo='100,f1  "Save up to 100 marks, enable capital marks
set tags=./tags;/    "set the ctags search directory

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
" set expandtab

filetype plugin on
filetype indent on

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
"set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
"set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing
"set wildignore+=*vim/backups*
"set wildignore+=*sass-cache*
"set wildignore+=*DS_Store*
"set wildignore+=vendor/rails/**
"set wildignore+=vendor/cache/**
"set wildignore+=*.gem
"set wildignore+=log/**
"set wildignore+=tmp/**
"set wildignore+=*.png,*.jpg,*.gif

" ================ Scrolling ========================

set scrolloff=8         "Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1

" ================ Key Bindings =====================

" map escape sequence to alt, works for gvim?
for i in range(48,57) + range(65,90) + range(97,122)
  let c = nr2char(i)
  exec "set <A-".c.">=\e".c
endfor
set timeoutlen=1000 ttimeoutlen=0

nnoremap ; :

" don't move cursor after pressing *
nnoremap * *<C-o>

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

" With the following, you can press F8 to show all buffers in tabs, or to
" close all tabs (toggle: it alternately executes :tab ball and :tabo)
let notabs = 1
nnoremap <silent> <F8> :let notabs=!notabs<Bar>:if notabs<Bar>:tabo<Bar>:else<Bar>:tab ball<Bar>:tabn<Bar>:endif<CR>

" ctags stuff
" adapted from http://stackoverflow.com/questions/563616/vim-and-ctags-tips-and-tricks
nmap <A-]> :pop<CR>
nmap <F3> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
" map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

" f4 src hdr toogle based on ctags, need to be generalised
" TODO keep cursor position after switching to or back from existing file
map <F4> :exec("tag ".expand("%:t:s,.hpp$,.X123X,:s,.cpp$,.hpp,:s,.X123X$,.cpp,"))<CR>

" wrap lines for *.tex or *.txt files, taken from:
" http://vim.wikia.com/wiki/Word_wrap_without_line_breaks
autocmd BufRead,BufNewFile *.tex\|*.txt set wrap linebreak nolist textwidth=0 wrapmargin=0


" ==================== Plugins =========================
" ==== solarized colour ====
  set t_Co=256 " set number of colors
  set background=dark
  colorscheme solarized
  " call togglebg#map("<F6>")
  " use the following line when using vim in terminal
  let g:solarized_termcolors=256

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

" ==== vim-lightline ====
  set laststatus=2
  let g:lightline = {
    \ 'colorscheme': 'solarized',
    \ }
  " :help lightline

" ======= ctrlp =========
  let g:ctrlp_map = '<c-p>'
  let g:ctrlp_cmd = 'CtrlP'
  let g:ctrlp_working_path_mode = 'ra'
  " Check :help ctrlp-options for other options.
  " http://kien.github.io/ctrlp.vim/

" ===================== OTHER ==========================
" Automatically cd into the directory that the file is in
" Useful when using :e to open files
autocmd BufEnter * execute "chdir ".escape(expand("%:p:h"), ' ')

" Restore cursor position to where it was before
augroup JumpCursorOnEdit
   au!
   autocmd BufReadPost *
            \ if expand("<afile>:p:h") !=? $TEMP |
            \   if line("'\"") > 1 && line("'\"") <= line("$") |
            \     let JumpCursorOnEdit_foo = line("'\"") |
            \     let b:doopenfold = 1 |
            \     if (foldlevel(JumpCursorOnEdit_foo) > foldlevel(JumpCursorOnEdit_foo - 1)) |
            \        let JumpCursorOnEdit_foo = JumpCursorOnEdit_foo - 1 |
            \        let b:doopenfold = 2 |
            \     endif |
            \     exe JumpCursorOnEdit_foo |
            \   endif |
            \ endif
   " Need to postpone using "zv" until after reading the modelines.
   autocmd BufWinEnter *
            \ if exists("b:doopenfold") |
            \   exe "normal zv" |
            \   if(b:doopenfold > 1) |
            \       exe  "+".1 |
            \   endif |
            \   unlet b:doopenfold |
            \ endif
augroup END

" Fix Cursor in TMUX
" if exists('$TMUX')
"   let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
"   let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
" else
"   let &t_SI = "\<Esc>]50;CursorShape=1\x7"
"   let &t_EI = "\<Esc>]50;CursorShape=0\x7"
" endif


