if has('python3') " Workaround for Python 3.7.0
  silent! python3 1 " (https://github.com/vim/vim/issues/3117#issuecomment-402622616)
endif

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/vim-plugins')
  Plug 'neoclide/coc.nvim',            { 'branch': 'release' }
  Plug 'othree/yajs.vim',              { 'for': ['javascript'] }
  Plug 'HerringtonDarkholme/yats.vim', { 'for': ['typescript'] }
  Plug 'rust-lang/rust.vim',           { 'for': ['rust'] }
  Plug 'soli/prolog-vim',              { 'for': ['prolog'] }
  Plug 'cespare/vim-toml',             { 'for': ['toml'] }

  Plug 'junegunn/fzf',                 { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  Plug 'vim-scripts/tComment'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'scrooloose/nerdtree'
  Plug 'Xuyuanp/nerdtree-git-plugin'
  Plug 'junegunn/rainbow_parentheses.vim'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-surround'
call plug#end()

" Random stuff from https://github.com/garybernhardt/dotfiles/blob/master/.vimrc
set history=10000
set autoindent
set showmatch
set incsearch
set hlsearch
set ignorecase smartcase " make searches case-sensitive only if they contain upper-case characters
set cmdheight=1
set showtabline=2 " Always show tab bar at the top
" set shell=bash " This makes RVM work inside Vim. I have no idea why.
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

" set relativenumber
set number

" imap <Tab> <C-p>| " Autocomplete with tab
set complete=.,b,u,] " https://robots.thoughtbot.com/vim-you-complete-me#the-quick-rundown
set wildmode=longest,list:longest
set completeopt=menu,preview

set hidden " Automatically set buffers as 'hidden' when navigating away

" coc.nvim
set updatetime=300
set shortmess+=c
set signcolumn=yes
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)
" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')
" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)
nmap <silent> ge <Plug>(coc-diagnostic-info)
nmap <silent> gn <Plug>(coc-diagnostic-next)
nmap <silent> gp <Plug>(coc-diagnostic-prev)

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
set winheight=5 " Duplicate winheight declarations are a hack around https://stackoverflow.com/questions/22336553/why-cant-vim-process-vimrc-when-winheight-option-isnt-set-twice
set winminheight=5
set winheight=30
" Jump to last cursor position unless it's invalid or in an event handler
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal g`\"" |
  \ endif

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

" " scrooloose/nerdtree (https://github.com/scrooloose/nerdtree#faq)
" " https://superuser.com/a/1137895
" nmap <Leader>r :NERDTreeFocus<cr>R<c-w>
" autocmd StdinReadPre * let s:std_in=1
" " autocmd VimEnter * if @% != '.git/COMMIT_EDITMSG' && argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Reveal the current file in the file tree when NERDTree is toggled
map <expr> <leader>n ((winnr("$") == 1) && exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) == -1)) ? ":NERDTreeFind<CR>" : ":NERDTreeToggle<CR>"
let NERDTreeShowHidden = 1 " Show hidden files
let NERDTreeAutoDeleteBuffer = 1 " Delete buffer when deleting file in NERDTree
let NERDTreeIgnore = ['\~$', '\.beam$[[file]]', '^\.git$[[dir]]', 'target$[[dir]]']
let loaded_netrwPlugin = 1 " Don't load netrw plugin
autocmd FileType NERDTree noremap <buffer> <leader><leader> <nop>

let g:airline_powerline_fonts = 1
let g:airline_theme='angr'
let g:airline_mode_map = {
      \ '__'     : '-',
      \ 'c'      : 'C',
      \ 'i'      : 'I',
      \ 'ic'     : 'I',
      \ 'ix'     : 'I',
      \ 'n'      : 'N',
      \ 'multi'  : 'M',
      \ 'ni'     : 'N',
      \ 'no'     : 'N',
      \ 'R'      : 'R',
      \ 'Rv'     : 'R',
      \ 's'      : 'S',
      \ 'S'      : 'S',
      \ 't'      : 'T',
      \ 'v'      : 'V',
      \ 'V'      : 'V',
      \ ''     : 'V',
      \ }
let g:airline_exclude_preview = 1
let g:airline_highlighting_cache = 1
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'

let g:airline#extensions#coc#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffers_label = 'bufz'
let g:airline#extensions#tabline#tabs_label = 'tabz'
let g:airline#extensions#tabline#overflow_marker = '…'
let g:airline#extensions#tabline#buffer_idx_mode = 1
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9
nmap <leader>[ <Plug>AirlineSelectPrevTab
nmap <leader>] <Plug>AirlineSelectNextTab
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline#extensions#tabline#buffer_min_count = 2
let g:airline#extensions#tabline#tab_min_count = 2
let airline#extensions#tabline#ignore_bufadd_pat =
      \ '\c\vgundo|undotree|vimfiler|tagbar|nerd_tree'
let g:airline#extensions#whitespace#enabled = 1
let g:airline#extensions#wordcount#enabled = 1
let g:airline#extensions#wordcount#filetypes =
      \ ['asciidoc', 'help', 'mail', 'markdown', 'org', 'rst', 'tex', 'text']

" rust.vim
let g:rustfmt_autosave = 1
" let g:rust_fold = 1

" Detect .pl files as Prolog instead of Perl
let g:filetype_pl="prolog"
" Why doesn't Vim autodetect TOML files?
let g:filetype_toml="toml"

highlight CursorLine cterm=bold ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE
highlight CursorLineNr cterm=bold ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE
set cursorline
