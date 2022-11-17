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
Plug 'ctrlpvim/ctrlp.vim'
Plug 'altercation/vim-colors-solarized'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'scrooloose/syntastic', { 'for': ['python', 'rust', 'haskell', 'sh', 'c', 'cpp', 'scala', 'lua'] }
Plug 'scrooloose/nerdcommenter'
Plug 'jlanzarotta/bufexplorer'
Plug 'dense-analysis/ale', { 'for': 'rust' }

" Latex plugins
Plug 'lervag/vimtex', { 'for': 'tex' }

" Go plugins
Plug 'fatih/vim-go', { 'for': 'go', 'do': ':GoInstallBinaries' }

" Rust plugins
Plug 'rust-lang/rust.vim', { 'for': 'rust' }

" GNU Plot
Plug 'vim-scripts/gnuplot.vim'

" Scala
Plug 'derekwyatt/vim-scala', { 'for': 'scala' }

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
set lazyredraw                  "Don't redraw while executing macros (good performance config)
set nojoinspaces                "Get rid of double spaces

" This makes vim act like all other editors, buffers can
" exist in the background without being in a window.
" http://items.sjbach.com/319/configuring-vim-right
set hidden

" turn on syntax highlighting
syntax on

" turn on ruler (vertical line)
set colorcolumn=80
"highlight ColorColumn guibg=Gray14

" enable mouse activities for all, including scrolling
set mouse=a

" ================ Search Settings  =================

set ignorecase
set smartcase
set incsearch                       "Find the next match as we type the search
set hlsearch                        "Hilight searches by default, use :noh to reset
set viminfo='100,f1                 "Save up to 100 marks, enable capital marks
set tags=./tags;		    "Set the ctags search directory

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
autocmd BufRead,BufNewFile *.scala set sw=2 sts=2 ts=2 noic cin expandtab

" treat sage as python syntax
autocmd BufRead,BufNewFile *.sage,*.pyx,*.spyx set filetype=python

" Display tabs and trailing spaces visually
set list listchars=tab:\ \ ,trail:·

set nowrap       "Don't wrap lines
set linebreak    "Wrap lines at convenient points

" ================ Folds ============================

set foldmethod=indent   "fold based on indent
set foldnestmax=3       "deepest fold is 3 levels
set nofoldenable        "dont fold by default

" ================ Completion =======================

set wildmode=list:longest,full
set wildmenu                                    "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore+=*.o,*.so,*.exe,*.dll,*.obj,*~   "stuff to ignore when tab completing
set wildignore+=*vim/backups*
"set wildignore+=*sass-cache*
set wildignore+=*DS_Store*
"set wildignore+=vendor/rails/**
"set wildignore+=vendor/cache/**
set wildignore+=*.gem
"set wildignore+=log/**
"set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif,*.pdf

" ================ Scrolling ========================

"set scrolloff=4         "Start scrolling when we're 4 lines away from margins
"set sidescrolloff=15
set sidescroll=1

" ================ Key Bindings =====================
" map escape sequence to alt, works for gvim?
"for i in range(48,57) + range(65,90) + range(97,122)
"  let c = nr2char(i)
"  exec "set <A-".c.">=\e".c
"endfor
"set timeoutlen=1000 ttimeoutlen=0

" don't move cursor after pressing * or #
"nnoremap * *<C-o>
"nnoremap # #<C-o>

"noremap <C-a> GVgg
"noremap <C-n> :enew
"noremap <C-o> :e . <CR>
"noremap <C-s> :w <CR>
"inoremap <C-s> <Esc><C-s>
"noremap <C-c> y

" moving in wraped text, nmap = normal mode map
nnoremap j gj
nnoremap k gk
nnoremap <Down> gj
nnoremap <Up> gk
xnoremap j gj
xnoremap k gk
xnoremap <Down> gj
xnoremap <Up> gk

" leader remap
let mapleader = ','

" copy and paste to os clipboard
" to enable system clipboard, i.e. "* and "+ registers, vim need to have clipboard enabled.
" try to install vim-gtk package and see below
" http://stackoverflow.com/questions/11489428/how-to-make-vim-paste-from-and-copy-to-systems-clipboard
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>d "+d
vnoremap <leader>d "+d
nnoremap <leader>p "+p
vnoremap <leader>p "+p

" ctags stuff
" adapted from http://stackoverflow.com/questions/563616/vim-and-ctags-tips-and-tricks
" nnoremap <A-]> :pop<CR>
" nnoremap <F3> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
" noremap <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>
noremap <C-]> :ALEGoToDefinition<CR>

" wrap lines for text-type files, taken from:
" http://vim.wikia.com/wiki/Word_wrap_without_line_breaks
autocmd BufRead,BufNewFile *.tex\|*.txt\|*.md\|*.markdown set wrap linebreak nolist textwidth=0 wrapmargin=0

" markdown highlighting
" https://stackoverflow.com/questions/10964681/enabling-markdown-highlighting-in-vim
au BufNewFile,BufFilePre,BufRead *.md set filetype=markdown

" Don't use Ex mode, use Q for formatting
noremap Q gq

" ==================== Plugins =========================
" ==== solarized colour ====
  set background=light
  colorscheme solarized
  " call togglebg#map("<F6>")

" == prolog mode ===
  autocmd BufRead,BufNewFile *.pl set filetype=prolog

" ==== NERDTree ====
  nnoremap <leader>d :NERDTreeToggle<CR>
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

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
  " https://github.com/ctrlpvim/ctrlp.vim

" ====== syntastic ======
  "let g:syntastic_haskell_checkers = ['hlint']
  let g:syntastic_lua_checkers = ["luacheck"]
  let g:syntastic_lua_luacheck_args = "--std +love"

" ======= vim-go ========
" Disable scratch window
" https://github.com/fatih/vim-go/issues/415
  set completeopt=menu
  let g:go_fmt_command = "goimports"
  let g:go_metalinter_autosave = 1
  let g:go_def_mode = 'gopls'
  let g:go_info_mode = 'gopls'

  let g:syntastic_go_checkers = ['golint', 'govet', 'gometalinter']
  let g:syntastic_go_gometalinter_args = ['--disable-all', '--enable=errcheck']
  let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }

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

" ======= rust ==========
  " let g:rustfmt_autosave = 1

" ======= ale ===========
  let g:ale_linters = {
              \  'rust': ['analyzer'],
              \}
  
  set completeopt=menu,menuone,preview,noselect,noinsert
  let g:ale_completion_enabled = 1
  
  " ALE
  " Load all plugins now.
  " Plugins need to be added to runtimepath before helptags can be generated.
  packloadall
  " Load all of the helptags now, after plugins have been loaded.
  " All messages and errors will be ignored.
  silent! helptags ALL

" ===================== OTHER ==========================
if has("autocmd")
  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  autocmd!
  " In text files, always limit the width of text to 78 characters
  " autocmd BufRead *.txt set tw=78
  " When editing a file, always jump to the last cursor position
  autocmd BufReadPost *
  \ if line("'\"") > 0 && line ("'\"") <= line("$") |
  \   exe "normal! g'\"" |
  \ endif
  " don't write swapfile on most commonly used directories for NFS mounts or USB sticks
  autocmd BufNewFile,BufReadPre /media/*,/run/media/*,/mnt/* set directory=~/tmp,/var/tmp,/tmp
  " start with spec file template
  autocmd BufNewFile *.spec 0r /usr/share/vim/vimfiles/template.spec
  augroup END
endif

" Remember info about open buffers on close
set viminfo^=%

" Insert date
inoremap <F5> <C-R>=strftime("%Y-%m-%d")<CR>
