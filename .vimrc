" .vimrc {{{{{{

" configs {{{
set encoding=utf-8
scriptencoding utf-8

set nocompatible
set hidden
set nospell
set backspace=indent,eol,start
set autoindent
set autowrite
set autoread
filetype on
filetype plugin on
filetype indent on
syntax on
set number
set cursorline
set ruler
set smarttab
set wildmenu wildoptions=pum
set wildmenu wildmode=longest:full,full
set shiftwidth=4
set tabstop=4
set expandtab
set nobackup
set scrolloff=999
set nowrap
set incsearch
set ignorecase
set smartcase
set showcmd
set showmatch
set hlsearch
set timeoutlen=500
set history=5000
" set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx
" set clipboard=unnamedplus
if has('clipboard') && exists('$DISPLAY')
  set clipboard=unnamedplus
else
  set clipboard=autoselectplus
endif
set shortmess+=I
set nofoldenable
if !isdirectory($HOME."/.vim")
  call mkdir($HOME."/.vim", "", 0770)
endi
if !isdirectory($HOME."/.vim/undo-dir")
  call mkdir($HOME."/.vim/undo-dir", "", 0700)
endif
set undodir=~/.vim/undo-dir
set undofile
set listchars=tab:..,trail:_,extends:>,precedes:<,nbsp:~
set showbreak=\\
set list
set autochdir
set background=dark
" }}}

" autocmd {{{
augroup filetype_vim
  autocmd!
  autocmd FileType vim setlocal foldmethod=marker
augroup END

autocmd FileType help nnoremap <buffer> <CR> <C-]>
autocmd FileType help nnoremap <buffer> <BS> <C-T>

augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
augroup END

autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent loadview
" }}}

" mappings {{{
nnoremap <down>  gj
nnoremap <up>    gk
nnoremap dd      "_dd
nnoremap d       "_d
nnoremap c       "_c
nnoremap <del>   "_x
inoremap jk      <esc>
inoremap JK      <esc>
nnoremap <SPACE> <Nop>

let mapleader = " "
let g:mapleader = " "
let maplocalleader = ","
let g:maplocalleader = ","

nnoremap <silent> <leader>e          :e .<cr>
nnoremap <silent> <leader>n          :bn<cr>
nnoremap <silent> <leader>w          :w!<CR>
nnoremap <silent> <leader>q          :q<CR>
nnoremap <silent> <leader><ESC><ESC> :qa!<CR>
nnoremap <silent> <leader>m          :w<cr>:make<cr>
nnoremap <silent> <leader>x          :bd!<cr>
nnoremap <silent> <leader>c          :close<CR>
nnoremap <silent> <leader>t          :bot term<CR><C-W>N:res 10<cr>i
tnoremap <silent> <C-q>              <C-\><C-n>
nnoremap <silent> <C-l>              :nohlsearch<CR>

nnoremap <silent> <leader>v          :aboveleft<CR>:vs<CR><C-W><C-W>:enew<cr>
nnoremap <silent> <leader>h          :botrigh<CR>:split<CR><C-W><C-W>:enew<cr>
nnoremap <silent> <leader>z          :set wrap!<CR>

""" Move lines
function! s:swap_lines(n1, n2)
  let line1 = getline(a:n1)
  let line2 = getline(a:n2)
  call setline(a:n1, line2)
  call setline(a:n2, line1)
endfunction

function! s:swap_up()
  let n = line('.')
  if n == 1
    return
  endif

  call s:swap_lines(n, n - 1)
  exec n - 1
endfunction

function! s:swap_down()
  let n = line('.')
  if n == line('$')
    return
  endif

  call s:swap_lines(n, n + 1)
  exec n + 1
endfunction

noremap <silent> <c-k>               :call <SID>swap_up()<CR>
noremap <silent> <c-j>               :call <SID>swap_down()<CR>
vnoremap <silent> <C-k>              :m '<-2<CR>gv
vnoremap <silent> <C-j>              :m '>+1<CR>gv

""" Some stuff
nnoremap <silent> <localleader>v     :edit   $MYVIMRC<CR>
nnoremap <silent> <localleader>u     :source $MYVIMRC<CR>
nnoremap <leader>s                   :%s/
nnoremap <leader>r                   :%s/<C-r><C-w>//g<Left><Left>
nnoremap <leader>g                   :g/<C-r><C-w>/
nnoremap <silent> <leader><leader>o  :!nopen <C-r><C-f><CR>
nnoremap <silent> <leader>af         :Autoformat<CR>
nnoremap <silent> <leader>f          :Neoformat<CR>

nnoremap <silent> <leader><leader>b  :Buffers<cr>
nnoremap <silent> <leader><leader>f  :Files<CR>
nnoremap <silent> <leader><leader>m  :FZFMru<cr>
nnoremap <silent> <leader><leader>n  :History:<cr>
nnoremap <silent> <leader><leader>l  :Lines<cr>
nnoremap <silent> <leader><leader>j  :Marks<cr>
nnoremap <silent> <leader><leader>u  :UndotreeToggle<cr>
" }}}

" plugins {{{
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)')) | PlugInstall --sync | source $MYVIMRC | endif

call plug#begin()
Plug 'romainl/vim-cool'
Plug 'vim-scripts/YankRing.vim'
Plug 'arecarn/crunch.vim'
Plug 'arecarn/vim-selection'
Plug 'chrisbra/csv.vim'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/limelight.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'lervag/vimtex'
Plug 'mbbill/undotree'
Plug 'mg979/vim-visual-multi', { 'branch': 'master' }
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'sbdchd/neoformat'
Plug 'sheerun/vim-polyglot'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'vim-autoformat/vim-autoformat'
Plug 'wellle/targets.vim'
Plug 'yegappan/mru'
call plug#end()
" }}}

" plugins configs {{{

""" vim-cool config {{{
let g:cool_total_matches = 1
" }}}

""" Colorscheme {{{
set t_Co=256
set termguicolors

try
  colorscheme sorbet
" colorscheme wildcharm
" colorscheme stark-contrast
catch
  colorscheme desert
endtr
" }}}

""" Config for lightline {{{
set laststatus=2
set noshowmode
let g:lightline = {
      \ 'mode_map' : {
      \   'n' : 'N', 'i' : 'I', 'R' : 'R', 'v' : 'V', 'V' : 'V-L', "\<C-v>": 'V-B', 'c' : 'C', 's' : 'S', 'S' : 'S-L', "\<C-s>": 'S-B', 't': 'T'
      \  },
      \  'active': {
      \    'left': [['mode', 'paste' ], ['readonly', 'filename', 'modified']],
      \    'right': [['lineinfo'], ['percent'], ['filetype']]
      \  },
      \  'colorscheme' : 'powerline',
      \ }
" }}}

""" Config for Tcomment {{{
nnoremap <silent> <leader>/ :TComment<CR>
vnoremap <silent> <leader>/ :TComment<CR>
" }}}

""" Config for Coc {{{
if exists(':CocInfo')
  let g:coc_global_extensions = [
        \ 'coc-highlight',
        \ 'coc-prettier',
        \ 'coc-markdownlint',
        \ 'coc-texlab',
        \ 'coc-pyright',
        \ 'coc-json',
        \ ]

  if !empty(glob('~/.vim/plugged/coc.nvim'))
    call coc#config('colors.enable' , 'true')
    call coc#config('inlayHint.enable' , 'false')
  endif

  inoremap <silent><expr> <TAB>  coc#pum#visible()?coc#pum#next(1):CheckBackspace()?"\<Tab>":coc#refresh()

  inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

  " Make <CR> to accept selected completion item or notify coc.nvim to format
  " <C-g>u breaks current undo, please make your own choice

  inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

  function! CheckBackspace() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction
  " Use <c-space> to trigger completion
  if has('nvim')
    inoremap <silent><expr> <c-space> coc#refresh()
  else
    inoremap <silent><expr> <c-@> coc#refresh()
  endif
  " Highlight the symbol and its references when holding the cursor
  autocmd CursorHold * silent call CocActionAsync('highlight')
endif
" }}}

""" Config for fzf.vim {{{
let g:fzf_vim = {}
let g:fzf_vim.preview_window = ['right,50%', 'ctrl-/']
let g:fzf_vim.tags_command = 'ctags -R'
" }}}

""" Config for vimtex {{{
let g:vimtex_compiler_latexmk = {
      \ 'aux_dir' : '',
      \ 'out_dir' : '',
      \ 'callback' : 1,
      \ 'continuous' : 1,
      \ 'executable' : 'latexmk',
      \ 'hooks' : [],
      \ 'options' : [
      \   '-verbose',
      \   '-file-line-error',
      \   '-synctex=1',
      \   '-interaction=nonstopmode',
      \ ],
      \}

let g:vimtex_compiler_latexmk_engines = {
      \ '_'                : '-pdf',
      \ 'pdfdvi'           : '-pdfdvi',
      \ 'pdfps'            : '-pdfps',
      \ 'pdflatex'         : '-pdf',
      \ 'luatex'           : '-lualatex',
      \ 'lualatex'         : '-lualatex',
      \ 'xelatex'          : '-xelatex',
      \ 'context (pdftex)' : '-pdf -pdflatex=texexec',
      \ 'context (luatex)' : '-pdf -pdflatex=context',
      \ 'context (xetex)'  : '-pdf -pdflatex=''texexec --xtx''',
      \}

let g:vimtex_view_general_viewer = 'zathura'

" }}}

""" Config for Yankring {{{
let g:yankring_window_use_horiz = 1
let g:yankring_window_use_bottom = 1
let g:yankring_window_height = 16
let g:yankring_history_file = '.yankring-history'
nnoremap <silent> <leader>p :YRShow<CR>
" }}}

" }}}

" }}}

" vim: set sw=2 ts=2 sts=2 et tw=80 ft=vim fdm=marker fmr={{{,}}}:
