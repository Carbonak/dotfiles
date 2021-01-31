set tabstop=4
set shiftwidth=4
set smarttab
set expandtab
set softtabstop=4
set autoindent
set background=dark
set incsearch
set hlsearch
set paste
set cursorline
set nocompatible
" a enters visual mode when using the mouse
set mouse=a
" set mouse=v
set nu
set termguicolors
"set spell
filetype plugin on
filetype plugin indent on
syntax on

" https://github.com/junegunn/vim-plug
call plug#begin()
" Install with :PlugInstall
Plug 'vim-syntastic/syntastic'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'preservim/nerdtree'
Plug 'arcticicestudio/nord-vim'
Plug 'craigemery/vim-autotag'
Plug 'davidhalter/jedi-vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
Plug 'jiangmiao/auto-pairs'
call plug#end()


" syntastic syntax settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" vim-go syntax completion
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'

" Nerdtree settings
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd BufEnter NERD_tree_* nmap  d<CR> <CR> :NERDTreeToggle <CR>
autocmd BufLeave NERD_tree_* unmap d<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") 
      \ && b:NERDTree.isTabTree()) | q | endif

" ctags support
set tags=./.tags;,.tags;
let g:autotagTagsFile=".tags"

" Theme
colorscheme nord

" Hexokinase settings
let g:Hexokinase_highlighters = [ 'foreground' ]
let g:Hexokinase_optInPatterns = [
\     'full_hex',
\     'triple_hex',
\     'rgb',
\     'rgba',
\     'hsl',
\     'hsla',
\     'colour_names'
\ ]

set laststatus=2
set ttimeoutlen=50
set guifont=Source\ Code\ Pro\ for\ Powerline
let g:airline_theme="nord"
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

