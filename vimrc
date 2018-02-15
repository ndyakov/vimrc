filetype off
scriptencoding utf-8
set encoding=utf-8
let mapleader = ","

" ========== Plugins {{{1

call plug#begin('~/.vim/plugged')

Plug 'jonathanfilip/vim-lucius'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'wincent/terminus'

Plug 'tpope/vim-surround'
Plug 'chaoren/vim-wordmotion'
Plug 'moll/vim-bbye'
Plug 'Townk/vim-autoclose'
Plug 'chrisbra/NrrwRgn'

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'ryanoasis/vim-devicons'

Plug 'mbbill/undotree'
Plug 'roman/golden-ratio'
Plug 'ervandew/supertab'

Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'pbogut/fzf-mru.vim'

Plug 'airblade/vim-gitgutter'

Plug 'w0rp/ale'

Plug 'tpope/vim-markdown'
Plug 'ekalinin/Dockerfile.vim'

Plug 'fatih/vim-go', { 'for': 'go' }

Plug 'StanAngeloff/php.vim', { 'for': 'php' }

Plug 'jelera/vim-javascript-syntax'
Plug 'pangloss/vim-javascript'
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'posva/vim-vue'
Plug 'elzr/vim-json'

" Calendar
Plug 'itchyny/calendar.vim'

call plug#end()
filetype plugin indent on

" }}}

" ========== Color theme settings {{{1

colorscheme lucius
LuciusDark
highlight Comment ctermfg=249 guifg=#b2b2b2
highlight Error ctermfg=200 guifg=#ff0000
"highlight Normal ctermbg=NONE

"}}}

" ========== Vim Basic Settings
"
syntax on

" Set backup dir for swp files
set backupdir=~/.vim/backup
set directory=~/.vim/backup

" Basic vim
set nocompatible
set showtabline=1
set cursorline
set novisualbell
set notitle

" autoread if file is changed
set autoread
" don't show the mode
set noshowmode
" show current keypresses
set showcmd
" completion in command mode
set wildmenu
set wildmode=list:longest

" make vim faster
set ttyfast
set nocursorcolumn
set scrolloff=5
set scrolljump=5
set lazyredraw
" don't syntax uber long lines
set synmaxcol=320
set number
set norelativenumber

" Global TAB settings.
set smartindent
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" how backspace works
set backspace=indent,eol,start
set noshelltemp

" Show whitespaces{{{
set list
set listchars=tab:▸\ ,eol:¬,trail:·,precedes:«,extends:»"}}}

" Search{{{
" Highlight searches
set hlsearch

" Use smartcase
set ignorecase
set smartcase

" Search while typing
set incsearch

let hlstate=0
nnoremap <Leader>n :if (hlstate%2 == 0) \| nohlsearch \| else \| set hlsearch \| endif \| let hlstate=hlstate+1<CR>:echo "toggled visibility for hlsearch"<CR>
inoremap <Leader>n <ESC>:if (hlstate%2 == 0) \|  nohlsearch \| else \| set hlsearch \| endif \| let hlstate=hlstate+1<CR>:echo "toggled visibility for hlsearch"<CR>a}}}

" Reset timeoutline to normal soon afterwards{{{
set timeoutlen=420 ttimeoutlen=10
autocmd CursorMoved * set timeoutlen=420 ttimeoutlen=10
if ! has("gui_running")
    augroup FastEscape
        au!
        au InsertEnter * set timeoutlen=0 ttimeoutlen=0
        au InsertLeave * set timeoutlen=420 ttimeoutlen=10
    augroup END
endif"}}}

" ========== Bad keys {{{1

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

" }}}

" ========== Statusline {{{1
if has("statusline")
  set statusline=
  set statusline+=\ \ %n\ \ \ \|
  set statusline+=\ \ %{WebDevIconsGetFileTypeSymbol()}
  set statusline+=\ %f
  set statusline+=\ %=
  set statusline+=\ %h%m%r%k
  set statusline+=\ %y
  set statusline+=\ %{\"[\".(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\",B\":\"\").\"]\ \"}

  set statusline+=\ %-8.(%l,%c%V%)
  set statusline+=\ %P\ %L\ 
  set statusline+=\|\ \ %{WebDevIconsGetFileFormatSymbol()}\ 
endif

" Change status color on different modes
" First, enable status line always
set laststatus=2

augroup StatusLineGroup
    au!
    au InsertEnter * hi StatusLine term=reverse ctermfg=7 ctermbg=65 guibg=#005f5f guifg=White gui=underline
    au InsertLeave * hi StatusLine term=reverse ctermfg=7 ctermbg=24 gui=bold,reverse
augroup END

"}}}

" Make Sure that Vim returns to the same line when we reopen a file{{{
augroup line_return
    au!
    au BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \ execute 'normal! g`"zvzz' |
        \ endif
augroup END"}}}

" ========== Functions ==================

func! ClearTrailingWS()"{{{
  normal! mz
  %s/\s\+$//ge
  normal! `z
endfunc"}}}

func! ShowTrailingWS()"{{{
  match Error /\s\+$/
endfunc"}}}

" =========== Vim Keybindings ==================

" repeat last macro
nnoremap <CR> @@

" Toggle spell
nnoremap <silent> <leader>s :set spell!<CR>

" Make tab in v mode ident code
vnoremap <tab> >gv
vnoremap <s-tab> <gv

" Ctrl+S to save{{{
nnoremap <C-s> :w<CR>
inoremap <C-s> <ESC>:w<CR>
vnoremap <C-s> <ESC>:w<CR>"}}}

" relative numbers key bindings."
nmap <silent> <leader>l <ESC>:set relativenumber!<CR>

" ========== Splits/Windows {{{1

" Resize Split When the window is resized"
augroup ResizeGroup
  au!
  au VimResized * :wincmd =
augroup END

" Create splits
nnoremap – :split<CR>
nnoremap ≠ :vsplit<CR>

" Navigation between splits
nnoremap <silent> ˚ :wincmd k<CR>
nnoremap <silent> ∆ :wincmd j<CR>
nnoremap <silent> ˙ :wincmd h<CR>
nnoremap <silent> ¬ :wincmd l<CR>
nnoremap <silent> œ :close<CR>

nnoremap <silent>  :res +5<CR>
nnoremap <silent> Ô :res -5<CR>
nnoremap <silent> Ó :vertical resize -5<CR>
nnoremap <silent> Ò :vertical resize +5<CR>

" }}}

" ========== Buffers {{{1
set hidden

" <leader><leader> to toggle between buffers
nmap <leader><leader> <C-^>
vmap <leader><leader> <C-^>

" Navigate splits
nnoremap <silent> <C-l> :bnext<CR>
nnoremap <silent> <C-h> :bprevious<CR>
nnoremap <silent> <C-q> :Bdelete<CR>

" }}}

" Tabs
nnoremap ,to :tabnew %<CR>
nnoremap ,tq :tabclose<CR>

" Navigation in between tabs
nnoremap [t :tabprevious<cr>
nnoremap ]t :tabnext<cr>

" Quickfix navigation
nnoremap [q :cprev<CR>
nnoremap ]q :cnext<CR>

" Locallist navigation
nnoremap [a :lprev<CR>
nnoremap ]a :lnext<CR>

" Better navigation between results with f<char>
nnoremap [f ,
nnoremap ]f ;

" Better navigation in jumplist
nnoremap [w <C-o>
nnoremap ]w <C-i>

" Map ; to : in normal and visual mode.
nnoremap ; :
vnoremap ; :

" let left and right keys go to the next line
set whichwrap+=<,>,h,l

",w Command to show white space from a file.
nnoremap <leader>w :call ShowTrailingWS()<CR>

",W Command to remove white space from a file.
nnoremap <leader>W :call ClearTrailingWS()<CR>

" ,v Select just pasted text.
nnoremap <leader>v V`]


" =========== Gvim Settings {{{1

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

" }}}

" vimrc edit and source {{{1

" Source the vimrc file after saving it
autocmd bufwritepost .vimrc source ~/.vimrc

" Shortcut to edit .vimrc file on the fly on a vertical window.
nnoremap <leader>ev <C-w><C-v><C-l>:e ~/.vimrc<cr>

"}}}

" ========== Plugins Settings =========="

" Search the word under the cursor with Ag/fzf
nnoremap <leader>f mM:Ag "<C-R><C-W>"<CR>
vnoremap <leader>f mM"hy:Ag <C-R>h<CR>

" Mapping to Undotree
nmap <leader>u <ESC>:UndotreeToggle<CR>

" Mapping to NERDTree
nnoremap <C-n> :NERDTreeToggle %<cr>

" NerdTree params {{{1

let NERDTreeIgnore=['.sw?','\~$', '\.pyc$']
let NERDTreeHijackNetrw=1

"}}}

nnoremap gs :GitGutterSignsToggle<CR>
nnoremap gp :GitGutterPreviewHunk<CR>
nnoremap gc :GitGutterStageHunk<CR>
nnoremap gu :GitGutterUndoHunk<CR>
nnoremap gr :GitGutterRevertHunk<CR>
nnoremap [g :GitGutterPrevHunk<CR>
nnoremap ]g :GitGutterNextHunk<CR>

" ========== GitGutter Params {{{1

let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '~'
let g:gitgutter_sign_removed = '-'
let g:gitgutter_sign_removed_first_line = '–'
let g:gitgutter_sign_modified_removed = '_'

" }}}

" GolderRatio settings
let g:golden_ratio_exclude_nonmodifiable = 1
let g:golden_ratio_autocommand = 0

let g:ale_fixers = {
\   'javascript': ['eslint', 'importjs', 'prettier_eslint'],
\   'php': ['phpcbf'],
\   'go' : ['goimports', 'gofmt'],
\}

let g:ale_pattern_options = {
\ '\.min\.js$': {'ale_linters': [], 'ale_fixers': []},
\ '\.min\.css$': {'ale_linters': [], 'ale_fixers': []},
\}

nmap <silent> <BS> <Plug>(ale_previous_wrap)
nmap <silent> <Space> <Plug>(ale_next_wrap)

" ========== Ale sings and params {{{1

let g:ale_sign_column_always = 1
let g:ale_sign_error = '⤫'
let g:ale_sign_warning = '⚠'
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_set_loclist = 1
let g:ale_set_quickfix = 0
let g:ale_fix_on_save = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_open_list = 1

" }}}

" Calendar
let g:calendar_google_calendar = 1
let g:calendar_google_task = 1

" Mapping selecting mappings
nmap <tab> :Files<CR>
nmap <C-b> :Buffers<CR>
nnoremap <S-Tab> << :FZFMru<CR>
nmap <leader><tab> <plug>(fzf-maps-n)
let g:fzf_layout = { 'down': '~23%'  }

let g:SuperTabDefaultCompletionType = "<c-n>"
let g:SuperTabContextDefaultCompletionType = "<c-n>"

" vim:fen:fdm=marker:fmr={{{,}}}:fdl=0:fdc=1:ts=2:sw=2:sts=2
