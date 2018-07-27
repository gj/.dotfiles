" Workaround for Python 3.7.0
" (https://github.com/vim/vim/issues/3117#issuecomment-402622616)
if has('python3')
  silent! python3 1
endif

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/vim-plugins')
" Language packages
Plug 'pangloss/vim-javascript',    { 'for': ['javascript'] }
Plug 'vim-ruby/vim-ruby',          { 'for': ['ruby'] }
Plug 'tpope/vim-rails',            { 'for': ['ruby'] }
Plug 'tpope/vim-rake',             { 'for': ['ruby'] }
Plug 'slim-template/vim-slim',     { 'for': ['slim'] }
" Plug 'slashmili/alchemist.vim',    { 'for': ['elixir', 'eelixir'] }
Plug 'elixir-editors/vim-elixir',  { 'for': ['elixir', 'eelixir'] }
Plug 'neovimhaskell/haskell-vim',  { 'for': ['haskell'] }
Plug 'Quramy/tsuquyomi',           { 'for': ['typescript'] }
Plug 'leafgarland/typescript-vim', { 'for': ['typescript'] }
Plug 'elmcast/elm-vim',            { 'for': ['elm'] }

" Utilities
Plug 'mileszs/ack.vim'
Plug 'Valloric/YouCompleteMe', { 'do': '/usr/local/bin/python3 install.py --js-completer' }
Plug 'ctrlpvim/ctrlp.vim'
Plug 'w0rp/ale'
Plug 'vim-scripts/tComment'
" Plug 'pbrisbin/vim-mkdir'
Plug 'christoomey/vim-run-interactive'
Plug 'christoomey/vim-tmux-navigator'
" Plug 'janko-m/vim-test'
" Plug 'tpope/vim-bundler', { 'for': ['ruby'] }
" Plug 'tpope/vim-endwise'
" Plug 'tpope/vim-eunuch'
" Plug 'tpope/vim-fugitive'
" Plug 'tpope/vim-repeat'
" Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'terryma/vim-multiple-cursors'
Plug 'justincampbell/vim-eighties'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'Xuyuanp/nerdtree-git-plugin', { 'on': 'NERDTreeToggle' }

" Themes
Plug 'morhetz/gruvbox'
call plug#end()

" Change leader to spacebar
let mapleader = ' '
nnoremap <Space> <Nop>

" Set the theme to gruvbox
set background=dark
set t_Co=256
colorscheme gruvbox
let g:gruvbox_contrast_dark     = 'hard'
let g:gruvbox_improved_strings  = 1
let g:gruvbox_improved_warnings = 1
let g:gruvbox_guisp_fallback = 'fg'

" pangloss/vim-javascript
let g:javascript_plugin_flow = 1
let g:javascript_conceal_function = "ƒ"
set conceallevel=1

" mileszs/ack.vim
let g:ackprg = 'ag --nogroup --nocolor --column'
nnoremap <leader>a :Ack!<space>

" ctrlpvim/ctrlp.vim
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.git|vendor|tmp|node_modules)',
  \ 'file': '\v\.(exe|so|dll|log)$'
  \ }

" Valloric/YouCompleteMe
" let g:ycm_keep_logfiles = 1 " Just for debugging
" let g:ycm_log_level = 'debug' " Just for debugging
let g:ycm_server_python_interpreter = '/usr/local/bin/python3'

" https://github.com/Microsoft/TypeScript/wiki/TypeScript-Editor-Support#language-service-tools
if !exists("g:ycm_semantic_triggers")
  let g:ycm_semantic_triggers = {}
endif
let g:ycm_semantic_triggers['typescript'] = ['.']
let g:ycm_semantic_triggers['elm'] = ['.']

" " janko-m/vim-test
" " these "Ctrl mappings" work well when Caps Lock is mapped to Ctrl
" nmap <silent> <leader>tn :TestNearest<CR>
" nmap <silent> <leader>tf :TestFile<CR>
" nmap <silent> <leader>ts :TestSuite<CR>
" nmap <silent> <leader>tl :TestLast<CR>
" nmap <silent> <leader>tg :TestVisit<CR>

" christoomey/vim-run-interactive
nnoremap <leader>r :RunInInteractiveShell<space>

" terryma/vim-multiple-cursors
let g:multi_cursor_use_default_mapping=0
let g:multi_cursor_next_key='<C-n>'
let g:multi_cursor_prev_key='<C-u>'
let g:multi_cursor_skip_key='<C-k>'
let g:multi_cursor_quit_key='<Esc>'

" Use spaces instead of tabs; indent 2 spaces at a time
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
" Don't expand tabs into spaces in Makefiles
autocmd FileType make setlocal noexpandtab

" Display tab and EOL characters
" set listchars=tab:▸\ ,eol:¬
set nolist

" http://vimcasts.org/episodes/soft-wrapping-text/
set wrap linebreak

" Highlight trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" scrooloose/nerdtree
autocmd vimenter * NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
map <leader>n :NERDTreeToggle<CR>

" Switching between windows
nnoremap  <C-j> <C-w>j
nnoremap  <C-k> <C-w>k
nnoremap  <C-h> <C-w>h
nnoremap  <C-l> <C-w>l
nnoremap c<C-j>        :bel sp new<cr>
nnoremap c<C-k>        :abo sp new<cr>
nnoremap c<C-h>        :lefta vsp new<cr>
nnoremap c<C-l>        :rightb vsp new<cr>
nnoremap d<C-j> <C-w>j<C-w>c
nnoremap d<C-k> <C-w>k<C-w>c
nnoremap d<C-h> <C-w>h<C-w>c
nnoremap d<C-l> <C-w>l<C-w>c

" Open new split panes to right and bottom, which feels more natural than Vim’s default
" https://robots.thoughtbot.com/vim-splits-move-faster-and-more-naturally#more-natural-split-opening
set splitbelow
set splitright

" Enable line numbers
set number
set relativenumber

" Autocomplete with tab
" https://robots.thoughtbot.com/vim-you-complete-me#the-quick-rundown
imap <Tab> <C-p>
set complete=.,b,u,]
set wildmode=longest,list:longest
set completeopt=menu,preview

" Automatically set buffers as 'hidden' when navigating away
set hidden

" Per https://github.com/neovimhaskell/haskell-vim#installation
syntax on
filetype plugin indent on

" ESLint setup per http://talum.github.io/blog/2017/12/28/setting-up-eslint-globally/
let g:ale_linters = {
\  'javascript': ['eslint'],
\  'jsx': ['eslint']
\}

let g:ale_fixers = {
\  'javascript': ['eslint'],
\  'jsx': ['eslint']
\}

let g:ale_sign_column_always = 1
" Set this variable to 1 to fix files when you save them.
let g:ale_fix_on_save = 1
" Enable completion where available.
let g:ale_completion_enabled = 1
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_delay = 2000

" " Make netrw behave more like NERDTree per https://shapeshed.com/vim-netrw/
" let g:netrw_banner = 0
" let g:netrw_liststyle = 3
" let g:netrw_browse_split = 0
" let g:netrw_altv = 1
" let g:netrw_winsize = 25
" let g:netrw_keepdir = 0
let loaded_netrwPlugin = 1

" " http://vimcasts.org/episodes/the-edit-command/
" cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<cr>
" map <leader>ew :e %%
" map <leader>es :sp %%
" map <leader>ev :vsp %%
" map <leader>et :tabe %%

" Enable Vim's spellchecker (http://vimcasts.org/episodes/spell-checking/)
set spell
set spelllang=en_us

" http://vimcasts.org/episodes/updating-your-vimrc-file-on-the-fly/
" Source the vimrc file after saving it
if has("autocmd")
  autocmd! bufwritepost .vimrc source $MYVIMRC
endif

" Improve ctags
set tags=./tags;/
map <C-\> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

" Random stuff from https://github.com/garybernhardt/dotfiles/blob/master/.vimrc
set history=10000
set autoindent
set showmatch
set incsearch
set hlsearch
" make searches case-sensitive only if they contain upper-case characters
set ignorecase smartcase
" highlight current line
set cursorline
set cmdheight=1
" Always show tab bar at the top
set showtabline=2
" This makes RVM work inside Vim. I have no idea why.
set shell=bash
" Prevent Vim from clobbering the scrollback buffer. See
" http://www.shallowsky.com/linux/noaltscreen.html
" set t_ti= t_te=
" keep more context when scrolling off the end of a buffer
set scrolloff=3
" Don't make backups at all
set nobackup
set nowritebackup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
" allow backspacing over everything in insert mode
set backspace=indent,eol,start
" display incomplete commands
set showcmd
" make tab completion for files/buffers act like bash
set wildmenu
" Fix slow O inserts
set timeout timeoutlen=1000 ttimeoutlen=100
" Normally, Vim messes with iskeyword when you open a shell file. This can
" leak out, polluting other file types even after a 'set ft=' change. This
" variable prevents the iskeyword change so it can't hurt anyone.
let g:sh_noisk=1
" Turn folding off for real, hopefully
set foldmethod=manual
set nofoldenable
" Insert only one space when joining lines that contain sentence-terminating
" punctuation like `.`.
set nojoinspaces
" If a file is changed outside of vim, automatically reload it without asking
set autoread
" Use the old vim regex engine (version 1, as opposed to version 2, which was
" introduced in Vim 7.3.969). The Ruby syntax highlighting is significantly
" slower with the new regex engine.
set re=1
" Stop SQL language files from doing unholy things to the C-c key
let g:omni_sql_no_default_maps = 1
nnoremap <leader><leader> <c-^>
