if has('python3') " Workaround for Python 3.7.0
  silent! python3 1 " (https://github.com/vim/vim/issues/3117#issuecomment-402622616)
endif

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/vim-plugins')
  Plug 'othree/yajs.vim',              { 'for': ['javascript'] }
  Plug 'vim-ruby/vim-ruby',            { 'for': ['ruby'] }
  Plug 'tpope/vim-rails',              { 'for': ['ruby'] }
  Plug 'tpope/vim-rake',               { 'for': ['ruby'] }
  Plug 'slim-template/vim-slim',       { 'for': ['slim'] }
  Plug 'elixir-editors/vim-elixir',    { 'for': ['elixir', 'eelixir'] }
  " Plug 'slashmili/alchemist.vim',      { 'for': ['elixir', 'eelixir'] }
  " Plug 'Quramy/tsuquyomi',             { 'for': ['typescript'] }
  Plug 'HerringtonDarkholme/yats.vim', { 'for': ['typescript'] }
  Plug 'rust-lang/rust.vim', { 'for': ['rust'] }
  Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  Plug 'Valloric/YouCompleteMe', { 'do': '/usr/local/bin/python3 install.py --js-completer' }
  Plug 'w0rp/ale'
  Plug 'vim-scripts/tComment'
  Plug 'vim-airline/vim-airline'
  Plug 'scrooloose/nerdtree'
  Plug 'Xuyuanp/nerdtree-git-plugin'
  Plug 'junegunn/rainbow_parentheses.vim'
  Plug 'morhetz/gruvbox'
call plug#end()

set background=dark
set t_Co=256
colorscheme gruvbox " Set the theme to gruvbox
let g:gruvbox_contrast_dark     = 'hard'
let g:gruvbox_improved_strings  = 1
let g:gruvbox_improved_warnings = 1
let g:gruvbox_guisp_fallback    = 'fg'

" Random stuff from https://github.com/garybernhardt/dotfiles/blob/master/.vimrc
set history=10000
set autoindent
set showmatch
set incsearch
set hlsearch
set ignorecase smartcase " make searches case-sensitive only if they contain upper-case characters
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
let g:sh_noisk=1 " Don't mess with iskeyword when opening a shell file
set nojoinspaces " Don't insert multiple spaces when joining lines
set autoread " If a file is changed outside of vim, automatically reload it without asking
let g:omni_sql_no_default_maps = 1 " Stop SQL language files from doing unholy things to the C-c key

" Other stuff
let mapleader = ' ' " Change leader to spacebar
nnoremap <Space> <Nop>
nnoremap <leader><leader> <c-^>
" nnoremap <Esc><Esc> :nohlsearch<CR>
if has("autocmd") " http://vimcasts.org/episodes/updating-your-vimrc-file-on-the-fly/
  autocmd! bufwritepost .vimrc source $MYVIMRC " Source the vimrc file after saving it
endif

" Highlight trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

nnoremap  <C-j> <C-w>j
nnoremap  <C-k> <C-w>k
nnoremap  <C-h> <C-w>h
nnoremap  <C-l> <C-w>l
nnoremap c<C-j> :bel sp new<cr>
nnoremap c<C-k> :abo sp new<cr>
nnoremap c<C-h> :lefta vsp new<cr>
nnoremap c<C-l> :rightb vsp new<cr>
nnoremap d<C-j> <C-w>j<C-w>c
nnoremap d<C-k> <C-w>k<C-w>c
nnoremap d<C-h> <C-w>h<C-w>c
nnoremap d<C-l> <C-w>l<C-w>c
nnoremap <BS> <C-z>

set splitbelow " Open new split panes to right and bottom
set splitright " https://robots.thoughtbot.com/vim-splits-move-faster-and-more-naturally#more-natural-split-opening

set number

imap <Tab> <C-p>| " Autocomplete with tab
set complete=.,b,u,] " https://robots.thoughtbot.com/vim-you-complete-me#the-quick-rundown
set wildmode=longest,list:longest
set completeopt=menu,preview

set hidden " Automatically set buffers as 'hidden' when navigating away

syntax on " Per https://github.com/neovimhaskell/haskell-vim#installation
filetype plugin indent on " same as above

set tags=./tags;/ " Improve ctags
map <C-\> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

set tabstop=2 " indent 2 spaces at a time
set shiftwidth=2
set softtabstop=2
set expandtab " Use spaces instead of tabs
autocmd FileType make setlocal noexpandtab " Don't expand tabs into spaces in Makefiles
set nolist
set wrap linebreak " http://vimcasts.org/episodes/soft-wrapping-text/
set winwidth=79
set winheight=30
set winminheight=5
" Jump to last cursor position unless it's invalid or in an event handler
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal g`\"" |
  \ endif
" Indent if we're at the beginning of a line. Else, do completion.
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <expr> <tab> InsertTabWrapper()
inoremap <s-tab> <c-n>

let g:rainbow_active = 1 " luochen1990/rainbow
let g:javascript_plugin_flow = 1 " pangloss/vim-javascript
let g:javascript_conceal_function = "ƒ" " pangloss/vim-javascript
set conceallevel=1 " pangloss/vim-javascript

" fzf / fzf.vim
command! -bang -nargs=? -complete=dir GFiles
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)
nnoremap <c-p> :GFiles<cr>
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'up:60%')
  \           : fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'right:50%:hidden', '?'),
  \   <bang>0)
nnoremap <leader>a :Rg<cr>

" folding stuff
" nnoremap <leader>f :setlocal foldmethod=syntax<cr>
" augroup remember_folds
"   autocmd!
"   autocmd BufWinLeave * mkview
"   autocmd BufWinEnter * silent! loadview
" augroup END

" Valloric/YouCompleteMe
let g:ycm_server_python_interpreter = '/usr/local/bin/python3'
if !exists("g:ycm_semantic_triggers")
  let g:ycm_semantic_triggers = {}
endif
let g:ycm_semantic_triggers['typescript'] = ['.']
let g:ycm_semantic_triggers['elm'] = ['.']

" scrooloose/nerdtree (https://github.com/scrooloose/nerdtree#faq)
" https://superuser.com/a/1137895
nmap <Leader>r :NERDTreeFocus<cr>R<c-w>
autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if @% != '.git/COMMIT_EDITMSG' && argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Reveal the current file in the file tree when NERDTree is toggled
map <expr> <leader>n ((winnr("$") == 1) && exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) == -1)) ? ":NERDTreeFind<CR>" : ":NERDTreeToggle<CR>"
let NERDTreeShowHidden = 1 " Show hidden files
let NERDTreeAutoDeleteBuffer = 1 " Delete buffer when deleting file in NERDTree
let NERDTreeIgnore = ['\~$', '\.beam$[[file]]', '^\.git$[[dir]]'] " Ignore undo files + .git dir
let loaded_netrwPlugin = 1 " Don't load netrw plugin
autocmd FileType NERDTree noremap <buffer> <leader><leader> <nop>

" https://github.com/w0rp/ale
let g:ale_linters_explicit = 1
let g:ale_linters = { 'javascript': ['eslint'], 'jsx': ['eslint'], 'rust': ['rls'] }
let g:ale_fixers = { 'javascript': ['eslint', 'prettier'], 'jsx': ['eslint'], 'typescript': ['prettier'] }
let g:ale_fix_on_save = 1
let g:ale_completion_enabled = 1
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_delay = 1000
let g:ale_javascript_prettier_use_local_config = 1
let g:ale_javascript_prettier_options = '--single-quote'
let g:ale_rust_rls_toolchain = 'stable'
let g:ale_rust_cargo_use_clippy = executable('cargo-clippy')

" airline<>ale integration
let g:airline#extensions#ale#enabled = 1

" rust.vim
let g:rustfmt_autosave = 1
