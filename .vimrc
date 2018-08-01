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
Plug 'othree/yajs.vim',              { 'for': ['javascript'] }
Plug 'vim-ruby/vim-ruby',            { 'for': ['ruby'] }
Plug 'tpope/vim-rails',              { 'for': ['ruby'] }
Plug 'tpope/vim-rake',               { 'for': ['ruby'] }
Plug 'slim-template/vim-slim',       { 'for': ['slim'] }
Plug 'slashmili/alchemist.vim',      { 'for': ['elixir', 'eelixir'] }
Plug 'elixir-editors/vim-elixir',    { 'for': ['elixir', 'eelixir'] }
Plug 'neovimhaskell/haskell-vim',    { 'for': ['haskell'] }
Plug 'Quramy/tsuquyomi',             { 'for': ['typescript'] }
Plug 'HerringtonDarkholme/yats.vim', { 'for': ['typescript'] }
Plug 'elmcast/elm-vim',              { 'for': ['elm'] }

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
Plug 'justincampbell/vim-eighties'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'luochen1990/rainbow'

" Themes
Plug 'morhetz/gruvbox'
call plug#end()

" luochen1990/rainbow
let g:rainbow_active = 1

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
  \ 'dir':  '\v[\/](\.git|vendor|tmp|node_modules|deps|_build)',
  \ 'file': '\v\.(exe|so|dll|log|beam)$'
  \ }

let g:ycm_server_python_interpreter = '/usr/local/bin/python3' " Valloric/YouCompleteMe

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

" Use spaces instead of tabs; indent 2 spaces at a time
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
autocmd FileType make setlocal noexpandtab " Don't expand tabs into spaces in Makefiles

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
" How can I open a NERDTree automatically when vim starts up if no files were specified?
" https://github.com/scrooloose/nerdtree#faq
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if @% != '.git/COMMIT_EDITMSG' && argc() == 0 && !exists("s:std_in") | NERDTree | endif
" How can I close vim if the only window left open is a NERDTree?
" https://github.com/scrooloose/nerdtree#faq
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Conditionally map <leader>n in order to reveal the current file in the file
" tree when NERDTree is toggled
map <expr> <leader>n (winnr("$") == 1 && !exists("b:NERDTree")) ? ":NERDTreeFind<CR>" : ":NERDTreeToggle<CR>"
let NERDTreeShowHidden = 1 " Show hidden files
let NERDTreeAutoDeleteBuffer = 1 " Delete buffer when deleting file in NERDTree
let NERDTreeIgnore = ['\~$', '\.beam$[[file]]', '^\.git$[[dir]]'] " Ignore undo files + .git dir
" Set working directory to current file's directory
" https://superuser.com/a/195191
" autocmd BufEnter * lcd %:p:h
let loaded_netrwPlugin = 1 " Don't load netrw plugin

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
set ignorecase smartcase " make searches case-sensitive only if they contain upper-case characters
set cursorline " highlight current line
set cmdheight=1
set showtabline=2 " Always show tab bar at the top
set shell=bash " This makes RVM work inside Vim. I have no idea why.
set scrolloff=3 " keep more context when scrolling off the end of a buffer
set nobackup " Don't make backups at all
set nowritebackup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backspace=indent,eol,start " allow backspacing over everything in insert mode
set showcmd " display incomplete commands
set wildmenu " make tab completion for files/buffers act like bash
set timeout timeoutlen=1000 ttimeoutlen=100 " Fix slow O inserts
" Normally, Vim messes with iskeyword when you open a shell file. This can
" leak out, polluting other file types even after a 'set ft=' change. This
" variable prevents the iskeyword change so it can't hurt anyone.
let g:sh_noisk=1
set foldmethod=manual " Turn folding off for real, hopefully
set nofoldenable
" Insert only one space when joining lines that contain sentence-terminating
" punctuation like `.`.
set nojoinspaces
set autoread " If a file is changed outside of vim, automatically reload it without asking
" Use the old vim regex engine (version 1, as opposed to version 2, which was
" introduced in Vim 7.3.969). The Ruby syntax highlighting is significantly
" slower with the new regex engine.
set re=1
" Stop SQL language files from doing unholy things to the C-c key
let g:omni_sql_no_default_maps = 1
nnoremap <leader><leader> <c-^>
