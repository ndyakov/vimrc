filetype off
scriptencoding utf-8
set encoding=utf-8
let mapleader = ","

" ========== Plugins {{{1

call plug#begin('~/.vim/plugged')

Plug 'jonathanfilip/vim-lucius'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'wincent/terminus'
Plug 'google/vim-searchindex'
Plug 'szw/vim-g'

Plug 'tpope/vim-surround'
Plug 'moll/vim-bbye'
"Plug 'Townk/vim-autoclose'
"Plug 'Raimondi/delimitMate'
Plug 'chrisbra/NrrwRgn'
Plug 'majutsushi/tagbar'

Plug 'scrooloose/nerdtree'
"Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
"Plug 'ryanoasis/vim-devicons'

Plug 'mbbill/undotree'
Plug 'roman/golden-ratio'
Plug 'ervandew/supertab'

Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'pbogut/fzf-mru.vim'

Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'airblade/vim-rooter'

Plug 'w0rp/ale'
if has('nvim')
  Plug 'HerringtonDarkholme/yats.vim'
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'mhartington/deoplete-typescript', { 'do': 'npm install -g typescript'}
  Plug 'mhartington/nvim-typescript'

  let g:deoplete#enable_at_startup = 1

else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

Plug 'jwalton512/vim-blade'
Plug 'zchee/deoplete-go', { 'do': 'make', 'for': 'go'}
"Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }
Plug 'arnaud-lb/vim-php-namespace'

"Plug 'padawan-php/deoplete-padawan', { 'do': 'composer install', 'for': 'php' }

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
"highlight Normal ctermbg=NONE

"}}}

" ========== Vim Basic Settings
"
syntax on
set updatetime=1000
" Set backup dir for swp files 
set backupdir=~/.vim/backup
set directory=~/.vim/backup

" Basic vim
set nocompatible
set showtabline=1
set cursorline
set novisualbell
set notitle

set virtualedit=block
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

" Statusline {{{
if has("statusline")
  set statusline=
  set statusline+=\ \ %n\ \ \ \|
  "set statusline+=\ \ %{WebDevIconsGetFileTypeSymbol()}
  set statusline+=\ %f
  set statusline+=\ %=
  set statusline+=\ %h%m%r%k
  set statusline+=\ %y
  set statusline+=\ %{\"[\".(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\",B\":\"\").\"]\ \"}

  set statusline+=\ %-8.(%l,%c%V%)
  set statusline+=\ %P\ %L\ 
  "set statusline+=\|\ \ %{WebDevIconsGetFileFormatSymbol()}\ 
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

" shortmess{{{
set shortmess+=A
set shortmess+=I
set shortmess+=c
set shortmess+=s
set shortmess+=a
"}}}

" list{{{
set list
set listchars=nbsp:⦸,tab:▸\ ,eol:¬,trail:·,precedes:«,extends:»
"}}}

" timeout and fast escape{{{
set timeoutlen=420 ttimeoutlen=10
autocmd CursorMoved * set timeoutlen=420 ttimeoutlen=10
if ! has("gui_running")
    augroup FastEscape
        au!
        au InsertEnter * set timeoutlen=0 ttimeoutlen=0
        au InsertLeave * set timeoutlen=420 ttimeoutlen=10
    augroup END
endif
"}}}

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

" no and arrows {{{1

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

" return ot last line when reopen {{{
augroup line_return
    au!
    au BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \ execute 'normal! g`"zvzz' |
        \ endif
augroup END"}}}

" =========== Functions ==================

func! ClearTrailingWS()"{{{
  normal! mz
  %s/\s\+$//ge
  normal! `z
endfunc"}}}

func! ShowTrailingWS()"{{{
  match Error /\s\+$/
endfunc"}}}

" =========== Vim Keybindings ==================

" bindings{{{
",w Command to show white space from a file.
nnoremap <leader>w :call ShowTrailingWS()<CR>

",W Command to remove white space from a file.
nnoremap <leader>W :call ClearTrailingWS()<CR>

" Toggle spell
nnoremap <silent> <leader>s :set spell!<CR>

" Make tab in v mode ident code
vnoremap <tab> >gv
vnoremap <s-tab> <gv

" relative numbers key bindings."
nmap <silent> <leader>l <ESC>:set relativenumber!<CR>

" Map ; to : in normal and visual mode.
nnoremap ; :
vnoremap ; :

" let left and right keys go to the next line
set whichwrap+=<,>,h,l

" ,v Select just pasted text.
nnoremap <leader>v V`]

" Search the word under the cursor with Ag/fzf
nnoremap <leader>f mM:Ag! <C-R><C-W><CR>
vnoremap <leader>f mM"hy:Ag! <C-R>h<CR>

" Search the word under the cursor with Google
nnoremap <leader>go mM:Gf "<C-R><C-W>"<CR>
vnoremap <leader>go mM"hy:Gf <C-R>h<CR>

" Mapping to Undotree
nmap <C-u> <ESC>:UndotreeToggle<CR>

" Mapping to NERDTree
nnoremap <C-n> :NERDTreeToggle %<cr>

" git
nnoremap ge :GitGutterSignsToggle<CR>
nnoremap gp :GitGutterPreviewHunk<CR>
nnoremap gs :GitGutterStageHunk<CR>
nnoremap gu :GitGutterUndoHunk<CR>
nnoremap gr :GitGutterRevertHunk<CR>
nnoremap gd :Gdiff<CR>
nnoremap gc :Gcommit<CR>
nnoremap [g :GitGutterPrevHunk<CR>
nnoremap ]g :GitGutterNextHunk<CR>

" ale
nnoremap <silent> <BS> <Plug>(ale_previous_wrap)
nnoremap <silent> <Space> <Plug>(ale_next_wrap)

" fzf
nnoremap <tab> :Files<CR>
nnoremap <C-b> :Buffers<CR>
nnoremap <Space> :BTags<CR>
nnoremap <s-Tab> :FZFMru<CR>
nnoremap <leader><tab> <plug>(fzf-maps-n)
nnoremap \ :TagbarToggle<CR>

" Ctrl+S to save
nnoremap <C-s> :w<CR>
inoremap <C-s> <ESC>:w<CR>
vnoremap <C-s> <ESC>:w<CR>

"}}}

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

set fillchars=vert:┃
set splitbelow
" }}}

" ========== Buffers {{{1
set hidden
set switchbuf=usetab

" <leader><leader> to toggle between buffers
nmap <leader><leader> <C-^>
vmap <leader><leader> <C-^>

" Navigate splits
nnoremap <silent> <C-l> :bnext<CR>
nnoremap <silent> <C-h> :bprevious<CR>
nnoremap <silent> <C-q> :Bdelete<CR>

" }}}

" ========== Tabs {{{
nnoremap ,to :tabnew %<CR>
nnoremap ,tq :tabclose<CR>

" Navigation in between tabs
nnoremap [t :tabprevious<cr>
nnoremap ]t :tabnext<cr>
""}}}

" ========== Quickfix / Locallist / f<char> navigation{{{
" Quicklist navigation
nnoremap [q :cprev<CR>
nnoremap ]q :cnext<CR>

" Locallist navigation
nnoremap [a :lprev<CR>
nnoremap ]a :lnext<CR>

" Better navigation in jumplist
nnoremap [w <C-o>
nnoremap ]w <C-i>

" Better navigation between results with f<char>
nnoremap [f ,
nnoremap ]f ;

"}}}

" ========== Gvim Settings {{{

" Removing scrollbars
if has("gui_running")
    if has('win32')
        set guifont=Consolas:h12   " Win32.
    elseif has('gui_macvim')
        set guifont=LiterationMonoPowerline\ Nerd\ Font:h14     " OSX.
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

" misc {{{
let g:vim_g_f_command = "Gf"
let g:deoplete#enable_at_startup = 1
" }}}

" NerdTree params {{{1

let NERDTreeIgnore=['.sw?','\~$', '\.pyc$']
let NERDTreeHijackNetrw=1

"}}}
"
"  GitGutter Params {{{1

let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '~'
let g:gitgutter_sign_removed = '-'
let g:gitgutter_sign_removed_first_line = '–'
let g:gitgutter_sign_modified_removed = '_'

" }}}

" GolderRatio {{{
let g:golden_ratio_exclude_nonmodifiable = 1
let g:golden_ratio_autocommand = 0
" }}}



" Go stuff
nnoremap <leader>gd :GoDef <CR>


"nerd tree find
nnoremap <leader>nf :NERDTreeFind <CR>

function! PhpSyntaxOverride()
  " Put snippet overrides in this function.
  hi! link phpDocTags phpDefine
  hi! link phpDocParam phpType
endfunction

augroup phpSyntaxOverride
  autocmd!
  autocmd FileType php call PhpSyntaxOverride()
augroup END


" ale fixers {{{
let g:ale_fixers = {
\   'javascript': ['eslint', 'importjs', 'prettier_eslint'],
\   'php': ['phpcbf'],
\   'go' : ['goimports', 'gofmt'],
\}

let g:ale_linters = {
\   'go' : ['revive', 'vet'],
\}

let g:ale_pattern_options = {
\ '\.vue$': {'ale_linters': ['eslint'], 'ale_fixers': ['eslint']},
\ '\.min\.js$': {'ale_linters': [], 'ale_fixers': []},
\ '\.min\.css$': {'ale_linters': [], 'ale_fixers': []},
\}
" }}}

" ale sings and params {{{1

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

" Calendar {{{
let g:calendar_google_calendar = 1
let g:calendar_google_task = 1
"}}}

" fzf {{{
let g:fzf_mru_relative = 1
let g:fzf_tags_command = "ctags -R --exclude=@.ignore --exclude=@.ctagsadditionalignore "
let g:fzf_layout = { 'down': '~23%'  }
function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

let g:fzf_action = {
  \ 'ctrl-b': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }


command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
  \                 <bang>0 ? fzf#vim#with_preview('up:60%')
  \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
  \                 <bang>0)

"}}}

" supertab {{{
"let g:SuperTabDefaultCompletionType = "<c-n>"
"let g:SuperTabContextDefaultCompletionType = "<c-n>"
"}}}

au FileType javascript setl sw=2 sts=2 et
au FileType vue setl sw=2 sts=2 et
au FileType typescript setl sw=2 sts=2 et
au FileType typescriptreact setl sw=2 sts=2 et
au FileType html setl sw=2 sts=2 et
autocmd FileType vue syntax sync fromstart

autocmd WinLeave * set nocursorline
autocmd WinEnter * set cursorline

function! IPhpInsertUse()
    call PhpInsertUse()
    call feedkeys('a',  'n')
endfunction

autocmd FileType php inoremap <Leader>u <Esc>:call IPhpInsertUse()<CR>
autocmd FileType php noremap <Leader>u :call PhpInsertUse()<CR>

let g:rooter_patterns = ['composer.json', '.git/']

" Put this in your .vimrc and whenever you `git commit` you'll see the diff of your commit next to your commit message.
" For the most accurate diffs, use `git config --global commit.verbose true`

" BufRead seems more appropriate here but for some reason the final `wincmd p` doesn't work if we do that.
autocmd VimEnter COMMIT_EDITMSG call OpenCommitMessageDiff()
function! OpenCommitMessageDiff()
  " Save the contents of the z register
  let old_z = getreg("z")
  let old_z_type = getregtype("z")

  try
    call cursor(1, 0)
    let diff_start = search("^diff --git")
    if diff_start == 0
      " There's no diff in the commit message; generate our own.
      let @z = system("git diff --cached -M -C")
    else
      " Yank diff from the bottom of the commit message into the z register
      :.,$yank z
      call cursor(1, 0)
    endif

    " Paste into a new buffer
    vnew
    normal! V"zP
  finally
    " Restore the z register
    call setreg("z", old_z, old_z_type)
  endtry

  " Configure the buffer
  set filetype=diff noswapfile nomodified readonly
  silent file [Changes\ to\ be\ committed]

  " Get back to the commit message
  wincmd p
endfunction


" vim:fen:fdm=marker:fmr={{{,}}}:fdl=1:fdc=1:ts=2:sw=2:sts=2
"
