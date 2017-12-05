" ========== Load Pathogen ================="
filetype off
scriptencoding utf-8
set encoding=utf-8
syntax on
call plug#begin('~/.vim/plugged')

Plug 'jonathanfilip/vim-lucius'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'ctrlpvim/ctrlp.vim', { 'on': ['CtrlP', 'CtrlPBufTagAll', 'CtrlPBuffer', 'CtrlPTag']}
Plug 'ervandew/supertab'
Plug 'tpope/vim-surround'
Plug 'moll/vim-bbye'
Plug 'vim-scripts/ZoomWin'
Plug 'Townk/vim-autoclose'

Plug 'sjbach/lusty'
Plug 'mbbill/undotree'
Plug 'roman/golden-ratio'

Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'
Plug 'Shougo/deoplete.nvim'
Plug 'w0rp/ale'

Plug 'airblade/vim-gitgutter'
Plug 'vim-scripts/ag.vim'
Plug 'pangloss/vim-javascript'
Plug 'posva/vim-vue'
Plug 'elzr/vim-json'
Plug 'fatih/vim-go', { 'for': 'go', 'do': ':GoInstallBinaries' }

call plug#end()

filetype plugin indent on

" =========== Color theme settings =============

colorscheme lucius
LuciusDark
highlight Comment ctermfg=249 guifg=#b2b2b2
highlight Normal ctermbg=NONE

" =========== END Color theme settings =========
let g:deoplete#enable_at_startup = 1

" ========== Vim Basic Settings ============="
" Make vim simpler (also plugins use those)
set nocompatible
set hidden
set modelines=0
set showtabline=0

" make vim faster
set nocursorline
set nocursorcolumn
set scrolljump=5
set lazyredraw
set synmaxcol=180
set number
set norelativenumber

" Global TAB settings.
set smartindent
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

" Show whitespaces
set list
set listchars=tab:▸\ ,eol:¬,trail:·,precedes:«,extends:»

" Highlight searches
set hlsearch

" Use smartcase
set ignorecase
set smartcase

" Search while typing
set incsearch

" Set backup dir for swp files
set backupdir=~/.vim/backup
set directory=~/.vim/backup

" More Common Settings.
set encoding=utf-8
set scrolloff=10
set autoread
set showmode
set showcmd
set wildmenu
set wildmode=list:longest
set novisualbell
set timeout ttimeoutlen=100 timeoutlen=1000

set ttyfast
set backspace=indent,eol,start

" Set undofile
set shell=/bin/bash
set matchtime=1

" Set title to window
set notitle

if has("statusline")
  set statusline=
  set statusline+=\ %f
  set statusline+=\ %=
  set statusline+=\ %h%m%r%k
  set statusline+=\ %y
  set statusline+=\ %{\"[\".(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\",B\":\"\").\"]\ \"}
  set statusline+=\ %-8.(%l,%c%V%)
  set statusline+=\ %P\ %L
endif

" Change status color on different modes
" First, enable status line always
set laststatus=2

" Now set it up to change the status line based on mode
if version >= 700
  augroup StatusLineGroup
    au!
    au InsertEnter * hi StatusLine term=reverse ctermfg=7 ctermbg=65 guibg=#005f5f guifg=White gui=underline
    au InsertLeave * hi StatusLine term=reverse ctermfg=7 ctermbg=24 gui=bold,reverse
  augroup END
endif

" Make Sure that Vim returns to the same line when we reopen a file"
augroup line_return
    au!
    au BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \ execute 'normal! g`"zvzz' |
        \ endif
augroup END

" Working with split screen nicely
" Resize Split When the window is resized"
augroup ResizeGroup
  au!
  au VimResized * :wincmd =
augroup END

" =========== END Basic Vim Settings ===========
"

" ========== Functions ==================
"
augroup OmniCompletionClose
  autocmd!
  autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
  autocmd InsertLeave * if pumvisible() == 0|pclose|endif
augroup END

func! ClearTrailingWS()
  normal! mz
  %s/\s\+$//ge
  normal! `z
endfunc

func! ShowTrailingWS()
  match Error /\s\+$/
endfunc
" ========== END Functions ==============

" =========== Vim Keybindings ==================

" Changing Leader Key
let mapleader = ","

" C-q doesn't reach vim, so lets try this:
silent !stty -ixon > /dev/null 2>/dev/null

" Let Alt key combos to work :
let c='a'
while c <= 'z'
  exec "set <A-".c.">=\e".c
  exec "imap \e".c." <A-".c.">"
  let c = nr2char(1+char2nr(c))
endw

" Toggle spell
nnoremap <silent> <leader>s :set spell!<CR>

" Make tab in v mode ident code
vnoremap <tab> >gv
vnoremap <s-tab> <gv

" Ctrl+Space
" to accept the autocompletion and exit
" insert mode.
inoremap <C-Space> <C-y><ESC>
inoremap <C-@> <C-y><ESC>
inoremap <Nul> <C-y><ESC>

" Splits like in tmux but without the Shift
nnoremap <leader>\ :split<CR>
nnoremap <leader>5 :vsplit<CR>

" Ctrl+S to save
nnoremap <C-s> :w<CR>
inoremap <C-s> <ESC>:w<CR>
vnoremap <C-s> <ESC>:w<CR>

" <leader><leader> to toggle between buffers
nmap <leader><leader> <C-^>
vmap <leader><leader> <C-^>

" relative numbers key bindings."
nmap <silent> <leader>l <ESC>:set relativenumber!<CR>

" Navigation between windows
nnoremap <silent> ˚ :wincmd k<CR>
nnoremap <silent> ∆ :wincmd j<CR>
nnoremap <silent> ˙ :wincmd h<CR>
nnoremap <silent> ¬ :wincmd l<CR>
nnoremap <silent> œ :close<CR>

" Navigation between buffers
nnoremap <silent> <C-l> :bnext<CR>
nnoremap <silent> <C-h> :bprevious<CR>
nnoremap <silent> <C-q> :Bdelete<CR>

nnoremap <silent> gt1 :buffer 1<CR>
nnoremap <silent> gt2 :buffer 2<CR>
nnoremap <silent> gt3 :buffer 3<CR>
nnoremap <silent> gt4 :buffer 4<CR>
nnoremap <silent> gt5 :buffer 5<CR>
nnoremap <silent> gt6 :buffer 6<CR>
nnoremap <silent> gt7 :buffer 7<CR>
nnoremap <silent> gt8 :buffer 8<CR>
nnoremap <silent> gt9 :buffer 9<CR>

" Get Rid of stupid Goddamned help keys
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

" Make arrows useless
inoremap <Left> <Nop>
inoremap <Right> <Nop>
inoremap <Up> <Nop>
inoremap <Down> <Nop>

nnoremap <Left> <Nop>
nnoremap <Right> <Nop>
nnoremap <Up> <Nop>
nnoremap <Down> <Nop>

vnoremap <Left> <Nop>
vnoremap <Right> <Nop>
vnoremap <Up> <Nop>
vnoremap <Down> <Nop>

"open new tab
nnoremap gtt :tabnew %<CR>
vnoremap gtt :tabnew %<CR>

let hlstate=0
nnoremap <Leader>n :if (hlstate%2 == 0) \| nohlsearch \| else \| set hlsearch \| endif \| let hlstate=hlstate+1<CR>:echo "toggled visibility for hlsearch"<CR>
inoremap <Leader>n <ESC>:if (hlstate%2 == 0) \| nohlsearch \| else \| set hlsearch \| endif \| let hlstate=hlstate+1<CR>:echo "toggled visibility for hlsearch"<CR>a

" Better navigation between results with vimgrep and similar
" plugins
nnoremap [q :cprev<CR>
nnoremap ]q :cnext<CR>

" Better navigation between results with f<char>
nnoremap [a ,
nnoremap ]a ;

vnoremap [a ,
vnoremap ]a ;

" Better navigation in jumplist
nnoremap [w <C-o>
nnoremap ]w <C-i>

vnoremap [w <C-o>
vnoremap ]w <C-i>

" Navigation in between tabs
nnoremap [t :tabprevious<cr>
nnoremap ]t :tabnext<cr>

vnoremap [t :tabprevious<cr>
vnoremap ]t :tabnext<cr>

" Map ; to : in normal and visual mode.
nnoremap ; :
vnoremap ; :

" Set vim to save the file on focus out.
" au FocusLost * :wa

" Adding More Shorcuts keys using leader key.
" Leader Key provide separate namespace for specific commands.

",w Command to show white space from a file.
nnoremap <leader>w :call ShowTrailingWS()<CR>

",W Command to remove white space from a file.
nnoremap <leader>W :call ClearTrailingWS()<CR>

" ,ft Fold tag, helpful for HTML editing.
nnoremap <leader>ft vatzf

" let left and right keys go to the next line
set whichwrap+=<,>,h,l

" ,q Re-hardwrap Paragraph
nnoremap <leader>q gqip

" ,v Select just pasted text.
nnoremap <leader>v V`]

" ,ev Shortcut to edit .vimrc file on the fly on a vertical window.
nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>

nnoremap g; g;zz

" =========== END Vim Keybindings ==============

" =========== Gvim Settings =============

" Removing scrollbars
if has("gui_running")
    if has('win32')
        set guifont=Consolas:h12   " Win32.
    elseif has('gui_macvim')
        set guifont=Monaco:h12     " OSX.
    else
        set guifont=Liberation\ Mono\ 12 " linux
    endif
    set cursorline
    set guitablabel=%-0.12t%M
    set guioptions-=T
    set guioptions-=r
    set guioptions-=L
    set guioptions-=a
    set guioptions-=i
    set guioptions-=m
    set guioptions-=M
else
    set t_Co=256
endif

" Source the vimrc file after saving it
autocmd bufwritepost .vimrc source ~/.vimrc

" ========== END Gvim Settings ==========
"

" ========== Plugins Settings =========="
" vim mode-switch lag fix (related to autoclose)

if ! has("gui_running")
    set ttimeoutlen=10
    augroup FastEscape
        au!
        au InsertEnter * set timeoutlen=0
        au InsertLeave * set timeoutlen=1000
    augroup END
endif

" Mapping for ag
" Search the word under the cursor
nnoremap <leader>f mM:Ag! "<C-R><C-W>"<CR>:cw<CR>
vnoremap <leader>f mM"hy:Ag! <C-R>h<CR>:cw<CR>

" Mapping to Undotree
nmap <leader>u <ESC>:UndotreeToggle<CR>
imap <leader>u <ESC>:UndotreeToggle<CR>

" Mapping to NERDTree
nnoremap <C-n> :NERDTreeToggle %<cr>
let NERDTreeIgnore=['.sw?','\~$', '\.pyc$']
let NERDTreeHijackNetrw=1

" CtrlP key binding.
nnoremap <C-p> :CtrlPBufTagAll<CR>
inoremap <C-p> <ESC>:CtrlPBufTagAll<CR>
vnoremap <C-p> <ESC>:CtrlPBufTagAll<CR>

nnoremap <C-b> :CtrlPBuffer<CR>
inoremap <C-b> <ESC>:CtrlPBuffer<CR>
vnoremap <C-b> <ESC>:CtrlPBuffer<CR>

nnoremap <C-o> :CtrlP<CR>
inoremap <C-o> <ESC>:CtrlP<CR>
vnoremap <C-o> <ESC>:CtrlP<CR>

nnoremap <C-t> :CtrlPTag<CR>
inoremap <C-t> <ESC>:CtrlPTag<CR>
vnoremap <C-t> <ESC>:CtrlPTag<CR>

" Symbol for lines which have been added, default: +
let g:git_diff_added_symbol='⇒'
" Symbol for lines which have been removed, default: -
let g:git_diff_removed_symbol='⇐'
" Symbol for lines which have been changed, default: <>
let g:git_diff_changed_symbol='⇔'

" GolderRatio settings
let g:golden_ratio_exclude_nonmodifiable = 1
let g:golden_ratio_autocommand = 0

" Lusty settings
nnoremap <leader>b :LustyBufferExplorer<CR>
vnoremap <leader>b :LustyBufferExplorer<CR>
nnoremap <leader>/ :LustyBufferGrep<CR>
vnoremap <leader>/ :LustyBufferGrep<CR>

let g:ale_fixers = {
\   'javascript': ['eslint', 'importjs', 'prettier_eslint'],
\}

let g:ale_pattern_options = {
\ '\.min\.js$': {'ale_linters': [], 'ale_fixers': []},
\ '\.min\.css$': {'ale_linters': [], 'ale_fixers': []},
\}
let g:ale_sign_column_always = 1
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_set_loclist = 1
let g:ale_set_quickfix = 0

"========== END Plugin Settings =========="
autocmd BufNewFile,BufReadPost *.md set filetype=markdown
autocmd FileType vue syntax sync fromstart
