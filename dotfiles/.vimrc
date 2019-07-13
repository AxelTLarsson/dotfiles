au FileType gitcommit set tw=72
set nocompatible                " be iMproved, required
filetype off                    " required
set hidden                      " allow multiple files to be opened in diff buffers, 'hidden' in bg

" For indentation w/o tabs, principle is to set expandtab, and set shiftwidth
" and softtabstop to the same value, leaving tabstop at default (8)
set expandtab       " inserts `softtabstop` amount of space chars
set shiftwidth=2    " indentation, (<<,>>, ==)
set softtabstop=2   " insert 2 spaces

" ---- Vundle ----
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'Alok/notational-fzf-vim'
Plugin 'Chiel92/vim-autoformat'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'elmcast/elm-vim'
Plugin 'godlygeek/tabular'
Plugin 'jiangmiao/auto-pairs'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'junegunn/goyo.vim'                " Distraction-free writing
Plugin 'junegunn/limelight.vim'           " Hyperfocus-writing
Plugin 'mxw/vim-jsx'
Plugin 'pangloss/vim-javascript'
Plugin 'plasticboy/vim-markdown'
Plugin 'reedes/vim-pencil'
Plugin 'ryanoasis/vim-devicons'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'sheerun/vim-polyglot'
Plugin 'shougo/deoplete.nvim'             " Async completion fw for neovim
Plugin 'skwp/greplace.vim'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'vim-scripts/bats.vim'
Plugin 'w0ng/vim-hybrid'                  " Colorscheme
Plugin 'w0rp/ale'                         " For LSP
Plugin 'zchee/deoplete-jedi'              " Autocompletion, static anal for Python
set encoding=utf8

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

"Use 24-bit (true-color) mode in Vim/Neovim
if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
"For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
"Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
" < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
if (has("termguicolors"))
  set termguicolors
endif
set t_8f=[38;2;%lu;%lu;%lum
set t_8b=[48;2;%lu;%lu;%lum

" Theme
syntax enable
set background=dark
colorscheme hybrid
" let g:hybrid_custom_term_colors = 1

" always show the status bar
set laststatus=2

" Airline commands
let g:airline_powerline_fonts = 1
let g:airline_theme='hybrid'

set noshowmode " do not display "-- INSERT --" since that is unnecessary with airline
set hlsearch
set incsearch
set number
set cursorline " highlight current line
set conceallevel=2

" Set lazyredraw for better performance when scrolling
set lazyredraw

" More natural splits
set splitbelow
set splitright

" Clear highlighting on escape in Normal mode
nnoremap <esc> :noh<return><esc>
nnoremap <esc>^[ <esc>^[

" Rebind leader key
let mapleader = ","
set autoindent

" Search current word with Rg
set keywordprg=:Rg

" FZF: invoke it with Ctrl+P
nnoremap <C-p> :FZF<cr>

" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" Move lines down with Ctrl-J and up with Ctrl-K
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==

inoremap <C-j> <ESC>:m .+1<CR>==gi
inoremap <C-k> <ESC>:m .-2<CR>==gi

vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv


" NERDCommenters add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use deoplete
" let g:deoplete#enable_at_startup = 1

" Copy to clipboard
vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg_
nnoremap  <leader>y  "+y
nnoremap  <leader>yy  "+yy

" Paste from clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P

" Persistent undo
if exists('*mkdir') && !isdirectory($HOME.'/.vim/history')
  call mkdir($HOME.'/.vim/history')
endif
set undofile                    " Save undo's after file closes
set undodir=$HOME/.vim/history  " where to save undo histories
set undolevels=1000             " How many undos
set undoreload=10000            " number of lines to save for undo
set updatecount=100
set directory=$HOME/.vim/history/swap//


" Autoformat
" let g:autoformat_verbosemode = 1
let g:formatters_python = ['yapf'] " pip install yapf

" Open NERDTree automatically if directory specified (i.e. vim .)
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
let NERDTreeMinimalUI = 1

" vim-markdown
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_new_list_item_indent = 2
let g:vim_markdown_math = 1


" Zen Mode
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

" Set syntax error for nbsp, except for NERDTree
fun! SyntaxErrorOnNbsp()
  " Don't do it for NERDTree
  if &ft =~ 'nerdtree'
    return
  endif
  call matchadd("Error", " ", -1)
endfun

autocmd BufEnter,WinEnter * call SyntaxErrorOnNbsp()

" notational-fzf-vim
let g:nv_search_paths = ['../notes', './notes', '~/notes']

" polyglot
let g:polyglot_disabled = ['elm'] " elmcast/elm-vim covers this better
