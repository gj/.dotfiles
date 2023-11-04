if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/vim-plugins')
  Plug 'neoclide/coc.nvim', { 'commit': 'c1387b25ab10ac446873fe32dd733c6116dc6238', 'do': ':hi! link CocInlayHint Comment' }

  Plug 'junegunn/fzf',     { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'

  Plug 'vim-scripts/tComment'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-surround'
  Plug 'romainl/flattened'
  Plug 'christoomey/vim-tmux-navigator'

  Plug 'osohq/polar.vim', { 'for': ['polar'] }
call plug#end()

" Random stuff from https://github.com/garybernhardt/dotfiles/blob/master/.vimrc
set history=10000
set autoindent
set showmatch
set incsearch
set hlsearch
set ignorecase smartcase " make searches case-sensitive only if they contain upper-case characters
set cmdheight=2 " Two lines at the bottom of the screen
set showtabline=2 " Always show tab bar at the top
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
" nnoremap <leader><leader> <c-^>
if has("autocmd") " http://vimcasts.org/episodes/updating-your-vimrc-file-on-the-fly/
  autocmd! bufwritepost .vimrc source $MYVIMRC " Source the vimrc file after saving it
endif

nnoremap d<C-j> <C-w>j<C-w>c
nnoremap d<C-k> <C-w>k<C-w>c
nnoremap d<C-h> <C-w>h<C-w>c
nnoremap d<C-l> <C-w>l<C-w>c
nnoremap <BS> <C-z>

set splitbelow " Open new split panes to right and bottom
set splitright " https://robots.thoughtbot.com/vim-splits-move-faster-and-more-naturally#more-natural-split-opening

set complete=.,b,u,] " https://robots.thoughtbot.com/vim-you-complete-me#the-quick-rundown
set wildmode=longest,list:longest
set completeopt=menu,preview

set hidden " Automatically set buffers as 'hidden' when navigating away

" syntax on " Per https://github.com/neovimhaskell/haskell-vim#installation
" filetype plugin indent on " same as above

set tabstop=2 " indent 2 spaces at a time
set shiftwidth=2
set softtabstop=2
set expandtab " Use spaces instead of tabs
autocmd FileType make setlocal noexpandtab " Don't expand tabs into spaces in Makefiles
set nolist
set wrap linebreak " http://vimcasts.org/episodes/soft-wrapping-text/
" set winwidth=79
" set winheight=5 " Duplicate winheight declarations are a hack around https://stackoverflow.com/questions/22336553/why-cant-vim-process-vimrc-when-winheight-option-isnt-set-twice
" set winminheight=5
" set winheight=30

" Jump to last cursor position unless it's invalid or in an event handler
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal g`\"" |
  \ endif

let loaded_netrwPlugin = 1 " Don't load netrw plugin

let g:airline_powerline_fonts = 1
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
let g:airline#extensions#tabline#buffers_label = 'Bs'
let g:airline#extensions#tabline#tabs_label = 'Ts'
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
nmap <S-TAB> <Plug>AirlineSelectPrevTab
nmap <TAB> <Plug>AirlineSelectNextTab
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline#extensions#tabline#buffer_min_count = 2
let g:airline#extensions#tabline#tab_min_count = 2
let airline#extensions#tabline#ignore_bufadd_pat =
      \ '\c\vgundo|undotree|vimfiler|tagbar|nerd_tree'
let g:airline#extensions#whitespace#enabled = 1
let g:airline#extensions#wordcount#enabled = 1
let g:airline#extensions#wordcount#filetypes =
      \ ['asciidoc', 'help', 'mail', 'markdown', 'org', 'rst', 'tex', 'text']

" " rust.vim
" " let g:rustfmt_autosave = 1
" " let g:rust_fold = 1
" " autocmd FileType rust nnoremap <buffer> <leader>t :vert :RustTest -- --nocapture<cr>
" " autocmd FileType rust nnoremap <buffer> <leader>tl :vert :RustTest -- --nocapture<cr>
" " autocmd FileType rust nnoremap <buffer> <leader>tj :RustTest -- --nocapture<cr>
"
let g:filetype_pl="prolog" " Detect .pl files as Prolog instead of Perl
let g:filetype_toml="toml" " Why doesn't Vim autodetect TOML files?
au BufRead,BufNewFile *.lalrpop set syntax=rust

" highlight CursorLine cterm=bold
" highlight CursorLineNr cterm=bold
" set cursorline

hi HighlightedyankRegion cterm=bold

set clipboard^=unnamed

" " for normal mode - the word under the cursor
" nmap <Leader>di <Plug>VimspectorBalloonEval
" " for visual mode, the visually selected text
" xmap <Leader>di <Plug>VimspectorBalloonEval
"
" au FocusGained,BufEnter * :checktime

au FileType polar setlocal comments+=:#
au FileType polar setlocal formatoptions+=r formatoptions+=o

" fzf / fzf.vim
nnoremap <leader>a :RG<cr>
let g:fzf_layout = { 'down': '40%' }
autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction
command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

" coc.nvim
set updatetime=300
set shortmess+=c
set signcolumn=yes

nnoremap <expr><C-n> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-n>"
nnoremap <expr><C-p> coc#float#has_scroll() ? coc#float#scroll(0) : ":Files<cr>"

inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB>
      \ coc#pum#visible() ? coc#pum#prev(1) :
      \ "\<S-TAB>"
inoremap <silent><expr> <C-n>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ coc#float#has_scroll() ? coc#float#scroll(1) :
      \ "\<Right>"
inoremap <expr><C-p>
      \ coc#pum#visible() ? coc#pum#prev(1) :
      \ coc#float#has_scroll() ? coc#float#scroll(0) :
      \ "\<Left>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

" inoremap <silent><expr> <C-n> coc#pum#visible() ? coc#pum#next(1) : "\<C-n>"
" inoremap <silent><expr> <C-p> coc#pum#visible() ? coc#pum#prev(1) : "\<C-p>"

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" if has('patch8.1.1068')
"   " Use `complete_info` if your (Neo)Vim version supports it.
"   inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
" else
imap <expr> <cr> coc#pum#visible() ? "\<C-y>" : "\<cr>"
" endif

" Use `gn` and `gp` to navigate diagnostics
nmap <silent> gp <Plug>(coc-diagnostic-prev)
nmap <silent> gn <Plug>(coc-diagnostic-next)
" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gr <Plug>(coc-references)
" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  " if (index(['vim','help'], &filetype) >= 0)
  "   execute 'h '.expand('<cword>')
  " else
  call CocAction('doHover')
  " endif
endfunction

" " " Use `:Fold` to fold current buffer
" " command! -nargs=? Fold :call CocAction('fold', <f-args>)
"
" " " nnoremap <silent> <leader>y  :<C-u>CocList -A --normal yank<cr>
nmap <leader>n :CocCommand explorer<CR>
nnoremap <leader>c :CocCommand<cr>
nnoremap <silent> <leader>s :CocList symbols<cr>

" COLORSCHEME
" colorscheme flattened_light
set background=dark " not sure this does anything, but: https://vim.fandom.com/wiki/Better_colors_for_syntax_highlighting?oldid=35890
colorscheme flattened_dark
autocmd VimEnter,ColorScheme * hi! link CocInlayHint Comment

syntax on
set regexpengine=0 " this is the default; maybe setting it explicitly here ensures that no plugins have monkeyed around with the setting?
au BufRead,BufNewFile *.ts syntax sync minlines=10000 " hack to force quick syntax highlighting on large TS files
