if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/vim-plugins')
" Language packages
Plug 'pangloss/vim-javascript',   { 'for': ['javascript'] }
Plug 'vim-ruby/vim-ruby',         { 'for': ['ruby'] }
Plug 'tpope/vim-rails',           { 'for': ['ruby'] }
Plug 'tpope/vim-rake',            { 'for': ['ruby'] }
Plug 'slim-template/vim-slim',    { 'for': ['slim'] }
" Plug 'slashmili/alchemist.vim',   { 'for': ['elixir', 'eelixir'] }
Plug 'elixir-editors/vim-elixir', { 'for': ['elixir', 'eelixir'] }

" Utilities
Plug 'mileszs/ack.vim'
Plug 'Valloric/YouCompleteMe', { 'do': 'python3 install.py --js-completer' }
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'Xuyuanp/nerdtree-git-plugin', { 'on':  'NERDTreeToggle' }
Plug 'ctrlpvim/ctrlp.vim'
Plug 'w0rp/ale'
Plug 'vim-scripts/tComment'
Plug 'pbrisbin/vim-mkdir'
Plug 'christoomey/vim-run-interactive'
Plug 'janko-m/vim-test'
Plug 'tpope/vim-bundler', { 'for': ['ruby'] }
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'junegunn/vim-easy-align'
Plug 'terryma/vim-multiple-cursors'

" Themes
Plug 'morhetz/gruvbox'
call plug#end()

" Change leader to spacebar
let mapleader = ' '
nnoremap <Space> <Nop>

" Set the theme to gruvbox
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
let g:ycm_keep_logfiles = 1 " Just for debugging
let g:ycm_log_level = 'debug' " Just for debugging
let g:ycm_server_python_interpreter = '/usr/local/bin/python3'

" janko-m/vim-test
" these "Ctrl mappings" work well when Caps Lock is mapped to Ctrl
nmap <silent> <leader>tn :TestNearest<CR>
nmap <silent> <leader>tf :TestFile<CR>
nmap <silent> <leader>ts :TestSuite<CR>
nmap <silent> <leader>tl :TestLast<CR>
nmap <silent> <leader>tg :TestVisit<CR>

" christoomey/vim-run-interactive
nnoremap <leader>r :RunInInteractiveShell<space>

" junegunn/vim-easy-align
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

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
set listchars=tab:▸\ ,eol:¬
set list

" Highlight trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" scrooloose/nerdtree
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
nnoremap g<C-j> <C-w>j :let &winwidth = &columns * 7 / 10<cr>
nnoremap g<C-k> <C-w>j :let &winwidth = &columns * 7 / 10<cr>
nnoremap g<C-h> <C-w>j :let &winwidth = &columns * 7 / 10<cr>
nnoremap g<C-l> <C-w>j :let &winwidth = &columns * 7 / 10<cr>
nnoremap d<C-j> <C-w>j<C-w>c
nnoremap d<C-k> <C-w>k<C-w>c
nnoremap d<C-h> <C-w>h<C-w>c
nnoremap d<C-l> <C-w>l<C-w>c

" Chrome-style tab navigation
map <D-S-]> gt
map <D-S-[> gT

" Resizing windows
nnoremap <silent> <Leader>= :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> <Leader>- :exe "resize " . (winheight(0) * 2/3)<CR>
nnoremap <silent> <Leader>. :exe "vertical resize " . (winwidth(0) * 3/2)<CR>
nnoremap <silent> <Leader>, :exe "vertical resize " . (winwidth(0) * 2/3)<CR>

" Enable line numbers
set number
" set relativenumber
