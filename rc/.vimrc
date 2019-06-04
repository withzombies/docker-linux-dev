filetype off
call pathogen#infect()
call pathogen#helptags()
filetype on

" this is vim, not vi
set nocompatible

" makes mouses happy
set ttymouse=xterm2
set mouse=a

" per-filetype syntax highlighting
syntax on

" per-filetype indenting
filetype indent on

set tabstop=4
set shiftwidth=4
" set softtabstop=4

" NO means DON'T convert tabs to spaces
set noexpandtab

autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete

" per-filetype options and commands
filetype plugin on

" better backspace
set backspace=indent,eol,start

" automatic indenting
set autoindent

" smart indenting
set smartindent

" blink matching brackets
set showmatch

" ignore case while searching
set ignorecase

" show the results of a search as it is typed
set incsearch

" highlight search results
set hlsearch

" show commands as they are typed
set showcmd

" show cursor position
set ruler

" put new splits on the bottom and right
set splitbelow
set splitright

" no backup files
set backup
" same option
set writebackup

" no modelines
set nomodeline

" no timeout for mappings
set notimeout

" timeout after 1/100 second for keycodes
set ttimeout
set ttimeoutlen=10

" use Q for formatting, not Ex mode
map Q gq

colorscheme desert
if &t_Co > 2 || has("gui_running")
	syntax on
endif
if &t_Co == 256
	colorscheme gardener3
endif

" Have Vim jump to the last position when reopening a file
if has("autocmd")
	au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" don't make noise
set noerrorbells

" I have no idea what this does
set nostartofline

" Show line numbers
set number

" Round indent to multiple of 'shiftwidth'
set shiftround

" I have no idea what this is for, but it has a cool name
" posix regular expressions \v for Very magic
" \V for Very No Magic
set magic

" foldenable allows folding on startup
set nofoldenable
set foldlevel=0

" fold easily with Ctrl-c
nmap <C-c> zfi}

" stop cursor from blinking (gvim only)
set guicursor=a:blinkwait0,a:blinkon0,a:block-cursor

" tags file for ctags
set tags=tags;

" always switch to the current file directory
" this can make ctags act stupidly
set autochdir

set undofile
set undodir=~/.vim/undodir

" fix vim background in screen
set t_ut=
